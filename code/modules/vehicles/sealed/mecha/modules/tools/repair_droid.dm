/obj/item/vehicle_module/repair_droid
	name = "repair droid"
	desc = "Automated repair droid. Scans exosuit for damage and repairs it. Can fix almost any type of external or internal damage."
	icon_state = "repair_droid"
	origin_tech = list(TECH_MAGNET = 3, TECH_DATA = 3)
	equip_cooldown = 20
	energy_drain = 100
	range = 0
	var/health_boost = 2
	var/datum/global_iterator/pr_repair_droid
	var/icon/droid_overlay
	var/list/repairable_damage = list(MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH)

	step_delay = 1

	equip_type = EQUIP_HULL

/obj/item/vehicle_module/repair_droid/Initialize(mapload)
	. = ..()
	pr_repair_droid = new /datum/global_iterator/mecha_repair_droid(list(src),0)
	pr_repair_droid.set_delay(equip_cooldown)
	return

/obj/item/vehicle_module/repair_droid/Destroy()
	qdel(pr_repair_droid)
	pr_repair_droid = null
	return ..()

/obj/item/vehicle_module/repair_droid/add_equip_overlay(obj/vehicle/sealed/mecha/M as obj)
	..()
	if(!droid_overlay)
		droid_overlay = new(src.icon, icon_state = "repair_droid")
	M.add_overlay(droid_overlay)
	return

/obj/item/vehicle_module/repair_droid/destroy()
	chassis.cut_overlay(droid_overlay)
	..()
	return

/obj/item/vehicle_module/repair_droid/detach()
	chassis.cut_overlay(droid_overlay)
	pr_repair_droid.stop()
	..()
	return

/obj/item/vehicle_module/repair_droid/get_equip_info()
	if(!chassis) return
	return "<span style=\"color:[equip_ready?"#0f0":"#f00"];\">*</span>&nbsp;[src.name] - <a href='?src=\ref[src];toggle_repairs=1'>[pr_repair_droid.active()?"Dea":"A"]ctivate</a>"


/obj/item/vehicle_module/repair_droid/Topic(href, href_list)
	..()
	if(href_list["toggle_repairs"])
		chassis.cut_overlay(droid_overlay)
		if(pr_repair_droid.toggle())
			droid_overlay = new(src.icon, icon_state = "repair_droid_a")
			log_message("Activated.")
		else
			droid_overlay = new(src.icon, icon_state = "repair_droid")
			log_message("Deactivated.")
			set_ready_state(1)
		chassis.add_overlay(droid_overlay)
		send_byjax(chassis.occupant_legacy,"exosuit.browser","\ref[src]",src.get_equip_info())
	return


/datum/global_iterator/mecha_repair_droid

/datum/global_iterator/mecha_repair_droid/process(var/obj/item/vehicle_module/repair_droid/RD as obj)
	if(!RD.chassis)
		stop()
		RD.set_ready_state(1)
		return
	var/health_boost = RD.health_boost
	var/repaired = 0
	if(RD.chassis.hasInternalDamage(MECHA_INT_SHORT_CIRCUIT))
		health_boost *= -2
	else if(RD.chassis.hasInternalDamage() && prob(15))
		for(var/int_dam_flag in RD.repairable_damage)
			if(RD.chassis.hasInternalDamage(int_dam_flag))
				RD.chassis.clearInternalDamage(int_dam_flag)
				repaired = 1
				break

	var/obj/item/vehicle_component/AC = RD.chassis.internal_components[MECH_ARMOR]
	var/obj/item/vehicle_component/HC = RD.chassis.internal_components[MECH_HULL]

	var/damaged_armor = AC.integrity < AC.integrity_max

	var/damaged_hull = HC.integrity < HC.integrity_max

	if(health_boost<0 || RD.chassis.integrity < initial(RD.chassis.integrity) || damaged_armor || damaged_hull)
		RD.chassis.integrity += min(health_boost, initial(RD.chassis.integrity)-RD.chassis.integrity)

		if(AC)
			AC.adjust_integrity_mecha(round(health_boost * 0.5, 0.5))

		if(HC)
			HC.adjust_integrity_mecha(round(health_boost * 0.5, 0.5))

		repaired = 1
	if(repaired)
		if(RD.chassis.use_power(RD.energy_drain))
			RD.set_ready_state(0)
		else
			stop()
			RD.set_ready_state(1)
			return
	else
		RD.set_ready_state(1)
	return
