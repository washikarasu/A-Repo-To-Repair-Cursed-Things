/datum/technomancer/spell/chain_lightning
	name = "Chain Lightning"
	desc = "This dangerous function shoots lightning that will strike someone, then bounce to a nearby person.  Be careful that \
	it does not bounce to you.  The lighting prefers to bounce to people with the least resistance to electricity.  It will \
	strike up to four targets, including yourself if conditions allow it to occur.  Lightning functions cannot miss due to distance."
	cost = 150
	obj_path = /obj/item/spell/projectile/chain_lightning
	ability_icon_state = "tech_chain_lightning"
	category = OFFENSIVE_SPELLS

/obj/item/spell/projectile/chain_lightning
	name = "chain lightning"
	icon_state = "chain_lightning"
	desc = "Fun for the whole security team!  Just don't kill yourself in the process.."
	cast_methods = CAST_RANGED
	aspect = ASPECT_SHOCK
	spell_projectile = /obj/projectile/beam/chain_lightning
	energy_cost_per_shot = 3000
	instability_per_shot = 10
	cooldown = 20
	fire_sound = 'sound/weapons/gauss_shoot.ogg'

/obj/projectile/beam/chain_lightning
	name = "lightning"
	icon_state = "lightning"
	nodamage = 1
	damage_type = DAMAGE_TYPE_HALLOSS

	legacy_muzzle_type = /obj/effect/projectile/muzzle/lightning
	legacy_tracer_type = /obj/effect/projectile/tracer/lightning
	legacy_impact_type = /obj/effect/projectile/impact/lightning

	var/bounces = 3				//How many times it 'chains'.  Note that the first hit is not counted as it counts /bounces/.
	var/list/hit_mobs = list() 	//Mobs which were already hit.
	var/power = 35				//How hard it will hit for with electrocute_act(), decreases with each bounce.

// todo: rework this shit :/

/obj/projectile/beam/chain_lightning/on_impact(atom/target, impact_flags, def_zone, efficiency)
	. = ..()
	if(. & (PROJECTILE_IMPACT_FLAGS_UNCONDITIONAL_ABORT | PROJECTILE_IMPACT_BLOCKED))
		return
	var/mob/living/target_mob = target
	if(!isliving(target_mob))
		return
	//First we shock the guy we just hit.
	target_mob.electrocute(power * 10, power, 0, NONE, def_zone, src)
	hit_mobs |= target_mob

	//Each bounce reduces the damage of the bolt.
	power = power * 0.80
	if(bounces)
		//All possible targets.
		var/list/potential_targets = view(target_mob, 3)

		//Filtered targets, so we don't hit the same person twice.
		var/list/filtered_targets = list()
		for(var/mob/living/L in potential_targets)
			if(L in hit_mobs)
				continue
			filtered_targets |= L

		var/mob/living/new_target = null
		var/siemens_comparison = 0

		for(var/mob/living/carbon/human/H in filtered_targets)
			var/obj/item/organ/external/affected = H.get_organ(check_zone(BP_TORSO))
			var/their_siemens = H.get_siemens_coefficient_organ(affected)
			if(their_siemens > siemens_comparison) //We want as conductive as possible, so higher is better.
				new_target = H
				siemens_comparison = their_siemens

		if(new_target)
			var/turf/curloc = get_turf(target_mob)
			curloc.visible_message("<span class='danger'>\The [src] bounces to \the [new_target]!</span>")
			legacy_redirect(new_target.x, new_target.y, curloc, firer)
			bounces--
			return PROJECTILE_IMPACT_PIERCE



