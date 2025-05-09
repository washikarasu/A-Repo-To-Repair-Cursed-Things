/obj/machinery/computer/ship/sensors
	name = "sensors console"
	icon_keyboard = "teleport_key"
	icon_screen = "teleport"
	light_color = "#77fff8"
	circuit = /obj/item/circuitboard/sensors
	extra_view = 4
	var/obj/machinery/shipsensors/sensors
	var/stored_points

// fancy sprite
/obj/machinery/computer/ship/sensors/adv
	icon_keyboard = null
	icon_state = "adv_sensors"
	icon_screen = "adv_sensors_screen"
	light_color = "#05A6A8"

/obj/machinery/computer/ship/sensors/planet
	name = "Sensor satelite uplink console"
	var/planet_type = /obj/overmap/entity/visitable/sector/lythios43c

/obj/machinery/computer/ship/sensors/planet/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/ship/sensors/planet/LateInitialize()
	var/area/overmap/map = locate() in world
	for(var/obj/overmap/entity/visitable/sector/S in map)
		if(istype(S,planet_type))
			linked = S
			src.sensors = linked.sensors//Late init to be sure that the sensors have been set on the planet
			break

/obj/machinery/computer/ship/sensors/attempt_hook_up(obj/overmap/entity/visitable/ship/sector)
	if(!(. = ..()))
		return
	find_sensors()

/obj/machinery/computer/ship/sensors/proc/find_sensors()
	if(!linked)
		return
	for(var/obj/machinery/shipsensors/S in GLOB.machines)
		if(linked.check_ownership(S))
			sensors = S
			break

/obj/machinery/computer/ship/sensors/ui_interact(mob/user, datum/tgui/ui)
	if(!linked)
		display_reconnect_dialog(user, "sensors")
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OvermapShipSensors", "[linked.name] Sensors Control") // 420, 530
		ui.open()

/obj/machinery/computer/ship/sensors/ui_data(mob/user, datum/tgui/ui)
	var/list/data = list()

	data["viewing"] = viewing_overmap(user)
	data["on"] = 0
	data["range"] = "N/A"
	data["health"] = 0
	data["max_health"] = 0
	data["heat"] = 0
	data["critical_heat"] = 0
	data["status"] = "MISSING"
	data["contacts"] = list()
	data["points"] = 0

	if(sensors)
		data["on"] = sensors.use_power
		data["range"] = sensors.range
		data["health"] = sensors.health
		data["max_health"] = sensors.max_health
		data["heat"] = sensors.heat
		data["critical_heat"] = sensors.critical_heat
		if(sensors.health == 0)
			data["status"] = "DESTROYED"
		else if(!sensors.powered())
			data["status"] = "NO POWER"
		else if(!sensors.in_vacuum())
			data["status"] = "VACUUM SEAL BROKEN"
		else
			data["status"] = "OK"
		var/list/contacts = list()
		for(var/obj/overmap/O in view(7,linked))
			if(linked == O)
				continue
			if(!O.scannable)
				continue
			var/bearing = round(90 - arctan(O.x - linked.x, O.y - linked.y),5)
			if(bearing < 0)
				bearing += 360
			contacts.Add(list(list("name"=O.name, "ref"="\ref[O]", "bearing"=bearing)))
		data["contacts"] = contacts
		data["points"] = stored_points

	return data

/obj/machinery/computer/ship/sensors/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	if(!linked)
		return FALSE

	switch(action)
		if("viewing")
			if(usr && !isAI(usr))
				viewing_overmap(usr) ? unlook(usr) : look(usr)
			. = TRUE

		if("link")
			find_sensors()
			. = TRUE

		if("scan")
			var/obj/overmap/O = locate(params["scan"])
			if(istype(O) && !QDELETED(O) && (O in view(7,linked)))
				var/obj/item/paper/P = new /obj/item/paper(get_turf(src))
				P.name = "paper (Sensor Scan - [O])"
				P.info = replacetext(html_encode(O.get_scan_data(usr)), "\n", "<BR>")
				P.init_parsepencode(P.info)
				playsound(src, "sound/machines/printer.ogg", 30, 1)
			. = TRUE

	if(sensors)
		switch(action)
			if("range")
				var/nrange = input("Set new sensors range", "Sensor range", sensors.range) as num|null
				if(ui_status(usr, ui.state) != UI_INTERACTIVE)
					return FALSE
				if(nrange)
					sensors.set_range(clamp(nrange, 1, world.view))
				. = TRUE
			if("toggle_sensor")
				sensors.toggle()
				. = TRUE

	if(. && !issilicon(usr))
		playsound(src, SFX_ALIAS_TERMINAL, 50, 1)

/obj/machinery/computer/ship/sensors/process()
	..()
	if(!linked)
		return
	if(sensors && sensors.use_power && sensors.powered())
		var/sensor_range = round(sensors.range*1.5) + 1
		linked.set_light(sensor_range + 0.5, 4)
	else
		linked.set_light(0)

