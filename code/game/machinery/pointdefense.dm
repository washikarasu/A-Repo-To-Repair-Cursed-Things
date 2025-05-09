//
// Control computer for point defense batteries.
// Handles control UI, but also coordinates their fire to avoid overkill.
//

GLOBAL_LIST_BOILERPLATE(pointdefense_controllers, /obj/machinery/pointdefense_control)
GLOBAL_LIST_BOILERPLATE(pointdefense_turrets, /obj/machinery/power/pointdefense)

/obj/machinery/pointdefense_control
	name = "fire assist mainframe"
	desc = "A specialized computer designed to synchronize a variety of weapon systems and a vessel's astronav data."
	description_info = "To connect the mainframe to turrets, use a multitool to set the ident tag to that of the turrets."
	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "control"
	density = TRUE
	anchored = TRUE
	circuit = /obj/item/circuitboard/pointdefense_control
	var/list/targets = list()  // Targets being engaged by associated batteries
	var/id_tag = null

/obj/machinery/pointdefense_control/Initialize(mapload)
	. = ..()
	if(id_tag)
		//No more than 1 controller please.
		for(var/thing in GLOB.pointdefense_controllers)
			var/obj/machinery/pointdefense_control/PC = thing
			if(PC != src && PC.id_tag == id_tag)
				warning("Two [src] with the same id_tag of [id_tag]")
				id_tag = null

/obj/machinery/pointdefense_control/get_description_interaction(mob/user)
	. = ..()
	if(!id_tag)
		. += "[desc_panel_image("multitool", user)]to set ident tag"

/obj/machinery/pointdefense_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PointDefenseControl") // 400, 600
		ui.open()

/obj/machinery/pointdefense_control/attack_hand(mob/user, datum/event_args/actor/clickchain/e_args)
	if(..())
		return TRUE
	ui_interact(user)
	return TRUE

/obj/machinery/pointdefense_control/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	if(action == "toggle_active")
		var/obj/machinery/power/pointdefense/PD = locate(params["target"])
		if(!istype(PD))
			return FALSE

		//if(!lan || !lan.is_connected(PD))
		if(PD.id_tag != id_tag)
			return FALSE

		if(!(get_z(PD) in GetConnectedZlevels(get_z(src))))
			to_chat(usr, "<span class='warning'>[PD] is not within control range.</span>")
			return FALSE

		if(!PD.Activate()) //Activate() whilst the device is active will return false.
			PD.Deactivate()
		return TRUE

/obj/machinery/pointdefense_control/ui_data(mob/user, datum/tgui/ui)
	var/list/data = list()
	data["id"] = id_tag
	var/list/turrets = list()
	if(id_tag)
		var/list/connected_z_levels = GetConnectedZlevels(get_z(src))
		for(var/i = 1 to LAZYLEN(GLOB.pointdefense_turrets))
			var/obj/machinery/power/pointdefense/PD = GLOB.pointdefense_turrets[i]
			if(!(PD.id_tag == id_tag && (get_z(PD) in connected_z_levels)))
				continue
			var/list/turret = list()
			turret["id"] =          "#[i]"
			turret["ref"] =         "\ref[PD]"
			turret["active"] =       PD.active
			turret["effective_range"] = PD.active ? "[PD.kill_range] meter\s" : "OFFLINE."
			turret["reaction_wheel_delay"] = PD.active ? "[(PD.rotation_speed / (1 SECONDS))] second\s" : "OFFLINE."
			turret["recharge_time"] = PD.active ? "[(PD.charge_cooldown / (1 SECONDS))] second\s" : "OFFLINE."

			turrets += list(turret)

	data["turrets"] = turrets
	return data

/obj/machinery/pointdefense_control/attackby(obj/item/W, mob/user)
	if(W?.is_multitool())
		var/new_ident = input(user, "Enter a new ident tag.", "[src]", id_tag) as null|text
		if(new_ident && new_ident != id_tag && user.Adjacent(src) && CanInteract(user, GLOB.physical_state))
			// Check for duplicate controllers with this ID
			for(var/thing in GLOB.pointdefense_controllers)
				var/obj/machinery/pointdefense_control/PC = thing
				if(PC != src && PC.id_tag == new_ident)
					to_chat(user, "<span class='warning'>The [new_ident] network already has a controller.</span>")
					return
			to_chat(user, "<span class='notice'>You register [src] with the [new_ident] network.</span>")
			id_tag = new_ident
		return
	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	if(default_part_replacement(user, W))
		return
	return ..()

//
// The acutal point defense battery
//

