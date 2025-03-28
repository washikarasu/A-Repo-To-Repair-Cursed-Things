// Legacy version. Need to investigate what the hell lootdrop in loot.dm does later. -Ace
/obj/landmark/loot_spawn
	name = "loot spawner"
	icon_state = "grabbed1"
	var/live_cargo = 1 // So you can turn off aliens.
	var/low_probability = 0
	var/spawned_faction = "hostile" // Spawned mobs can have their faction changed.


/obj/landmark/loot_spawn/low
	name = "low prob loot spawner"
	icon_state = "grabbed"
	low_probability = 1

/obj/landmark/loot_spawn/Initialize(mapload)
	SHOULD_CALL_PARENT(FALSE)
	atom_flags |= ATOM_INITIALIZED
	switch(pick( \
	low_probability * 1000;"nothing", \
	200 - low_probability * 175;"treasure", \
	25 + low_probability * 75;"remains", \
	50 + low_probability * 50;"clothes", \
	"glasses", \
	100 - low_probability * 50;"weapons", \
	100 - low_probability * 50;"spacesuit", \
	"health", \
	25 + low_probability * 75;"snacks", \
	"lights", \
	25 - low_probability * 25;"engineering", \
	25 - low_probability * 25;"coffin", \
	))
		if("treasure")
			var/obj/structure/closet/crate/C = new(src.loc)
			if(prob(33))
				// Smuggled goodies.
				new /obj/item/stolenpackage(C)

			if(prob(33))
				//coins
				var/amount = rand(2,6)
				var/list/possible_spawns = list()
				for(var/coin_type in typesof(/obj/item/coin))
					possible_spawns += coin_type
				var/coin_type = pick(possible_spawns)
				for(var/i=0,i<amount,i++)
					new coin_type(C)

			else if(prob(50))
				//bars
				var/amount = rand(2,6)
				var/quantity = rand(10,50)
				var/list/possible_spawns = list()
				for(var/bar_type in typesof(/obj/item/stack/material) - /obj/item/stack/material - /obj/item/stack/animalhide - typesof(/obj/item/stack/material/cyborg))
					possible_spawns += bar_type

				var/bar_type = pick(possible_spawns)
				for(var/i=0,i<amount,i++)
					var/obj/item/stack/material/M = new bar_type(C)
					M.amount = quantity
			else
				//credits
				var/amount = rand(2,6)
				var/list/possible_spawns = list()
				for(var/cash_type in typesof(/obj/item/spacecash) - /obj/item/spacecash)
					possible_spawns += cash_type

				var/cash_type = pick(possible_spawns)
				for(var/i=0,i<amount,i++)
					new cash_type(C)
		if("remains")
			if(prob(50))
				new /obj/effect/decal/remains/human(src.loc)
			else if(prob(50))
				new /obj/effect/decal/remains/mouse(src.loc)
			else
				new /obj/effect/decal/remains/xeno(src.loc)
		if("clothes")
			var/obj/structure/closet/C = new(src.loc)
			C.icon_state = "blue"
			C.icon_closed = "blue"
			if(prob(33))
				new /obj/item/clothing/under/color/rainbow(C)
				new /obj/item/clothing/shoes/rainbow(C)
				new /obj/item/clothing/head/soft/rainbow(C)
				new /obj/item/clothing/gloves/rainbow(C)
			else if(prob(5))
				new /obj/item/storage/box/syndie_kit/chameleon(C)
			else
				new /obj/item/clothing/under/syndicate/combat(C)
				new /obj/item/clothing/shoes/boots/swat(C)
				new /obj/item/clothing/gloves/swat(C)
				new /obj/item/clothing/mask/balaclava(C)
		if("glasses")
			var/obj/structure/closet/C = new(src.loc)
			var/new_type = pick(
			/obj/item/clothing/glasses/material,\
			/obj/item/clothing/glasses/thermal,\
			/obj/item/clothing/glasses/meson,\
			/obj/item/clothing/glasses/night,\
			/obj/item/clothing/glasses/hud/health)
			new new_type(C)
		if("weapons")
			var/obj/structure/closet/crate/secure/weapon/C = new(src.loc)
			if(prob(50))
				var/new_gun = pick( // Copied from Random.dm
					prob(11);/obj/random/ammo_all,\
					prob(11);/obj/item/gun/projectile/energy/laser,\
					prob(11);/obj/item/gun/projectile/ballistic/pirate,\
					prob(10);/obj/item/material/twohanded/spear,\
					prob(10);/obj/item/gun/projectile/energy/stunrevolver,\
					prob(10);/obj/item/gun/projectile/energy/taser,\
					prob(10);/obj/item/gun/launcher/crossbow,\
					prob(10);/obj/item/gun/projectile/ballistic/shotgun/doublebarrel/pellet,\
					prob(10);/obj/item/material/knife,\
					prob(10);/obj/item/material/knife/tacknife/combatknife,\
					prob(10);/obj/item/material/butterfly/switchblade,\
					prob(10);/obj/item/gun/projectile/ballistic/luger,\
					prob(10);/obj/item/gun/projectile/ballistic/luger/brown,\
				/*	prob(10);/obj/item/gun/projectile/ballistic/pipegun,\ */
					prob(10);/obj/item/gun/projectile/ballistic/revolver,\
					prob(10);/obj/item/gun/projectile/ballistic/revolver/detective,\
					prob(10);/obj/item/gun/projectile/ballistic/revolver/mateba,\
					prob(10);/obj/item/gun/projectile/ballistic/revolver/judge,\
					prob(10);/obj/item/gun/projectile/ballistic/colt,\
					prob(10);/obj/item/gun/projectile/ballistic/shotgun/pump,\
					prob(10);/obj/item/gun/projectile/ballistic/shotgun/pump/rifle,\
				/*	prob(10);/obj/item/gun/projectile/ballistic/shotgun/pump/rifle/mosin,\ */
					prob(10);/obj/item/melee/baton,\
					prob(10);/obj/item/melee/telebaton,\
					prob(10);/obj/item/melee/classic_baton,\
					prob(10);/obj/item/melee/transforming/energy/sword,\
					prob(9);/obj/item/gun/projectile/ballistic/automatic/wt550/lethal,\
					prob(9);/obj/item/gun/projectile/ballistic/automatic/pdw,\
					prob(9);/obj/item/gun/projectile/ballistic/derringer,\
					prob(9);/obj/item/gun/projectile/energy/crossbow/largecrossbow,\
					prob(9);/obj/item/gun/projectile/ballistic/automatic/mini_uzi,\
					prob(9);/obj/item/gun/projectile/ballistic/pistol,\
					prob(9);/obj/item/gun/projectile/ballistic/shotgun/pump/combat,\
					prob(9);/obj/item/material/twohanded/fireaxe,\
					prob(9);/obj/item/cane/concealed,\
					prob(9);/obj/item/gun/projectile/energy/gun,\
					prob(8);/obj/item/gun/projectile/energy/ionrifle,\
					prob(8);/obj/item/gun/projectile/energy/retro,\
					prob(8);/obj/item/gun/projectile/energy/gun/eluger,\
					prob(8);/obj/item/gun/projectile/energy/xray,\
					prob(8);/obj/item/gun/projectile/ballistic/automatic/c20r,\
					prob(8);/obj/item/gun/projectile/ballistic/automatic/stg,\
					prob(8);/obj/item/melee/transforming/energy/sword,\
				/*	prob(8);/obj/item/gun/projectile/ballistic/automatic/m41a,\ */
					prob(7);/obj/item/gun/projectile/energy/captain,\
					prob(7);/obj/item/gun/projectile/energy/sniperrifle,\
					prob(7);/obj/item/gun/projectile/ballistic/automatic/p90,\
					prob(7);/obj/item/gun/projectile/ballistic/automatic/as24,\
					prob(7);/obj/item/gun/projectile/ballistic/automatic/sts35,\
					prob(7);/obj/item/gun/projectile/ballistic/automatic/z8,\
					prob(7);/obj/item/gun/projectile/energy/gun/burst,\
					prob(7);/obj/item/gun/projectile/ballistic/shotgun/pump/JSDF,\
					prob(7);/obj/item/gun/projectile/ballistic/deagle,\
					prob(7);/obj/item/gun/launcher/grenade,\
				/*	prob(6);/obj/item/gun/projectile/ballistic/SVD,\*/
					prob(6);/obj/item/gun/projectile/ballistic/automatic/lmg,\
					prob(6);/obj/item/gun/projectile/energy/lasercannon,\
					prob(5);/obj/item/gun/projectile/ballistic/automatic/bullpup,\
					prob(5);/obj/item/gun/projectile/energy/nt_pulse/rifle,\
				/*	prob(4);/obj/item/gun/projectile/ballistic/automatic/battlerifle,\ */
					prob(3);/obj/item/gun/projectile/ballistic/deagle/camo,\
					prob(3);/obj/item/gun/projectile/energy/gun/nuclear,\
					prob(2);/obj/item/gun/projectile/ballistic/deagle/gold,\
					prob(2);/obj/item/gun/projectile/ballistic/automatic/lmg/mg42,\
					prob(2);/obj/item/gun/projectile/ballistic/automatic/lmg/m60,\
					prob(1);/obj/item/gun/projectile/ballistic/rocket,\
					prob(1);/obj/item/gun/launcher/grenade,\
					prob(1);/obj/item/gun/projectile/ballistic/gyropistol,\
					prob(1);/obj/item/gun/projectile/ballistic/heavysniper,\
					prob(1);/obj/item/plastique,\
					prob(1);/obj/item/material/sword,\
					prob(1);/obj/item/cane/concealed,\
					prob(1);/obj/item/material/sword/katana)			//CITADEL CHANGE - FIXED FIREAXE PATH
				new new_gun(C)
			if(prob(50))
				var/new_ammo = pick( // Copied from Random.dm
					prob(5);/obj/item/storage/box/shotgunammo,\
					prob(5);/obj/item/storage/box/shotgunshells,\
					prob(5);/obj/item/ammo_magazine/a357/speedloader,\
					prob(5);/obj/item/ammo_magazine/a7_62mm/clip,\
					prob(5);/obj/item/ammo_magazine/a45/doublestack,\
					prob(5);/obj/item/ammo_magazine/a45/doublestack/rubber,\
					prob(5);/obj/item/ammo_magazine/a38/speedloader,\
					prob(5);/obj/item/ammo_magazine/a38/speedloader/rubber,\
					prob(5);/obj/item/storage/box/flashbangs,\
					prob(5);/obj/item/ammo_magazine/a5_56mm,\
					prob(4);/obj/item/ammo_magazine/a5_56mm/clip,\
					prob(4);/obj/item/ammo_magazine/a45/clip,\
					prob(4);/obj/item/ammo_magazine/a9mm/clip,\
					prob(4);/obj/item/ammo_magazine/a45/uzi,\
					prob(4);/obj/item/ammo_magazine/a5_56mm/ext,\
					prob(4);/obj/item/ammo_magazine/a9mm,\
					prob(4);/obj/item/ammo_magazine/a9mm/advanced_smg,\
					prob(4);/obj/item/ammo_magazine/a9mm/top_mount,\
					prob(4);/obj/item/ammo_magazine/a9mm/top_mount/rubber,\
					prob(4);/obj/item/ammo_magazine/a10mm,\
					prob(4);/obj/item/ammo_magazine/a5_7mm/p90,\
				/*	prob(4);/obj/item/ammo_magazine/m14,\
					prob(4);/obj/item/ammo_magazine/m14/large,\*/
					prob(4);/obj/item/ammo_magazine/a5_56mm/ext,
					prob(4);/obj/item/ammo_magazine/a7_62mm,\
					prob(4);/obj/item/ammo_magazine/a5_56mm/ext,\
					prob(3);/obj/item/ammo_magazine/a10mm/clip,\
					prob(3);/obj/item/ammo_magazine/a44/clip,\
					prob(3);/obj/item/ammo_magazine/a5_56mm,\
					prob(2);/obj/item/ammo_magazine/a44,\
					prob(2);/obj/item/ammo_magazine/a5_56mm,\
					prob(1);/obj/item/storage/box/frags,\
				/*	prob(1);/obj/item/ammo_magazine/m95,\ */
					prob(1);/obj/item/ammo_casing/rocket,\
					prob(1);/obj/item/storage/box/sniperammo,\
					prob(1);/obj/item/storage/box/flashshells,\
					prob(1);/obj/item/storage/box/beanbags,\
					prob(1);/obj/item/storage/box/practiceshells,\
					prob(1);/obj/item/storage/box/stunshells,\
					prob(1);/obj/item/storage/box/blanks,\
					prob(1);/obj/item/ammo_magazine/a7_92mm,\
					prob(1);/obj/item/ammo_magazine/a45/tommy/drum,\
					prob(1);/obj/item/ammo_magazine/a45/tommy)
				new new_ammo(C)
		if("spacesuit")
			var/obj/structure/closet/syndicate/C = new(src.loc)
			if(prob(25))
				new /obj/item/clothing/suit/space/syndicate/black(C)
				new /obj/item/clothing/head/helmet/space/syndicate/black(C)
				new /obj/item/tank/oxygen/red(C)
				new /obj/item/clothing/mask/breath(C)
			else if(prob(33))
				new /obj/item/clothing/suit/space/syndicate/blue(C)
				new /obj/item/clothing/head/helmet/space/syndicate/blue(C)
				new /obj/item/tank/oxygen/red(C)
				new /obj/item/clothing/mask/breath(C)
			else if(prob(50))
				new /obj/item/clothing/suit/space/syndicate/green(C)
				new /obj/item/clothing/head/helmet/space/syndicate/green(C)
				new /obj/item/tank/oxygen/red(C)
				new /obj/item/clothing/mask/breath(C)
			else
				new /obj/item/clothing/suit/space/syndicate/orange(C)
				new /obj/item/clothing/head/helmet/space/syndicate/orange(C)
				new /obj/item/tank/oxygen/red(C)
				new /obj/item/clothing/mask/breath(C)
		if("health")
			//hopefully won't be necessary, but there were an awful lot of hazards to get through...
			var/obj/structure/closet/crate/medical/C = new(src.loc)
			if(prob(50))
				new /obj/item/storage/firstaid/regular(C)
			if(prob(50))
				new /obj/item/storage/firstaid/fire(C)
			if(prob(50))
				new /obj/item/storage/firstaid/o2(C)
			if(prob(50))
				new /obj/item/storage/firstaid/toxin(C)
			if(prob(25))
				new /obj/item/storage/firstaid/combat(C)
			if(prob(25))
				new /obj/item/storage/firstaid/adv(C)
		if("snacks")
			//you're come so far, you must be in need of refreshment
			var/obj/structure/closet/crate/freezer/C = new(src.loc)
			var/num = rand(2,6)
			var/new_type = pick(
			/obj/item/reagent_containers/food/drinks/bottle/small/beer, \
			/obj/item/reagent_containers/food/drinks/tea, \
			/obj/item/reagent_containers/food/drinks/dry_ramen, \
			/obj/item/reagent_containers/food/snacks/candiedapple, \
			/obj/item/reagent_containers/food/snacks/chocolatebar, \
			/obj/item/reagent_containers/food/snacks/cookie, \
			/obj/item/reagent_containers/food/snacks/meatball, \
			/obj/item/reagent_containers/food/snacks/plump_pie, \
			/obj/item/reagent_containers/food/snacks/liquid)
			for(var/i=0,i<num,i++)
				new new_type(C)
		if("alien")
			//ancient aliens
			var/obj/structure/closet/acloset/C = new(src.loc)
			if(prob(33))
				if(live_cargo) // Carp! Since Facehuggers got removed.
					var/num = rand(1,3)
					for(var/i=0,i<num,i++)
						new /mob/living/simple_mob/animal/space/carp(C)
				else // Just a costume.
					new /obj/item/clothing/suit/storage/hooded/carp_costume(C)
			else if(prob(50))
				if(live_cargo) // Something else very much alive and angry.
					var/spawn_type = pick(/mob/living/simple_mob/animal/space/xenomorph/warrior, /mob/living/simple_mob/animal/space/xenomorph/drone, /mob/living/simple_mob/animal/space/xenomorph/neurotoxin_spitter)
					new spawn_type(C)
				else // Just a costume.
					new /obj/item/clothing/head/xenos(C)
					new /obj/item/clothing/suit/xenos(C)

			//33% chance of nothing

		if("lights")
			//flares, candles, matches
			var/obj/structure/closet/crate/secure/gear/C = new(src.loc)
			var/num = rand(2,6)
			for(var/i=0,i<num,i++)
				var/spawn_type = pick(
					/obj/item/flashlight/flare, \
					/obj/item/flame/candle, \
					/obj/item/storage/box/matches, \
					/obj/item/flashlight/glowstick, \
					/obj/item/flashlight/glowstick/red, \
					/obj/item/flashlight/glowstick/blue, \
					/obj/item/flashlight/glowstick/orange, \
					/obj/item/flashlight/glowstick/yellow)
				new spawn_type(C)
		if("engineering")
			var/obj/structure/closet/crate/secure/gear/C = new(src.loc)

			//chance to have any combination of up to two electrical/mechanical toolboxes and one cell
			if(prob(33))
				new /obj/item/storage/toolbox/electrical(C)
			else if(prob(50))
				new /obj/item/storage/toolbox/mechanical(C)

			if(prob(33))
				new /obj/item/storage/toolbox/mechanical(C)
			else if(prob(50))
				new /obj/item/storage/toolbox/electrical(C)

			if(prob(25))
				new /obj/item/cell(C)

		if("coffin")
			new /obj/structure/closet/coffin(src.loc)
			if(prob(33))
				new /obj/effect/decal/remains/human(src)
			else if(prob(50))
				new /obj/effect/decal/remains/xeno(src)

		if("mimic")
			var/obj/structure/closet/crate/secure/gear/C = new(src.loc)
			new /obj/item/storage/toolbox/electrical(C)

		if("viscerator")
			var/obj/structure/closet/crate/secure/gear/C = new(src.loc)
			new /obj/item/storage/toolbox/electrical(C)

	return INITIALIZE_HINT_QDEL