/obj/machinery/shipsensors
	name = "sensors suite"
	desc = "Long range gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "sensors"
	anchored = TRUE
	integrity_flags = INTEGRITY_INDESTRUCTIBLE

	var/health = 200
	var/max_health = 200

	var/critical_heat = 50 // sparks and takes damage when active & above this heat
	var/heat_reduction = 1.5 // mitigates this much heat per tick
	var/heat = 0
	var/range = 1

	idle_power_usage = 5000
	var/heat_factor = 1

/obj/machinery/shipsensors/attackby(obj/item/W, mob/user)
	var/damage = max_health - health
	if(damage && istype(W, /obj/item/weldingtool))

		var/obj/item/weldingtool/WT = W

		if(!WT.isOn())
			return

		if(WT.remove_fuel(0,user))
			to_chat(user, "<span class='notice'>You start repairing the damage to [src].</span>")
			playsound(src, 'sound/items/Welder.ogg', 100, 1)
			if(do_after(user, max(5, damage / 5), src) && WT && WT.isOn())
				to_chat(user, "<span class='notice'>You finish repairing the damage to [src].</span>")
				take_damage_legacy(-damage)
		else
			to_chat(user, "<span class='notice'>You need more welding fuel to complete this task.</span>")
			return
		return
	..()

/obj/machinery/shipsensors/proc/in_vacuum()
	var/turf/T=get_turf(src)
	if(istype(T))
		var/datum/gas_mixture/environment = T.return_air()
		// this is a hardcoded constant now
		if(environment && environment.return_pressure() > MINIMUM_MEANINGFUL_PRESSURE_VACUUM)
			return 0
	return 1

/obj/machinery/shipsensors/update_icon()
	if(use_power)
		icon_state = "sensors"
	else
		icon_state = "sensors_off"
	..()

/obj/machinery/shipsensors/examine(mob/user, dist)
	. = ..()
	if(health <= 0)
		. += "<span class='danger'>It is wrecked.</span>"
	else if(health < max_health * 0.25)
		. += "<span class='danger'>It looks like it's about to break!</span>"
	else if(health < max_health * 0.5)
		. += "<span class='danger'>It looks seriously damaged!</span>"
	else if(health < max_health * 0.75)
		. += "It shows signs of damage!"

/obj/machinery/shipsensors/on_bullet_act(obj/projectile/proj, impact_flags, list/bullet_act_args)
	. = ..()
	take_damage_legacy(proj.get_structure_damage())

/obj/machinery/shipsensors/proc/toggle()
	if(!use_power && (health == 0 || !in_vacuum()))
		return // No turning on if broken or misplaced.
	if(!use_power) //need some juice to kickstart
		use_power_oneoff(idle_power_usage*5)
	update_use_power(!use_power)
	update_icon()

/obj/machinery/shipsensors/process(delta_time)
	if(use_power) //can't run in non-vacuum
		if(!in_vacuum())
			toggle()
		if(heat > critical_heat)
			src.visible_message("<span class='danger'>\The [src] violently spews out sparks!</span>")
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread()
			s.set_up(3, 1, src)
			s.start()

			take_damage_legacy(rand(10,50))
			toggle()
		heat += (idle_power_usage/15000) * heat_factor

	if (heat > 0)
		heat = max(0, heat - heat_reduction)

/obj/machinery/shipsensors/legacy_ex_act()
	return

/obj/machinery/shipsensors/power_change()
	. = ..()
	if(use_power && !powered())
		toggle()

/obj/machinery/shipsensors/proc/set_range(nrange)
	range = nrange
	change_power_consumption(1500 * (range**2), USE_POWER_IDLE) //Exponential increase, also affects speed of overheating

/obj/machinery/shipsensors/emp_act(severity)
	if(!use_power)
		return
	take_damage_legacy(20/severity)
	toggle()

/obj/machinery/shipsensors/proc/take_damage_legacy(value)
	health = min(max(health - value, 0),max_health)
	if(use_power && health == 0)
		toggle()

/obj/machinery/shipsensors/weak
	heat_reduction = 0.2
	desc = "Miniturized gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."

/obj/machinery/shipsensors/uplink
	name = "sensors uplink"
	desc = "A high power uplink, connecting to a satelite with a high power sensor array and a sophisticated cooling system."
	var/planet_type = /obj/overmap/entity/visitable/sector/lythios43c
	heat_factor = 0.1//Much much lower, since we are a cool sensor sat.

/obj/machinery/shipsensors/uplink/in_vacuum()
	return TRUE

/obj/machinery/shipsensors/uplink/Initialize(mapload)
	. = ..()
	var/area/overmap/map = locate() in world
	for(var/obj/overmap/entity/visitable/sector/S in map)
		if(istype(S,planet_type))
			S.sensors = src

