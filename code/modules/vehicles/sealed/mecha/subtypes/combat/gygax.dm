/obj/vehicle/sealed/mecha/combat/gygax
	desc = "A lightweight, security exosuit. Popular among private and corporate security."
	name = "Gygax"
	icon_state = "gygax_adv"
	initial_icon = "gygax_adv"
	step_in = 3
	dir_in = 1 //Facing North.
	integrity = 250
	integrity_max = 250			//Don't forget to update the /old variant if  you change this number.
	deflect_chance = 15
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/effect/decal/mecha_wreckage/gygax/adv
	internal_damage_threshold = 35
	max_equip = 3

	max_hull_equip = 1
	max_weapon_equip = 2
	max_utility_equip = 2
	max_universal_equip = 1
	max_special_equip = 1

	starting_components = list(
		/obj/item/mecha_parts/component/hull/lightweight,
		/obj/item/mecha_parts/component/actuator,
		/obj/item/mecha_parts/component/armor/marshal,
		/obj/item/mecha_parts/component/gas,
		/obj/item/mecha_parts/component/electrical
		)

	overload_possible = 1

	icon_scale_x = 1.35
	icon_scale_y = 1.35

//Not quite sure how to move those yet.
/obj/vehicle/sealed/mecha/combat/gygax/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_leg_overload=1'>Toggle leg actuators overload</a>
						</div>
						</div>
						"}
	output += ..()
	return output


/obj/vehicle/sealed/mecha/combat/gygax/dark
	desc = "A lightweight exosuit used by paramilitary forces. A significantly upgraded Gygax security mech."
	name = "Dark Gygax"
	integrity = 400
	integrity_max = 400
	icon_state = "darkgygax_adv"
	initial_icon = "darkgygax_adv"
	deflect_chance = 25
	damage_absorption = list("brute"=0.6,"fire"=0.8,"bullet"=0.6,"laser"=0.5,"energy"=0.65,"bomb"=0.8)
	max_temperature = 45000
	overload_coeff = 1
	wreckage = /obj/effect/decal/mecha_wreckage/gygax/dark_adv
	max_equip = 4
	step_energy_drain = 5
	mech_faction = MECH_FACTION_SYNDI

	max_hull_equip = 1
	max_weapon_equip = 2
	max_utility_equip = 2
	max_universal_equip = 1
	max_special_equip = 2

	starting_equipment = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/grenade/clusterbang,
		/obj/item/mecha_parts/mecha_equipment/tesla_energy_relay,
		/obj/item/mecha_parts/mecha_equipment/teleporter
		)

/obj/vehicle/sealed/mecha/combat/gygax/dark/add_cell(var/obj/item/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 30000
	cell.maxcharge = 30000

/obj/vehicle/sealed/mecha/combat/gygax/serenity
	desc = "A lightweight exosuit made from a modified Gygax chassis combined with proprietary VeyMed medical tech. It's faster and sturdier than most medical mechs, but much of the armor plating has been stripped out, leaving it more vulnerable than a regular Gygax."
	name = "Serenity"
	icon_state = "medgax"
	initial_icon = "medgax"
	integrity = 150
	integrity_max = 150
	deflect_chance = 20
	step_in = 2

	occupant_huds = list(
		/datum/atom_hud/data/human/medical,
	)

	damage_absorption = list("brute"=0.9,"fire"=1,"bullet"=0.9,"laser"=0.8,"energy"=0.9,"bomb"=1)
	max_temperature = 20000
	overload_coeff = 1
	wreckage = /obj/effect/decal/mecha_wreckage/gygax/serenity
	max_equip = 3
	step_energy_drain = 8
	cargo_capacity = 2
	max_hull_equip = 1
	max_weapon_equip = 1
	max_utility_equip = 2
	max_universal_equip = 1
	max_special_equip = 1

	starting_components = list(
		/obj/item/mecha_parts/component/hull,
		/obj/item/mecha_parts/component/actuator,
		/obj/item/mecha_parts/component/armor/lightweight,
		/obj/item/mecha_parts/component/gas,
		/obj/item/mecha_parts/component/electrical
		)

//Meant for random spawns.
/obj/vehicle/sealed/mecha/combat/gygax/old
	desc = "A lightweight, security exosuit. Popular among private and corporate security. This one is particularly worn looking and likely isn't as sturdy."

/obj/vehicle/sealed/mecha/combat/gygax/old/Initialize(mapload)
	. = ..()
	integrity = 25
	integrity_max = 250	//Just slightly worse.
	cell.charge = rand(0, (cell.charge/2))