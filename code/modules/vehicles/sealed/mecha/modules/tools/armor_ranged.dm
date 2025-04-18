/obj/item/vehicle_module/antiproj_armor_booster
	name = "\improper RW armor booster"
	desc = "Ranged-weaponry armor booster. Boosts exosuit armor against ranged attacks. Completely blocks taser shots, but requires energy to operate."
	icon_state = "mecha_abooster_proj"
	origin_tech = list(TECH_MATERIAL = 4)
	equip_cooldown = 10
	energy_drain = 50
	range = 0
	var/deflect_coeff = 1.15
	var/damage_coeff = 0.8

	step_delay = 1

	equip_type = EQUIP_HULL

/obj/item/vehicle_module/antiproj_armor_booster/handle_projectile_contact(var/obj/projectile/Proj, var/inc_damage)
	if(!action_checks(src))
		return inc_damage
	if(prob(chassis.deflect_chance*deflect_coeff))
		chassis.occupant_message("<span class='notice'>The armor deflects incoming projectile.</span>")
		chassis.visible_message("The [chassis.name] armor deflects the projectile.")
		chassis.log_append_to_last("Armor saved.")
		inc_damage = 0
	else
		inc_damage *= src.damage_coeff
	set_ready_state(0)
	chassis.use_power(energy_drain)
	spawn()
		do_after_cooldown()
	return max(0, inc_damage)

/obj/item/vehicle_module/antiproj_armor_booster/handle_ranged_contact(var/obj/A, var/inc_damage = 0)
	if(!action_checks(A))
		return inc_damage
	if(prob(chassis.deflect_chance*deflect_coeff))
		chassis.occupant_message("<span class='notice'>The [A] bounces off the armor.</span>")
		chassis.visible_message("The [A] bounces off \the [chassis]'s armor")
		chassis.log_append_to_last("Armor saved.")
		inc_damage = 0
	else if(istype(A, /obj))
		inc_damage *= damage_coeff
	set_ready_state(0)
	chassis.use_power(energy_drain)
	spawn()
		do_after_cooldown()
	return max(0, inc_damage)

/obj/item/vehicle_module/antiproj_armor_booster/get_equip_info()
	if(!chassis) return
	return "<span style=\"color:[equip_ready?"#0f0":"#f00"];\">*</span>&nbsp;[src.name]"

/*
/obj/item/vehicle_module/antiproj_armor_booster/can_attach(obj/vehicle/sealed/mecha/M as obj)
	if(..())
		if(!M.proc_res["dynbulletdamage"] && !M.proc_res["dynhitby"])
			return 1
	return 0

/obj/item/vehicle_module/antiproj_armor_booster/attach(obj/vehicle/sealed/mecha/M as obj)
	..()
	chassis.proc_res["dynbulletdamage"] = src
	chassis.proc_res["dynhitby"] = src
	return

/obj/item/vehicle_module/antiproj_armor_booster/detach()
	chassis.proc_res["dynbulletdamage"] = null
	chassis.proc_res["dynhitby"] = null
	..()
	return

/obj/item/vehicle_module/antiproj_armor_booster/proc/dynbulletdamage(var/obj/projectile/Proj)
	if(istype(Proj, /obj/projectile/test))
		return // Don't care about test projectiles, just what comes after them
	if(!action_checks(src))
		return chassis.dynbulletdamage(Proj)
	if(prob(chassis.deflect_chance*deflect_coeff))
		chassis.occupant_message("<span class='notice'>The armor deflects incoming projectile.</span>")
		chassis.visible_message("The [chassis.name] armor deflects the projectile")
		chassis.log_append_to_last("Armor saved.")
	else
		chassis.take_damage_legacy(round(Proj.damage*src.damage_coeff),Proj.damage_flag)
		chassis.check_for_internal_damage(list(MECHA_INT_FIRE,MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH,MECHA_INT_CONTROL_LOST))
		Proj.on_hit(chassis)
	set_ready_state(0)
	chassis.use_power(energy_drain)
	do_after_cooldown()
	return

/obj/item/vehicle_module/antiproj_armor_booster/proc/dynhitby(atom/movable/A)
	if(!action_checks(A))
		return chassis.dynhitby(A)
	if(prob(chassis.deflect_chance*deflect_coeff) || istype(A, /mob/living) || istype(A, /obj/item/vehicle_tracking_beacon))
		chassis.occupant_message("<span class='notice'>The [A] bounces off the armor.</span>")
		chassis.visible_message("The [A] bounces off the [chassis] armor")
		chassis.log_append_to_last("Armor saved.")
		if(istype(A, /mob/living))
			var/mob/living/M = A
			M.take_random_targeted_damage(brute = 10)
	else if(istype(A, /obj))
		var/obj/O = A
		if(O.throw_force)
			chassis.take_damage_legacy(round(O.throw_force*damage_coeff))
			chassis.check_for_internal_damage(list(MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH,MECHA_INT_CONTROL_LOST))
	set_ready_state(0)
	chassis.use_power(energy_drain)
	do_after_cooldown()
	return
*/
