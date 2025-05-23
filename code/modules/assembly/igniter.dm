/obj/item/assembly/igniter
	name = "igniter"
	desc = "A small electronic device able to ignite combustable substances."
	icon_state = "igniter"
	origin_tech = list(TECH_MAGNET = 1)
	materials_base = list(MAT_STEEL = 500, MAT_GLASS = 50)

	secured = TRUE
	wires = WIRE_RECEIVE

/obj/item/assembly/igniter/activate()
	if(!..())
		return FALSE

	if(holder && istype(holder.loc,/obj/item/grenade/simple/chemical))
		var/obj/item/grenade/simple/chemical/grenade = holder.loc
		grenade.detonate()
	else
		var/turf/location = get_turf(loc)
		if(location)
			location.hotspot_expose(1000,1000)
		if (istype(src.loc,/obj/item/assembly_holder))
			if (istype(src.loc.loc, /obj/structure/reagent_dispensers/fueltank/))
				var/obj/structure/reagent_dispensers/fueltank/tank = src.loc.loc
				if (tank && tank.modded)
					tank.explode()

		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, src)
		s.start()
	return TRUE

/obj/item/assembly/igniter/attack_self(mob/user, datum/event_args/actor/actor)
	activate()
	add_fingerprint(user)
	return TRUE

/obj/item/assembly/igniter/is_hot()
	return TRUE