/**********************************/

/obj/structure/symbol
	anchored = 1
	layer = 3.5
	name = "strange symbol"
	icon = 'icons/obj/decals.dmi'

/obj/structure/symbol/ca
	desc = "It looks like a skull, or maybe a crown."
	icon_state = "ca"

/obj/structure/symbol/da
	desc = "It looks like a lightning bolt."
	icon_state = "da"

/obj/structure/symbol/em
	desc = "It looks kind of like a cup. Specifically, a martini glass."
	icon_state = "em"

/obj/structure/symbol/es
	desc = "It looks like two horizontal lines, with a dotted line in the middle, like a highway, or race track."
	icon_state = "es"

/obj/structure/symbol/fe
	desc = "It looks like an arrow pointing upward. Maybe even a spade."
	icon_state = "fe"

/obj/structure/symbol/gu
	desc = "It looks like an unfolded square box from the top with a cross on it."
	icon_state = "gu"

/obj/structure/symbol/lo
	desc = "It looks like the letter 'Y' with an underline."
	icon_state = "lo"

/obj/structure/symbol/pr
	desc = "It looks like a box with a cross on it."
	icon_state = "pr"

/obj/structure/symbol/sa
	desc = "It looks like a right triangle with a dot to the side. It reminds you of a wooden strut between a wall and ceiling."
	icon_state = "sa"

/obj/structure/symbol/maint
	name = "maintenance panel"
	desc = "This sign suggests that the wall it's attached to can be opened somehow."
	icon_state = "maintenance_panel"