/obj/machinery/power/pointdefense
	name = "\improper point defense battery"
	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense"
	desc = "A Kuiper pattern anti-meteor battery. Capable of destroying most threats in a single salvo."
	description_info = "Must have the same ident tag as a fire assist mainframe on the same facility. Use a multitool to set the ident tag."
	density = TRUE
	anchored = TRUE
	circuit = /obj/item/circuitboard/pointdefense
	idle_power_usage = 0.1 KILOWATTS
	active_power_usage = 1 KILOWATTS
	appearance_flags = PIXEL_SCALE
	var/active = TRUE
	var/charge_cooldown = 1 SECOND  //time between it can fire at different targets
	var/last_shot = 0
	var/kill_range = 18
	var/rotation_speed = 0.25 SECONDS  //How quickly we turn to face threats
	var/engaging = null // The meteor we're shooting at
	var/id_tag = null

/obj/machinery/power/pointdefense/Initialize(mapload)
	. = ..()
	if(anchored)
		connect_to_network()
	update_icon()
	var/image/I = image(icon, icon_state = "[icon_state]_under")
	I.appearance_flags |= RESET_TRANSFORM
	underlays += I

/obj/machinery/power/pointdefense/examine(mob/user, dist)
	. = ..()
	if(powernet)
		. += "It is connected to a power cable below."

/obj/machinery/power/pointdefense/get_description_interaction(mob/user)
	. = ..()
	if(!id_tag)
		. += "[desc_panel_image("multitool", user)]to set ident tag and connect to a mainframe."

/obj/machinery/power/pointdefense/update_icon_state()
	if(!active || !id_tag || inoperable())
		icon_state = "[initial(icon_state)]_off"
	else
		icon_state = initial(icon_state)
	return ..()

/obj/machinery/power/pointdefense/default_unfasten_wrench(var/mob/user, var/obj/item/W, var/time)
	if((. = ..()))
		src.transform = null // Reset rotation if we're anchored/unanchored

////////// This machine is willing to take power from cables OR APCs.  Handle NOPOWER stat specially here! ////////

/obj/machinery/power/pointdefense/connect_to_network()
	if((. = ..()))
		machine_stat &= ~NOPOWER // We now ignore APC power
		update_icon()

/obj/machinery/power/pointdefense/disconnect_from_network()
	if((. = ..()))
		power_change() // We're back on APC power.

/obj/machinery/power/pointdefense/power_change()
	if(powernet)
		return // We don't care, we are cable powered anyway
	var/old_stat = machine_stat
	..()
	if(old_stat != machine_stat)
		update_icon()

// Decide where to get the power to fire from
/obj/machinery/power/pointdefense/use_power_oneoff(amount, chan = CURRENT_CHANNEL)
	if(powernet)
		return draw_power(amount * 0.001) * 1000
	// We are not connected to a powernet, so we want APC power.  Reproduce that code here since this is weird.
	if(chan == CURRENT_CHANNEL)
		chan = power_channel
	var/area/A = get_area(src)	// make sure it's in an area
	if(!A || !A.powered(chan))	// and that the area is powered
		return 0				// if not, then not powered
	return A.use_power_oneoff(amount, chan)

// Find controller with the same tag on connected z levels (if any)
/obj/machinery/power/pointdefense/proc/get_controller()
	if(!id_tag)
		return null
	var/list/connected_z_levels = GetConnectedZlevels(get_z(src))
	for(var/thing in GLOB.pointdefense_controllers)
		var/obj/machinery/pointdefense_control/PDC = thing
		if(PDC.id_tag == id_tag && (get_z(PDC) in connected_z_levels))
			return PDC

/obj/machinery/power/pointdefense/attackby(obj/item/W, mob/user)
	if(W?.is_multitool())
		var/new_ident = input(user, "Enter a new ident tag.", "[src]", id_tag) as null|text
		if(new_ident && new_ident != id_tag && user.Adjacent(src) && CanInteract(user, GLOB.physical_state))
			to_chat(user, SPAN_NOTICE("You register [src] with \the [new_ident] network."))
			id_tag = new_ident
		return
	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	if(default_part_replacement(user, W))
		return
	if(default_unfasten_wrench(user, W, 40))
		return
	return ..()

//Guns cannot shoot through hull or generally dense turfs.
/obj/machinery/power/pointdefense/proc/space_los(meteor)
	for(var/turf/T in getline(src,meteor))
		if(T.density)
			return FALSE
	return TRUE

