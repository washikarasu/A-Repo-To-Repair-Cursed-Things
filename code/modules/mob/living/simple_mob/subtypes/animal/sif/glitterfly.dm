// Glitterflies! Little butterfly-like creatures that float around and be cute.

/datum/category_item/catalogue/fauna/glitterfly
	name = "Sivian Fauna - Glitterfly"
	desc = "Classification: S Lepidoptera adamas \
	<br><br>\
	An herbivorous insectoid beloved for its glittering wings. \
	<br>\
	The creature has four wings mirrored laterally, which reflect \
	the ambient light to provide a measure of camouflage. \
	Their wings appearance does not come free, causing them to \
	produce large amounts of reflective flake-like dandruff."
	value = CATALOGUER_REWARD_TRIVIAL

/datum/category_item/catalogue/fauna/glitterfly_rare
	name = "Sivian Fauna - Adela's Glitterfly"
	desc = "Classification: S Lepidoptera adamas \
	<br><br>\
	This mutation of the glitterfly is incredibly rare, one of the few and first known individuals\
	known to exist with it is owned by little-known Sivian ecologist Adela Svingelm, and kept within its own \
	climate-controlled habitat."
	value = CATALOGUER_REWARD_HARD

/mob/living/simple_mob/animal/sif/glitterfly
	name = "glitterfly"
	desc = "A large, shiny butterfly!"
	description_info = "Glitterflies tend to have a wingspan equivalent to the length of an average human head."
	tt_desc = "S Lepidoptera adamas"
	catalogue_data = list(/datum/category_item/catalogue/fauna/glitterfly)

	iff_factions = MOB_IFF_FACTION_NEUTRAL

	icon_state = "butterfly"
	icon_living = "butterfly"
	icon_dead = "butterfly_dead"
	icon = 'icons/mob/animal.dmi'

	maxHealth = 10
	health = 10
	randomized = TRUE

	movement_base_speed = 75
	hovering = TRUE

	legacy_melee_damage_lower = 1
	legacy_melee_damage_upper = 2
	attack_armor_pen = 80
	attack_sharp = TRUE

	density = FALSE	// Non-dense, so things can walk through their groups unhindered.

	pass_flags = ATOM_PASS_TABLE

	attacktext = list("bit", "buffeted", "slashed")

	say_list_type = /datum/say_list/glitterfly
	ai_holder_type = /datum/ai_holder/polaris/simple_mob/melee/evasive/glitterfly

/mob/living/simple_mob/animal/sif/glitterfly/Initialize(mapload)
	. = ..()
	var/colorlist = list(rgb(rand(100,255), rand(100,255), rand(100,255)) =  10, rgb(rand(5,100), rand(5,100), rand(5,100)) = 2, "#222222" = 1)
	color = pickweight(colorlist)

	base_pixel_y = rand(5,12)
	pixel_y = base_pixel_y

	adjust_scale(round(rand(90, 105) / 100))

/mob/living/simple_mob/animal/sif/glitterfly/rare
	name = "sparkling glitterfly"
	desc = "A large, incredibly shiny butterfly!"
	catalogue_data = list(/datum/category_item/catalogue/fauna/glitterfly, /datum/category_item/catalogue/fauna/glitterfly_rare)
	maxHealth = 30
	health = 30

	movement_base_speed = 10

	legacy_melee_damage_upper = 5

	plane = ABOVE_LIGHTING_PLANE

/mob/living/simple_mob/animal/sif/glitterfly/rare/Initialize(mapload)
	. = ..()

/datum/say_list/glitterfly
	speak = list("Pi..","Po...", "Pa...")
	emote_see = list("vibrates","flutters", "twirls")
	emote_hear = list("pips", "clicks", "chirps")

/datum/ai_holder/polaris/simple_mob/melee/evasive/glitterfly
	hostile = FALSE
	can_flee = TRUE
	flee_when_outmatched = TRUE
	outmatched_threshold = 100
	max_home_distance = 5

/datum/ai_holder/polaris/simple_mob/melee/evasive/glitterfly/handle_special_strategical()
	if(prob(1))
		var/friendly_animal_corpse = FALSE
		for(var/mob/living/simple_mob/animal/A in view(vision_range,holder))
			if(holder.IIsAlly(A) && A.stat == DEAD)
				friendly_animal_corpse = TRUE
				break

		if(friendly_animal_corpse)
			hostile = TRUE
			return
	else if(prob(1))
		hostile = initial(hostile)
