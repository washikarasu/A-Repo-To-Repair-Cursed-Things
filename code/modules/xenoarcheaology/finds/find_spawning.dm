/obj/item/archaeological_find
	name = "object"
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "ano01"
	var/find_type = 0

/obj/item/archaeological_find/Initialize(mapload, new_item_type)
	. = ..()
	if(new_item_type)
		find_type = new_item_type
	else
		find_type = rand(1, MAX_ARCHAEO)

	var/item_type = "object"
	icon_state = "unknown[rand(1,4)]"
	var/additional_desc = ""
	var/obj/item/new_item
	var/source_material = ""
	var/apply_material_decorations = 1
	var/apply_image_decorations = 0
	var/material_descriptor = ""
	var/apply_prefix = 1

	if(prob(40))
		material_descriptor = pick("rusted ","dusty ","archaic ","fragile ")
	source_material = pick("cordite","quadrinium",MAT_STEEL,"titanium","aluminium","ferritic-alloy","plasteel","duranium")

	var/talkative = 0
	if(prob(5))
		talkative = 1

	//for all items here:
	//icon_state
	//item_state
	switch(find_type)
		if(1)
			item_type = "bowl"
			if(prob(33))
				new_item = new /obj/item/reagent_containers/glass/replenishing(src.loc)
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
			else
				new_item = new /obj/item/reagent_containers/glass/beaker(src.loc)
			new_item.icon = 'icons/obj/xenoarchaeology.dmi'
			new_item.icon_state = "bowl"
			apply_image_decorations = 1
			if(prob(40))
				new_item.color = rgb(rand(0,255),rand(0,255),rand(0,255))
			if(prob(20))
				additional_desc = "There appear to be [pick("dark","faintly glowing","pungent","bright")] [pick("red","purple","green","blue")] stains inside."
		if(2)
			item_type = "urn"
			if(prob(33))
				new_item = new /obj/item/reagent_containers/glass/replenishing(src.loc)
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
			else
				new_item = new /obj/item/reagent_containers/glass/beaker(src.loc)
			new_item.icon = 'icons/obj/xenoarchaeology.dmi'
			new_item.icon_state = "urn[rand(1,3)]"
			apply_image_decorations = 1
			if(prob(20))
				additional_desc = "It [pick("whispers faintly","makes a quiet roaring sound","whistles softly","thrums quietly","throbs")] if you put it to your ear."
		if(3)
			item_type = "[pick("fork","spoon","knife")]"
			if(prob(25))
				new_item = new /obj/item/material/kitchen/utensil/fork(src.loc)
			else if(prob(50))
				new_item = new /obj/item/material/knife(src.loc)
			else
				new_item = new /obj/item/material/kitchen/utensil/spoon(src.loc)
			if(prob(60))
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
			additional_desc = "[pick("It's like no [item_type] you've ever seen before",\
			"It's a mystery how anyone is supposed to eat with this",\
			"You wonder what the creator's mouth was shaped like")]."
		if(4)
			name = "statuette"
			icon = 'icons/obj/xenoarchaeology.dmi'
			item_type = "statuette"
			icon_state = "statuette[rand(1,4)]"
			additional_desc = "It depicts a [pick("small","ferocious","wild","pleasing","hulking")] \
			[pick("alien figure","rodent-like creature","reptilian alien","primate","unidentifiable object")] \
			[pick("performing unspeakable acts","posing heroically","in a fetal position","cheering","sobbing","making a plaintive gesture","making a rude gesture")]."
			if(prob(25))
				new_item = new /obj/item/vampiric(src.loc)
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
		if(5)
			name = "instrument"
			icon = 'icons/obj/xenoarchaeology.dmi'
			item_type = "instrument"
			icon_state = "instrument"
			if(prob(30))
				apply_image_decorations = 1
				additional_desc = "[pick("You're not sure how anyone could have played this",\
				"You wonder how many mouths the creator had",\
				"You wonder what it sounds like",\
				"You wonder what kind of music was made with it")]."
		if(6)
			item_type = "[pick("bladed knife","serrated blade","sharp cutting implement")]"
			new_item = new /obj/item/material/knife(src.loc)
			additional_desc = "[pick("It doesn't look safe.",\
			"It looks wickedly jagged",\
			"There appear to be [pick("dark red","dark purple","dark green","dark blue")] stains along the edges")]."
		if(7)
			//assuming there are 12 types of coins
			var/chance = 8
			for(var/type in typesof(/obj/item/coin))
				if(prob(chance))
					new_item = new type(loc)
					break
				chance += 10
			if(!new_item)
				new_item = new /obj/item/coin(loc)
			item_type = new_item.name
			apply_prefix = 0
			apply_material_decorations = 0
			apply_image_decorations = 1
		if(8)
			item_type = "handcuffs"
			new_item = new /obj/item/handcuffs(src.loc)
			additional_desc = "[pick("They appear to be for securing two things together","Looks kinky","Doesn't seem like a children's toy")]."
		if(9)
			item_type = "[pick("wicked","evil","byzantine","dangerous")] looking [pick("device","contraption","thing","trap")]"
			apply_prefix = 0
			new_item = new /obj/item/beartrap(src.loc)
			if(prob(40))
				new_item.color = rgb(rand(0,255),rand(0,255),rand(0,255))
			additional_desc = "[pick("It looks like it could take a limb off",\
			"Could be some kind of animal trap",\
			"There appear to be [pick("dark red","dark purple","dark green","dark blue")] stains along part of it")]."
		if(10)
			item_type = "[pick("cylinder","tank","chamber")]"
			new_item = new /obj/item/flame/lighter(src.loc)
			additional_desc = "There is a tiny device attached."
			if(prob(30))
				apply_image_decorations = 1
		if(11)
			item_type = "box"
			new_item = new /obj/item/storage/box(src.loc)
			new_item.icon = 'icons/obj/xenoarchaeology.dmi'
			new_item.icon_state = "box"
			var/obj/item/storage/box/new_box = new_item
			new_box.max_single_weight_class = pick(1,2,2,3,3,3,4,4)
			var/storage_amount = 2**(new_box.max_single_weight_class-1)
			new_box.max_combined_volume = rand(storage_amount, storage_amount * 10)
			if(prob(30))
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
				apply_image_decorations = 1
		if(12)
			item_type = "[pick("cylinder","tank","chamber")]"
			if(prob(25))
				new_item = new /obj/item/tank/air(src.loc)
			else if(prob(50))
				new_item = new /obj/item/tank/anesthetic(src.loc)
			else
				new_item = new /obj/item/tank/phoron(src.loc)
			icon_state = pick("oxygen","oxygen_fr","oxygen_f","phoron","anesthetic")
			additional_desc = "It [pick("gloops","sloshes")] slightly when you shake it."
		if(13)
			item_type = "tool"
			if(prob(25))
				new_item = new /obj/item/tool/wrench(src.loc)
			else if(prob(25))
				new_item = new /obj/item/tool/crowbar(src.loc)
			else
				new_item = new /obj/item/tool/screwdriver(src.loc)
			if(prob(40))
				new_item.color = rgb(rand(0,255),rand(0,255),rand(0,255))
				apply_image_decorations = 1
			additional_desc = "[pick("It doesn't look safe.",\
			"You wonder what it was used for",\
			"There appear to be [pick("dark red","dark purple","dark green","dark blue")] stains on it")]."
		if(14)
			apply_material_decorations = 0
			var/list/possible_spawns = list()
			possible_spawns += /obj/item/stack/material/steel
			possible_spawns += /obj/item/stack/material/plasteel
			possible_spawns += /obj/item/stack/material/glass
			possible_spawns += /obj/item/stack/material/glass/reinforced
			possible_spawns += /obj/item/stack/material/phoron
			possible_spawns += /obj/item/stack/material/gold
			possible_spawns += /obj/item/stack/material/silver
			possible_spawns += /obj/item/stack/material/copper
			possible_spawns += /obj/item/stack/material/uranium
			possible_spawns += /obj/item/stack/material/sandstone
			possible_spawns += /obj/item/stack/material/silver

			var/new_type = pick(possible_spawns)
			new_item = new new_type(src.loc)
			new_item:amount = rand(5,45)
		if(15)
			if(prob(75))
				new_item = new /obj/item/pen(src.loc)
			else
				new_item = new /obj/item/pen/reagent/sleepy(src.loc)
			if(prob(30))
				icon = 'icons/obj/xenoarchaeology.dmi'
				icon_state = "pen1"
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
				apply_image_decorations = 1
		if(16)
			apply_prefix = 0
			if(prob(25))
				icon = 'icons/obj/xenoarchaeology.dmi'
				item_type = "smooth green crystal"
				icon_state = "Green lump"
			else if(prob(33))
				icon = 'icons/obj/xenoarchaeology.dmi'
				item_type = "irregular purple crystal"
				icon_state = "Phazon"
			else
				icon = 'icons/obj/xenoarchaeology.dmi'
				item_type = "rough red crystal"
				icon_state = "changerock"
			additional_desc = pick("It shines faintly as it catches the light.","It appears to have a faint inner glow.","It seems to draw you inward as you look it at.","Something twinkles faintly as you look at it.","It's mesmerizing to behold.")

			apply_material_decorations = 0
			if(prob(10))
				apply_image_decorations = 1
			if(prob(25))
				new_item = new /obj/item/soulstone(src.loc)
				new_item.icon = 'icons/obj/xenoarchaeology.dmi'
				new_item.icon_state = icon_state
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 2)
		if(17)
			//cultblade
			apply_prefix = 0
			new_item = new /obj/item/melee/cultblade(src.loc)
			apply_material_decorations = 0
			apply_image_decorations = 0
		if(18)
			new_item = new /obj/item/radio/beacon(src.loc)
			talkative = 0
			new_item.icon = 'icons/obj/xenoarchaeology.dmi'
			new_item.icon_state = "unknown[rand(1,4)]"
			new_item.desc = ""
		if(19)
			apply_prefix = 0
			new_item = new /obj/item/material/sword(src.loc)
			new_item.damage_force = 10
			item_type = new_item.name
			if(prob(30))
				new_item.icon = 'icons/obj/xenoarchaeology.dmi'
				new_item.icon_state = "blade1"
		if(20)
			//arcane clothing
			apply_prefix = 0
			var/list/possible_spawns = list(/obj/item/clothing/head/cult,
			/obj/item/clothing/head/cult/magus,
			/obj/item/clothing/head/cult/alt,
			/obj/item/clothing/head/helmet/space/cult)

			var/new_type = pick(possible_spawns)
			new_item = new new_type(src.loc)
			LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
		if(21)
			//soulstone
			apply_prefix = 0
			new_item = new /obj/item/soulstone(src.loc)
			item_type = new_item.name
			apply_material_decorations = 0
			LAZYSET(new_item.origin_tech, TECH_ARCANE, 2)
		if(22)
			if(prob(50))
				new_item = new /obj/item/material/shard(src.loc)
			else
				new_item = new /obj/item/material/shard/phoron(src.loc)
			apply_prefix = 0
			apply_image_decorations = 0
			apply_material_decorations = 0
		if(23)
			apply_prefix = 0
			new_item = new /obj/item/stack/rods(src.loc)
			apply_image_decorations = 0
			apply_material_decorations = 0
		if(24)
			var/list/possible_spawns = typesof(/obj/item/stock_parts)
			possible_spawns -= /obj/item/stock_parts
			possible_spawns -= /obj/item/stock_parts/subspace

			var/new_type = pick(possible_spawns)
			new_item = new new_type(src.loc)
			item_type = new_item.name
			apply_material_decorations = 0
		if(25)
			apply_prefix = 0
			new_item = new /obj/item/material/sword/katana(src.loc)
			new_item.damage_force = 10
			item_type = new_item.name
		if(26)
			//energy gun
			var/spawn_type = pick(\
			/obj/item/gun/projectile/energy/laser/practice/xenoarch,\
			/obj/item/gun/projectile/energy/laser/xenoarch,\
			/obj/item/gun/projectile/energy/xray/xenoarch,\
			/obj/item/gun/projectile/energy/captain/xenoarch)
			if(spawn_type)
				var/obj/item/gun/projectile/energy/new_gun = new spawn_type(src.loc)
				new_item = new_gun
				new_item.icon_state = "egun[rand(1,6)]"
				new_gun.desc = "This is an antique energy weapon, you're not sure if it will fire or not."

				//5% chance to explode when first fired
				//10% chance to have an unchargeable cell
				//15% chance to gain a random amount of starting energy, otherwise start with an empty cell
				if(prob(5))
					new_gun.obj_cell_slot.cell.rigged = 1
				if(prob(10))
					new_gun.obj_cell_slot.cell.maxcharge = 0
					LAZYSET(new_gun.origin_tech, TECH_ARCANE, rand(0, 1))
				if(prob(15))
					new_gun.obj_cell_slot.cell.charge = rand(0, new_gun.obj_cell_slot.cell.maxcharge)
					LAZYSET(new_gun.origin_tech, TECH_ARCANE, 1)
				else
					new_gun.obj_cell_slot.cell.charge = 0

			item_type = "gun"
		if(27)
			var/datum/procedural_entity_descriptor/item/descriptor = new /datum/procedural_entity_descriptor/item/gun/ballistic/xenoarcheology_1
			descriptor.instantiate_single(loc)
			item_type = "gun"
		if(28)
			//completely unknown alien device
			if(prob(50))
				apply_image_decorations = 0
		if(29)
			//fossil bone/skull
			//new_item = new /obj/item/fossil/base(src.loc)

			//the replacement item propogation isn't working, and it's messy code anyway so just do it here
			var/list/candidates = list(/obj/item/fossil/bone = 9,/obj/item/fossil/skull = 3,
			/obj/item/fossil/skull/horned = 2)
			var/spawn_type = pickweight(candidates)
			new_item = new spawn_type(src.loc)

			apply_prefix = 0
			additional_desc = "A fossilised part of an alien, long dead."
			apply_image_decorations = 0
			apply_material_decorations = 0
		if(30)
			//fossil shell
			new_item = new /obj/item/fossil/shell(src.loc)
			apply_prefix = 0
			additional_desc = "A fossilised, pre-Stygian alien crustacean."
			apply_image_decorations = 0
			apply_material_decorations = 0
			if(prob(10))
				apply_image_decorations = 1
		if(31)
			//fossil plant
			new_item = new /obj/item/fossil/plant(src.loc)
			item_type = new_item.name
			additional_desc = "A fossilised shred of alien plant matter."
			apply_image_decorations = 0
			apply_material_decorations = 0
			apply_prefix = 0
		if(32)
			//humanoid remains
			apply_prefix = 0
			item_type = "humanoid [pick("remains","skeleton")]"
			icon = 'icons/effects/blood.dmi'
			icon_state = "remains"
			additional_desc = pick("They appear almost human.",\
			"They are contorted in a most gruesome way.",\
			"They look almost peaceful.",\
			"The bones are yellowing and old, but remarkably well preserved.",\
			"The bones are scored by numerous burns and partially melted.",\
			"The are battered and broken, in some cases less than splinters are left.",\
			"The mouth is wide open in a death rictus, the victim would appear to have died screaming.")
			apply_image_decorations = 0
			apply_material_decorations = 0
		if(33)
			//robot remains
			apply_prefix = 0
			item_type = "[pick("mechanical","robotic","cyborg")] [pick("remains","chassis","debris")]"
			icon = 'icons/mob/robots.dmi'
			icon_state = "remainsrobot"
			additional_desc = pick("Almost mistakeable for the remains of a modern cyborg.",\
			"They are barely recognisable as anything other than a pile of waste metals.",\
			"It looks like the battered remains of an ancient robot chassis.",\
			"The chassis is rusting and old, but remarkably well preserved.",\
			"The chassis is scored by numerous burns and partially melted.",\
			"The chassis is battered and broken, in some cases only chunks of metal are left.",\
			"A pile of wires and crap metal that looks vaguely robotic.")
			apply_image_decorations = 0
			apply_material_decorations = 0
		if(34)
			//xenos remains
			apply_prefix = 0
			item_type = "alien [pick("remains","skeleton")]"
			icon = 'icons/effects/blood.dmi'
			icon_state = "remainsxeno"
			additional_desc = pick("It looks vaguely reptilian, but with more teeth.",\
			"They are faintly unsettling.",\
			"There is a faint aura of unease about them.",\
			"The bones are yellowing and old, but remarkably well preserved.",\
			"The bones are scored by numerous burns and partially melted.",\
			"The are battered and broken, in some cases less than splinters are left.",\
			"This creature would have been twisted and monstrous when it was alive.",\
			"It doesn't look human.")
			apply_image_decorations = 0
			apply_material_decorations = 0
		if(35)
			//gas mask
			if(prob(25))
				new_item = new /obj/item/clothing/mask/gas/poltergeist(src.loc)
				LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
			else
				new_item = new /obj/item/clothing/mask/gas(src.loc)
			if(prob(40))
				new_item.color = rgb(rand(0,255),rand(0,255),rand(0,255))
		if(36)
			// Alien stuff.
			apply_prefix = FALSE
			apply_material_decorations = FALSE

			var/list/alien_stuff = list(
				/obj/item/multitool/alien,
				/obj/item/stack/cable_coil/alien,
				/obj/item/tool/crowbar/alien,
				/obj/item/tool/screwdriver/alien,
				/obj/item/weldingtool/alien,
				/obj/item/tool/wirecutters/alien,
				/obj/item/tool/wrench/alien,
				/obj/item/surgical/FixOVein/alien,
				/obj/item/surgical/bone_clamp/alien,
				/obj/item/surgical/cautery/alien,
				/obj/item/surgical/circular_saw/alien,
				/obj/item/surgical/hemostat/alien,
				/obj/item/surgical/retractor/alien,
				/obj/item/surgical/scalpel/alien,
				/obj/item/surgical/surgicaldrill/alien,
				/obj/item/cell/device/weapon/recharge/alien,
				/obj/item/clothing/suit/armor/alien,
				/obj/item/clothing/head/helmet/alien,
				/obj/item/clothing/head/psy_crown/wrath
			)

			var/new_type = pick(alien_stuff)
			new_item = new new_type(src.loc)
			LAZYSET(new_item.origin_tech, TECH_ARCANE, 2)
			LAZYSET(new_item.origin_tech, TECH_PRECURSOR, 1)
			item_type = new_item.name

		if(37)
			// Alien boats.
			apply_prefix = FALSE
			var/new_boat_mat = pickweight(list(
				MAT_WOOD = 100,
				MAT_SIFWOOD = 200,
				MAT_STEEL = 60,
				MAT_URANIUM = 14,
				MAT_MARBLE = 16,
				MAT_GOLD = 20,
				MAT_SILVER = 24,
				MAT_PLASTEEL = 10,
				MAT_TITANIUM = 6,
				MAT_IRON = 30,
				MAT_PHORON = 4,
				MAT_VERDANTIUM = 2,
				MAT_DIAMOND = 4,
				MAT_DURASTEEL = 2,
				MAT_MORPHIUM = 2,
				MAT_SUPERMATTER = 1
				))
			var/list/alien_stuff = list(
				/obj/vehicle/ridden/boat,
				/obj/vehicle/ridden/boat/dragon
				)
			if(prob(30))
				new /obj/item/oar(src.loc, new_boat_mat)
			var/new_type = pick(alien_stuff)
			new_item = new new_type(src.loc, new_boat_mat)
			item_type = new_item.name

		if(38)
			// Imperion circuit.
			apply_prefix = FALSE
			apply_image_decorations = FALSE
			var/possible_circuits = subtypesof(/obj/item/circuitboard/mecha/imperion)
			var/new_type = pick(possible_circuits)
			new_item = new new_type(src.loc)
			name = new_item.name
			desc = new_item.desc
			item_type = new_item.name

		if(39)
			// Telecube.
			if(prob(25))
				apply_prefix = FALSE
			if(prob(75))
				apply_image_decorations = TRUE
			if(prob(25))
				apply_material_decorations = FALSE
			new_item = new /obj/item/telecube/randomized(src.loc)

	if(istype(new_item, /obj/item/material))
		var/new_item_mat = pickweight(list(
			MAT_STEEL = 80,
			MAT_WOOD = 20,
			MAT_SIFWOOD = 40,
			MAT_URANIUM = 14,
			MAT_MARBLE = 16,
			MAT_GOLD = 20,
			MAT_SILVER = 24,
			MAT_PLASTEEL = 10,
			MAT_TITANIUM = 6,
			MAT_IRON = 30,
			MAT_PHORON = 4,
			MAT_VERDANTIUM = 2,
			MAT_DIAMOND = 4,
			MAT_DURASTEEL = 2,
			MAT_MORPHIUM = 2,
			MAT_SUPERMATTER = 1
			))
		var/obj/item/material/MW = new_item
		MW.material_color = TRUE
		MW.set_material_part(MATERIAL_PART_DEFAULT, get_material_by_name(new_item_mat))

	var/decorations = ""
	if(apply_material_decorations)
		source_material = pick("cordite","quadrinium",MAT_STEEL,"titanium","aluminium","ferritic-alloy","plasteel","duranium")
		if(istype(new_item, /obj/item/material))
			var/obj/item/material/MW = new_item
			source_material = MW.get_primary_material()?.display_name || "some unknown material"
		desc = "A [material_descriptor ? "[material_descriptor] " : ""][item_type] made of [source_material], all craftsmanship is of [pick("the lowest","low","average","high","the highest")] quality."

		var/list/descriptors = list()
		if(prob(30))
			descriptors.Add("is encrusted with [pick("","synthetic ","multi-faceted ","uncut ","sparkling ") + pick("rubies","emeralds","diamonds","opals","lapiz lazuli")]")
		if(prob(30))
			descriptors.Add("is studded with [pick("gold","silver","aluminium","titanium")]")
		if(prob(30))
			descriptors.Add("is encircled with bands of [pick("quadrinium","cordite","ferritic-alloy","plasteel","duranium")]")
		if(prob(30))
			descriptors.Add("menaces with spikes of [pick("solid phoron","uranium","white pearl","black steel")]")
		if(descriptors.len > 0)
			decorations = "It "
			for(var/index=1, index <= descriptors.len, index++)
				if(index > 1)
					if(index == descriptors.len)
						decorations += " and "
					else
						decorations += ", "
				decorations += descriptors[index]
			decorations += "."
		if(decorations)
			desc += " " + decorations

	var/engravings = ""
	if(apply_image_decorations)
		engravings = "[pick("Engraved","Carved","Etched")] on the item is [pick("an image of","a frieze of","a depiction of")] \
		[pick("an alien humanoid","an amorphic blob","a short, hairy being","a rodent-like creature","a robot","a primate","a reptilian alien","an unidentifiable object","a statue","a starship","unusual devices","a structure")] \
		[pick("surrounded by","being held aloft by","being struck by","being examined by","communicating with")] \
		[pick("alien humanoids","amorphic blobs","short, hairy beings","rodent-like creatures","robots","primates","reptilian aliens")]"
		if(prob(50))
			engravings += ", [pick("they seem to be enjoying themselves","they seem extremely angry","they look pensive","they are making gestures of supplication","the scene is one of subtle horror","the scene conveys a sense of desperation","the scene is completely bizarre")]"
		engravings += "."

		if(desc)
			desc += " "
		desc += engravings

	if(apply_prefix)
		name = "[pick("Strange","Ancient","Alien","")] [item_type]"
	else
		name = item_type

	if(desc)
		desc += " "
	desc += additional_desc
	if(!desc)
		desc = "This item is completely [pick("alien","bizarre")]."

	//icon and icon_state should have already been set
	if(new_item)
		new_item.name = name
		new_item.desc = src.desc

		if(talkative)
			new_item.talking_atom = new(new_item)
			LAZYINITLIST(new_item.origin_tech)
			LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
			LAZYSET(new_item.origin_tech, TECH_PRECURSOR, 1)

		var/turf/simulated/mineral/T = get_turf(new_item)
		if(istype(T))
			T.last_find = new_item

		qdel(src)

	else if(talkative)
		src.talking_atom = new(src)
		if(new_item)
			LAZYSET(new_item.origin_tech, TECH_ARCANE, 1)
			LAZYSET(new_item.origin_tech, TECH_PRECURSOR, 1)