/obj/machinery/power/pointdefense/proc/Shoot(datum/weakref/target)
	var/obj/effect/meteor/M = target.resolve()
	if(!istype(M))
		engaging = null
		return
	engaging = target
	var/Angle = round(get_visual_angle(src,M))
	var/matrix/rot_matrix = matrix()
	rot_matrix.Turn(Angle)
	addtimer(CALLBACK(src, PROC_REF(finish_shot), target), rotation_speed)
	animate(src, transform = rot_matrix, rotation_speed, easing = SINE_EASING)

	setDir(arctan(transform.b, transform.a) > 0 ? NORTH : SOUTH)

/obj/machinery/power/pointdefense/proc/finish_shot(datum/weakref/target)

	var/obj/machinery/pointdefense_control/PC = get_controller()
	engaging = null
	PC.targets -= target

	last_shot = world.time
	var/obj/effect/meteor/M = target.resolve()
	if(!istype(M))
		return
	if(use_power_oneoff(active_power_usage) < active_power_usage)
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		visible_message("[src] sputters as browns out while attempting to fire.")
		flick(src, "[initial(icon_state)]_off")
		return
	//We throw a laser but it doesnt have to hit for meteor to explode
	var/obj/projectile/beam/pointdefense/beam = new(get_turf(src))
	playsound(src, 'sound/weapons/mandalorian.ogg', 75, 1)
	beam.launch_projectile_legacy(target = M.loc, user = src)

/obj/machinery/power/pointdefense/process()
	..()
	if(!anchored || machine_stat & (NOPOWER|BROKEN))
		return
	if(!active)
		return
	/*
	var/desiredir = arctan(transform.b, transform.a) > 0 ? NORTH : SOUTH
	if(dir != desiredir)
		setDir(desiredir)
	*/

	if(LAZYLEN(GLOB.meteor_list) > 0)
		find_and_shoot()

/obj/machinery/power/pointdefense/proc/find_and_shoot()
	// There ARE meteors to shoot
	if(LAZYLEN(GLOB.meteor_list) == 0)
		return
	// We can shoot
	if(engaging || ((world.time - last_shot) < charge_cooldown))
		return

	var/obj/machinery/pointdefense_control/PC = get_controller()
	if(!istype(PC))
		return

	// Compile list of known targets
	var/list/existing_targets = list()
	for(var/datum/weakref/WR in PC.targets)
		var/obj/effect/meteor/M = WR.resolve()
		existing_targets += M

	// First, try and acquire new targets
	var/list/potential_targets = GLOB.meteor_list.Copy() - existing_targets
	for(var/obj/effect/meteor/M in potential_targets)
		if(targeting_check(M))
			var/target = M
			PC.targets += target
			engaging = target
			Shoot(target)
			return

	// Then, focus fire on existing targets
	for(var/obj/effect/meteor/M in existing_targets)
		if(targeting_check(M))
			var/target = M
			engaging = target
			Shoot(target)
			return

/obj/machinery/power/pointdefense/proc/targeting_check(obj/effect/meteor/M)
	// Target in range
	var/list/connected_z_levels = GetConnectedZlevels(get_z(src))
	if(!(M.z in connected_z_levels))
		return FALSE
	if(get_dist(M, src) > kill_range)
		return FALSE
	// If we can shoot it, then shoot
	if(emagged || !space_los(M))
		return FALSE

	return TRUE

/obj/machinery/power/pointdefense/RefreshParts()
	. = ..()
	// Calculates an average rating of components that affect shooting rate
	var/shootrate_divisor = total_component_rating_of_type(/obj/item/stock_parts/capacitor)

	charge_cooldown = 2 SECONDS / (shootrate_divisor ? shootrate_divisor : 1)

	//Calculate max shooting range
	var/killrange_multiplier = total_component_rating_of_type(/obj/item/stock_parts/capacitor)
	killrange_multiplier += 1.5 * total_component_rating_of_type(/obj/item/stock_parts/scanning_module)

	kill_range = 10 + 4 * killrange_multiplier

	var/rotation_divisor = total_component_rating_of_type(/obj/item/stock_parts/manipulator)
	rotation_speed = 0.5 SECONDS / (rotation_divisor ? rotation_divisor : 1)

/obj/machinery/power/pointdefense/proc/Activate()
	if(active)
		return FALSE

	playsound(src, 'sound/weapons/flash.ogg', 100, FALSE)
	update_use_power(USE_POWER_IDLE)
	active = TRUE
	update_icon()
	return TRUE

/obj/machinery/power/pointdefense/proc/Deactivate()
	if(!active)
		return FALSE
	playsound(src, 'sound/machines/apc_nopower.ogg', 50, FALSE)
	update_use_power(USE_POWER_OFF)
	active = FALSE
	update_icon()
	return TRUE
