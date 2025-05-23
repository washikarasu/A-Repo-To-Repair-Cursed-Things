/obj/vehicle/sealed/mecha
	var/max_micro_utility_equip = 0
	var/max_micro_weapon_equip = 0
	var/list/micro_utility_equipment = new
	var/list/micro_weapon_equipment = new
	var/size_requirement = 0.5



/obj/vehicle/sealed/mecha/micro
	icon = 'icons/mecha/micro.dmi'
	force = 10 //still a robot
	anchored = 0 //light enough to push and pull, but you still can't just walk past them. Like people on non-help.
	opacity = 0 //small enough to see around, like people.
	step_energy_drain = 2 // They're light and small. A compact is gonna get better MPG than a truck.
	var/melee_cooldown = 10
	var/melee_can_hit = 1
	var/list/destroyable_obj = list(/obj/vehicle/sealed/mecha, /obj/structure/window, /obj/structure/grille, /turf/simulated/wall)
	internal_damage_threshold = 50
	maint_access = 0
	max_hull_equip = 1
	max_weapon_equip = 0
	max_utility_equip = 0
	max_universal_equip = 0
	max_special_equip = 1
	max_micro_utility_equip = 1
	max_micro_weapon_equip = 1
	//add_req_access = 0
	//operation_req_access = list(ACCESS_SECURITY_HOS)
	damage_absorption = list("brute"=1,"fire"=1,"bullet"=1,"laser"=1,"energy"=1,"bomb"=1)
	var/am = "d3c2fbcadca903a41161ccc9df9cf948"
	damage_minimum = 0				//Incoming damage lower than this won't actually deal damage. Scrapes shouldn't be a real thing.
	minimum_penetration = 0		//Incoming damage won't be fully applied if you don't have at least 20. Almost all AP clears this.

/obj/vehicle/sealed/mecha/micro/melee_action(target as obj|mob|turf)
	if(internal_damage&MECHA_INT_CONTROL_LOST)
		target = SAFEPICK(oview(1,src))
	if(!melee_can_hit || !istype(target, /atom)) return
	if(istype(target, /mob/living))
		var/mob/living/M = target
		if(src.occupant_legacy.a_intent == INTENT_HARM)
			playsound(src, 'sound/weapons/punch4.ogg', 50, 1)
			if(damtype == "brute")
				step_away(M,src,15)

			if(istype(target, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = target
	//			if (M.integrity <= 0) return

				var/obj/item/organ/external/temp = H.get_organ(pick(BP_TORSO, BP_TORSO, BP_TORSO, BP_HEAD))
				if(temp)
					var/update = 0
					switch(damtype)
						if("brute")
							temp.inflict_bodypart_damage(
								brute = rand(force / 2, force),
							)
						if("fire")
							temp.inflict_bodypart_damage(
								burn = rand(force / 2, force),
							)
						if("tox")
							if(H.reagents)
								if(H.reagents.get_reagent_amount("carpotoxin") + force < force*2)
									H.reagents.add_reagent("carpotoxin", force)
								if(H.reagents.get_reagent_amount("cryptobiolin") + force < force*2)
									H.reagents.add_reagent("cryptobiolin", force)
						else
							return
					if(update)	H.update_damage_overlay()
				H.update_health()

			else
				switch(damtype)
					if("brute")
						M.afflict_unconscious(20 * 1)
						M.take_overall_damage(rand(force/2, force))
					if("fire")
						M.take_overall_damage(0, rand(force/2, force))
					if("tox")
						if(M.reagents)
							if(M.reagents.get_reagent_amount("carpotoxin") + force < force*2)
								M.reagents.add_reagent("carpotoxin", force)
							if(M.reagents.get_reagent_amount("cryptobiolin") + force < force*2)
								M.reagents.add_reagent("cryptobiolin", force)
					else
						return
				M.update_health()
			src.occupant_message("You hit [target].")
			src.visible_message("<font color='red'><b>[src.name] hits [target].</b></font>")
		else
			step_away(M,src)
			src.occupant_message("You push [target] out of the way.")
			src.visible_message("[src] pushes [target] out of the way.")

		melee_can_hit = 0
		if(do_after(melee_cooldown))
			melee_can_hit = 1
		return

	else
		if(damtype == "brute")
			for(var/target_type in src.destroyable_obj)
				if(istype(target, target_type) && hascall(target, "attackby"))
					src.occupant_message("You hit [target].")
					src.visible_message("<font color='red'><b>[src.name] hits [target]</b></font>")
					if(!istype(target, /turf/simulated/wall))
						target:attackby(src,src.occupant_legacy)
					else
						playsound(src, 'sound/weapons/smash.ogg', 50, 1)
					melee_can_hit = 0
					if(do_after(melee_cooldown))
						melee_can_hit = 1
					break
	return


/obj/vehicle/sealed/mecha/micro/Topic(href,href_list)
	..()
	var/datum/topic_input/top_filter = new (href,href_list)
	if(top_filter.get("close"))
		am = null
		return

// override move_inside() so only micro crew can use them

/obj/vehicle/sealed/mecha/micro/mob_can_enter(mob/entering, datum/event_args/actor/actor, silent, suppressed)
	var/mob/living/carbon/C = entering
	if (C.size_multiplier > size_requirement)
		to_chat(C, "<span class='warning'>You can't fit in this suit!</span>")
		return FALSE
	else
		return ..()

/obj/vehicle/sealed/mecha/micro/move_inside_passenger()
	var/mob/living/carbon/C = usr
	if (C.size_multiplier > size_requirement)
		to_chat(C, "<span class='warning'>You can't fit in this suit!</span>")
		return
	else
		..()

// override move/turn procs so they play more appropriate sounds. Placeholder sounds for now, but mechmove04 at least sounds like tracks for the poleat.

/obj/vehicle/sealed/mecha/micro/mechturn(direction)
	setDir(direction)
	playsound(src,'sound/mecha/mechmove03.ogg',40,1)
	return 1

/obj/vehicle/sealed/mecha/micro/mechstep(direction)
	var/result = step(src,direction)
	if(result)
		playsound(src,'sound/mecha/mechmove04.ogg',40,1)
	return result

/obj/vehicle/sealed/mecha/micro/mechsteprand()
	var/result = step_rand(src)
	if(result)
		playsound(src,'sound/mecha/mechmove04.ogg',40,1)
	return result

/obj/effect/decal/mecha_wreckage/micro
	icon = 'icons/mecha/micro.dmi'

