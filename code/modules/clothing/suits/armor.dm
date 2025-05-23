/obj/item/clothing/suit/armor
	allowed = list(/obj/item/gun/projectile/ballistic/sec/flash, /obj/item/gun/projectile/energy,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/projectile/ballistic,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/flashlight/maglight,/obj/item/clothing/head/helmet)
	body_cover_flags = UPPER_TORSO|LOWER_TORSO
	clothing_flags = CLOTHING_THICK_MATERIAL | CLOTHING_INJECTION_PORT
	valid_accessory_slots = (\
		ACCESSORY_SLOT_OVER\
		|ACCESSORY_SLOT_MEDAL\
		|ACCESSORY_SLOT_INSIGNIA)

	cold_protection_cover = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_cover = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/can_equip(mob/M, slot, mob/user, flags)
	. = ..()
	if(!.)
		return

	if(!ishuman(M))
		return

	var/mob/living/carbon/human/H = M

	for(var/obj/item/clothing/I in list(H.gloves, H.shoes))
		if(I && (src.body_cover_flags & ARMS && I.body_cover_flags & ARMS) )
			to_chat(H, "<span class='warning'>You can't wear \the [src] with \the [I], it's in the way.</span>")
			return FALSE
		if(I && (src.body_cover_flags & LEGS && I.body_cover_flags & LEGS) )
			to_chat(H, "<span class='warning'>You can't wear \the [src] with \the [I], it's in the way.</span>")
			return FALSE
	return TRUE

/obj/item/clothing/suit/armor/vest
	name = "armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/station/light

/obj/item/clothing/suit/armor/vest/alt
	name = "security armor"
	desc = "An armored vest that protects against some damage. This one has a Nanotrasen corporate badge."
	icon_state = "armoralt"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")

/obj/item/clothing/suit/armor/vest/security
	name = "security armor"
	desc = "An armored vest that protects against some damage. This one has a corporate badge."
	icon_state = "armorsec"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")

/obj/item/clothing/suit/armor/riot
	name = "riot vest"
	desc = "A vest with heavy padding to protect against melee attacks."
	icon_state = "riot"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	armor_type = /datum/armor/station/riot
	siemens_coefficient = 0.5

/obj/item/clothing/suit/armor/riot/alt
	icon_state = "riot_new"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "riot_new", SLOT_ID_LEFT_HAND = "riot_new")

/obj/item/clothing/suit/armor/bulletproof
	name = "ballistic vest"
	desc = "A vest that excels in protecting the wearer against high-velocity solid projectiles."
	icon_state = "bulletproof"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	blood_overlay_type = "armor"
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_SPECIALIZED
	weight = ITEM_WEIGHT_ARMOR_SPECIALIZED
	armor_type = /datum/armor/station/ballistic
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/bulletproof/alt
	icon_state = "bulletproof_new"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "bulletproof_new", SLOT_ID_LEFT_HAND = "bulletproof_new")
	blood_overlay_type = "armor"


/obj/item/clothing/suit/armor/combat
	name = "combat vest"
	desc = "A vest that protects the wearer from several common types of ranged weaponry."
	icon_state = "combat"
	blood_overlay_type = "armor"
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_MEDIUM
	weight = ITEM_WEIGHT_ARMOR_MEDIUM
	armor_type = /datum/armor/station/combat
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/tactical
	name = "tactical armor"
	desc = "A suit of armor most often used by Special Weapons and Tactics squads. Includes padded vest with pockets along with shoulder and kneeguards."
	icon_state = "swatarmor"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	inv_hide_flags = HIDETIE|HIDEHOLSTER
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_LIGHT
	weight = ITEM_WEIGHT_ARMOR_LIGHT
	armor_type = /datum/armor/station/tactical
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/swat
	name = "swat suit"
	desc = "A heavily armored suit that protects against moderate damage. Used in special operations."
	icon_state = "deathsquad"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	clothing_flags = CLOTHING_THICK_MATERIAL | CLOTHING_INJECTION_PORT
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	allowed = list(/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/tank/emergency/oxygen,/obj/item/clothing/head/helmet)
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_HEAVY + ITEM_ENCUMBRANCE_ARMOR_HEAVY_BOOTS + ITEM_ENCUMBRANCE_ARMOR_HEAVY_GLOVES
	weight = ITEM_WEIGHT_ARMOR_HEAVY + ITEM_WEIGHT_ARMOR_HEAVY_BOOTS + ITEM_WEIGHT_ARMOR_HEAVY_GLOVES
	w_class = WEIGHT_CLASS_HUGE
	armor_type = /datum/armor/centcom/deathsquad
	inv_hide_flags = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection_cover = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	min_pressure_protection = 0 * ONE_ATMOSPHERE
	max_pressure_protection = 20* ONE_ATMOSPHERE
	siemens_coefficient = 0.6
	valid_accessory_slots = null

/obj/item/clothing/suit/armor/swat/officer
	name = "officer jacket"
	desc = "An armored jacket used in special operations."
	icon_state = "detective"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "detective", SLOT_ID_LEFT_HAND = "detective")
	blood_overlay_type = "coat"
	inv_hide_flags = 0
	body_cover_flags = UPPER_TORSO|ARMS
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_HEAVY
	weight = ITEM_WEIGHT_ARMOR_HEAVY

/obj/item/clothing/suit/armor/det_suit
	name = "armor"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	blood_overlay_type = "armor"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO
	armor_type = /datum/armor/station/light

/obj/item/clothing/suit/armor/caution
	name = "improvised armor (caution sign)"
	desc = "They used to beat you for pointing at the sign. Now, vengeance has come. WARNING: This is just a sign with straps attached to anchor it. Vengeance not guaranteed."
	icon_state = "caution"
	blood_overlay_type = "armor"
	armor = /datum/armor/none

//Reactive armor
//When the wearer gets hit, this armor will teleport the user a short distance away (to safety or to more danger, no one knows. That's the fun of it!)
/obj/item/clothing/suit/armor/reactive
	name = "Reactive Teleport Armor"
	desc = "Someone separated our Research Director from their own head!"
	var/active = 0.0
	icon_state = "reactiveoff"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor_reflec_old", SLOT_ID_LEFT_HAND = "armor_reflec_old")
	blood_overlay_type = "armor"
	armor_type = /datum/armor/none

/obj/item/clothing/suit/armor/reactive/equipped(mob/user, slot, flags)
	. = ..()
	if(slot == SLOT_ID_HANDS)
		return
	// if you're reading this: this is not the right way to do shieldcalls
	// this is just a lazy implementation
	// signals have highest priority, this as a piece of armor shouldn't have that.
	RegisterSignal(user, COMSIG_ATOM_SHIELDCALL, PROC_REF(shieldcall))

/obj/item/clothing/suit/armor/reactive/unequipped(mob/user, slot, flags)
	. = ..()
	if(slot == SLOT_ID_HANDS)
		return
	UnregisterSignal(user, COMSIG_ATOM_SHIELDCALL)

/obj/item/clothing/suit/armor/reactive/proc/shieldcall(mob/user, list/shieldcall_args, fake_attack)
	if(prob(50))
		user.visible_message("<span class='danger'>The reactive teleport system flings [user] clear of the attack!</span>")
		var/list/turfs = new/list()
		for(var/turf/T in orange(6, user))
			if(istype(T,/turf/space)) continue
			if(T.density) continue
			if(T.x>world.maxx-6 || T.x<6)	continue
			if(T.y>world.maxy-6 || T.y<6)	continue
			turfs += T
		if(!turfs.len) turfs += pick(/turf in orange(6))
		var/turf/picked = pick(turfs)
		if(!isturf(picked)) return

		var/datum/effect_system/spark_spread/spark_system = new /datum/effect_system/spark_spread()
		spark_system.set_up(5, 0, user.loc)
		spark_system.start()
		playsound(user.loc, /datum/soundbyte/sparks, 50, 1)
		user.forceMove(picked)
		shieldcall_args[SHIELDCALL_ARG_FLAGS] |= SHIELDCALL_FLAG_ATTACK_BLOCKED | SHIELDCALL_FLAG_ATTACK_PASSTHROUGH

/obj/item/clothing/suit/armor/reactive/attack_self(mob/user, datum/event_args/actor/actor)
	. = ..()
	if(.)
		return
	active = !( active )
	if (active)
		to_chat(user, "<font color=#4F49AF>The reactive armor is now active.</font>")
		icon_state = "reactive"
	else
		to_chat(user, "<font color=#4F49AF>The reactive armor is now inactive.</font>")
		icon_state = "reactiveoff"
		add_fingerprint(user)
	return

/obj/item/clothing/suit/armor/reactive/emp_act(severity)
	active = 0
	icon_state = "reactiveoff"
	..()

// Alien armor has a chance to completely block attacks.
/obj/item/clothing/suit/armor/alien
	name = "alien enhancement vest"
	desc = "It's a strange piece of what appears to be armor. It looks very light and agile. Strangely enough it seems to have been designed for a humanoid shape."
	description_info = "It has a 20% chance to completely nullify an incoming attack, and the wearer moves slightly faster."
	icon_state = "alien_speed"
	blood_overlay_type = "armor"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	slowdown = -1
	body_cover_flags = UPPER_TORSO|LOWER_TORSO
	armor_type = /datum/armor/alien/medium
	siemens_coefficient = 0.4
	valid_accessory_slots = null
	var/block_chance = 20

/obj/item/clothing/suit/armor/alien/mob_armorcall(mob/defending, list/shieldcall_args, fake_attack)
	if(prob(block_chance))
		defending.visible_message(SPAN_DANGER("[src] completely absorbs [RESOLVE_SHIELDCALL_ATTACK_TEXT(shieldcall_args)]!"))
		shieldcall_args[SHIELDCALL_ARG_FLAGS] |= SHIELDCALL_FLAGS_FOR_COMPLETE_BLOCK
		return
	return ..()

/obj/item/clothing/suit/armor/alien/tank
	name = "alien protection suit"
	desc = "It's really resilient yet lightweight, so it's probably meant to be armor. Strangely enough it seems to have been designed for a humanoid shape."
	description_info = "It has a 40% chance to completely nullify an incoming attack."
	icon_state = "alien_tank"
	slowdown = 0
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor_type = /datum/armor/alien/heavy
	block_chance = 40

//Non-hardsuit ERT armor.
/obj/item/clothing/suit/armor/vest/ert
	name = "emergency response team armor"
	desc = "A set of armor worn by members of the Emergency Response Team."
	icon_state = "ertarmor_cmd"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS
	armor_type = /datum/armor/centcom/ert
	valid_accessory_slots = null

//Commander
/obj/item/clothing/suit/armor/vest/ert/command
	name = "emergency response team commander armor"
	desc = "A set of armor worn by the commander of an Emergency Response Team. Has blue highlights."

//Security
/obj/item/clothing/suit/armor/vest/ert/security
	name = "emergency response team security armor"
	desc = "A set of armor worn by security members of the Emergency Response Team. Has red highlights."
	icon_state = "ertarmor_sec"

//Engineer
/obj/item/clothing/suit/armor/vest/ert/engineer
	name = "emergency response team engineer armor"
	desc = "A set of armor worn by engineering members of the Emergency Response Team. Has orange highlights."
	icon_state = "ertarmor_eng"

//Medical
/obj/item/clothing/suit/armor/vest/ert/medical
	name = "emergency response team medical armor"
	desc = "A set of armor worn by medical members of the Emergency Response Team. Has blue and white highlights."
	icon_state = "ertarmor_med"

//Armor Vests
/obj/item/clothing/suit/storage/vest
	name = "armor vest"
	desc = "A standard kevlar vest with webbing attached."
	icon_state = "webvest"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	armor_type = /datum/armor/station/light
	allowed = list(/obj/item/gun,/obj/item/reagent_containers/spray/pepper,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/flashlight/maglight,/obj/item/clothing/head/helmet)

	body_cover_flags = UPPER_TORSO|LOWER_TORSO
	clothing_flags = CLOTHING_THICK_MATERIAL | CLOTHING_INJECTION_PORT

	cold_protection_cover = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_cover = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6
	worth_intrinsic = 100

/obj/item/clothing/suit/storage/vest/officer
	name = "officer armor vest"
	desc = "A standard kevlar vest with webbing attached. This one has a security holobadge clipped to the chest."
	icon_state = "officerwebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	icon_badge = "officerwebvest_badge"
	icon_nobadge = "officerwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/blueshield
	name = "blueshield armored vest"
	desc = "A synthetic polymer-woven armor vest. This one is marked with Blueshield lettering."
	icon_state = "blueshieldvest"

/obj/item/clothing/suit/storage/vest/blueshield/heavy
	name = "\improper Blueshield heavy armored vest"
	desc = "A synthetic polymer-woven armor vest with BLUESHIELD printed in distinctive blue lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "blueshieldwebvest"

/obj/item/clothing/suit/storage/vest/warden
	name = "warden armor vest"
	desc = "A standard kevlar vest with webbing attached. This one has a silver badge clipped to the chest."
	icon_state = "wardenwebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	icon_badge = "wardenwebvest_badge"
	icon_nobadge = "wardenwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/wardencoat
	name = "Warden's jacket"
	desc = "An armoured jacket with silver rank pips and livery."
	icon_state = "warden_jacket"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	inv_hide_flags = HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/wardencoat/alt
	name = "Warden's jacket"
	desc = "An armoured jacket with silver rank pips and livery."
	icon_state = "warden_alt"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/suit/storage/vest/hos
	name = "head of security armor vest"
	desc = "A standard kevlar vest with webbing attached. This one has a gold badge clipped to the chest."
	icon_state = "hoswebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	icon_badge = "hoswebvest_badge"
	icon_nobadge = "hoswebvest_nobadge"

/obj/item/clothing/suit/storage/vest/hoscoat
	name = "armored coat"
	desc = "A greatcoat enhanced with a special alloy for some protection and style."
	icon_state = "hos"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	inv_hide_flags = HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/hos_overcoat
	name = "security overcoat"
	desc = "A fashionable leather overcoat lined with a lightweight, yet tough armor."
	icon_state = "leathercoat-sec"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	inv_hide_flags = HIDETIE|HIDEHOLSTER
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "wcoat", SLOT_ID_LEFT_HAND = "wcoat")

//Jensen cosplay gear
/obj/item/clothing/suit/storage/vest/hoscoat/jensen
	name = "armored trenchcoat"
	desc = "A trenchcoat augmented with a special alloy for some protection and style."
	icon_state = "hostrench"
	inv_hide_flags = HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/hoscoat/combatcoat
	name = "security combat coat"
	desc = "A heavily armored vest worn under a thick coat. The gold embroidery suggests whoever wears this possesses a high rank."
	icon_state = "hoscombatcoat"
	blood_overlay_type = "armor"
	valid_accessory_slots = null

/obj/item/clothing/suit/storage/vest/pcrc
	name = "PCRC armor vest"
	desc = "A simple kevlar vest belonging to Proxima Centauri Risk Control. This one has a PCRC crest clipped to the chest."
	icon_state = "pcrcvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	icon_badge = "pcrcvest_badge"
	icon_nobadge = "pcrcvest_nobadge"

/obj/item/clothing/suit/storage/vest/oricon
	name = "\improper Orion Confederation armored vest"
	desc = "A synthetic armor vest. This one is marked with the crest of the Orion Confederation."
	icon_state = "solvest"

/obj/item/clothing/suit/storage/vest/oricon/heavy
	name = "\improper Orion Confederation heavy armored vest"
	desc = "A synthetic armor vest with PEACEKEEPER printed in distinctive blue lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "solwebvest"

/obj/item/clothing/suit/storage/vest/oricon/security
	name = "master at arms heavy armored vest"
	desc = "A synthetic armor vest with MASTER AT ARMS printed in silver lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "secwebvest"

/obj/item/clothing/suit/storage/vest/oricon/command
	name = "command heavy armored vest"
	desc = "A synthetic armor vest with Orion Confederation printed in detailed gold lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "comwebvest"

/obj/item/clothing/suit/storage/vest/tactical //crack at a more balanced mid-range armor, minor improvements over standard vests, with the idea "modern" combat armor would focus on energy weapon protection.
	name = "tactical armored vest"
	desc = "A heavy armored vest in a fetching tan. It is surprisingly flexible and light, even with the extra webbing and advanced ceramic plates."
	icon_state = "tacwebvest"
	item_state = "tacwebvest"
	armor_type = /datum/armor/station/tactical

/obj/item/clothing/suit/storage/vest/heavy/flexitac //a reskin of the above to have a matching armor set
	name = "tactical light vest"
	desc = "An armored vest made from advanced flexible ceramic plates. It's surprisingly mobile, if a little unfashionable."
	icon_state = "flexitac"
	item_state = "flexitac"
	cold_protection_cover = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = T0C - 20
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_MEDIUM
	weight = ITEM_WEIGHT_ARMOR_MEDIUM

/obj/item/clothing/suit/storage/vest/detective
	name = "detective armor vest"
	desc = "A standard kevlar vest in a vintage brown, it has a badge clipped to the chest that reads, 'Private investigator'."
	icon_state = "detectivevest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	icon_badge = "detectivevest_badge"
	icon_nobadge = "detectivevest_nobadge"

/obj/item/clothing/suit/storage/vest/press
	name = "press vest"
	icon_state = "pvest"
	desc = "A simple kevlar vest. This one has the word 'Press' embroidered on patches on the back and front."
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	allowed = list(/obj/item/flashlight,/obj/item/tape_recorder,/obj/item/pen,/obj/item/camera_film,/obj/item/camera,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/vest/heavy
	name = "heavy armor vest"
	desc = "A heavy kevlar vest with webbing attached."
	icon_state = "webvest"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	armor_type = /datum/armor/station/heavy
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_HEAVY
	weight = ITEM_WEIGHT_ARMOR_HEAVY
	max_combined_volume = WEIGHT_VOLUME_SMALL * 4

/obj/item/clothing/suit/storage/vest/heavy/officer
	name = "officer heavy armor vest"
	desc = "A heavy kevlar vest with webbing attached. This one has a security holobadge clipped to the chest."
	icon_state = "officerwebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	icon_badge = "officerwebvest_badge"
	icon_nobadge = "officerwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/warden
	name = "warden heavy armor vest"
	desc = "A heavy kevlar vest with webbing attached. This one has a silver badge clipped to the chest."
	icon_state = "wardenwebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	icon_badge = "wardenwebvest_badge"
	icon_nobadge = "wardenwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/hos
	name = "head of security heavy armor vest"
	desc = "A heavy kevlar vest with webbing attached. This one has a gold badge clipped to the chest."
	icon_state = "hoswebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	icon_badge = "hoswebvest_badge"
	icon_nobadge = "hoswebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/pcrc
	name = "PCRC heavy armor vest"
	desc = "A heavy kevlar vest belonging to Proxima Centauri Risk Control with webbing attached. This one has a PCRC crest clipped to the chest."
	icon_state = "pcrcwebvest_nobadge"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	icon_badge = "pcrcwebvest_badge"
	icon_nobadge = "pcrcwebvest_nobadge"

//Provides the protection of a merc voidsuit, but only covers the chest/groin, and also takes up a suit slot. In exchange it has no slowdown and provides storage.
/obj/item/clothing/suit/storage/vest/heavy/merc
	name = "heavy armor vest"
	desc = "A high-quality heavy kevlar vest in a fetching tan. The vest is surprisingly flexible, and possibly made of an advanced material."
	icon_state = "mercwebvest"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	armor_type = /datum/armor/station/combat
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_MEDIUM
	weight = ITEM_WEIGHT_ARMOR_MEDIUM

/obj/item/clothing/suit/storage/vest/capcarapace
	name = "captain's carapace"
	desc = "A fireproof, armored chestpiece reinforced with ceramic plates and plasteel pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the station's finest, although it does chafe your nipples."
	icon_state = "capcarapace"
	armor_type = /datum/armor/station/tactical

/obj/item/clothing/suit/storage/vest/formal
	name = "formal armored wear"
	desc = "this doesn't exist"
	worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	cold_protection_cover = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS			//big coats keep you big warm
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	icon = 'icons/clothing/suit/coats/dept_overcoats.dmi'
	armor_type = /datum/armor/security/light_formalwear

/obj/item/clothing/suit/storage/vest/formal/command
	name = "Command Great Overcoat"
	desc = "A special, light kevlar-woven overcoat meant for more formal, or warm, occasions. Comes with a free desire to oversee large train infrastructure systems."
	icon_state = "ihc_coat_blue"

/obj/item/clothing/suit/storage/vest/formal/command/caped
	name = "Command Great Overcoat Caped"
	desc = "A special, light kevlar-woven overcoat meant for more formal, or warm, occasions. This one has a cape attached, signifying the wearer's desire to be wrapped up in a comfy blanky."
	icon_state = "ihc_coat_cloak_blue"

/obj/item/clothing/suit/storage/vest/formal/cargo
	name = "Cargo Great Overcoat"
	desc = "A special, light armor-woven overcoat meant for more formal, or warm, occasions. It is not advisable to wear this if you aren't the Quartermaster, as that might get you extra crate duty for looking better than them."
	icon_state = "greatcoat_brown"

/obj/item/clothing/suit/storage/vest/formal/dark
	name = "Military Surplus Dark Overcoat"
	desc = "One of the many warm overcoats found in a washed up crate that bumped one of the Nanotrasen's cargo vessels in the dead of space. It has been bleached by solar radiation and you are sure it smells of space-mold. Has been dyed dark."
	icon_state = "mc_coat"

/obj/item/clothing/suit/storage/vest/formal/dark/caped
	name = "Military Surplus Dark Overcoat Caped"
	desc = "One of the many warm overcoats found in a washed up crate that bumped one of the Nanotrasen's cargo vessels in the dead of space. It has been bleached by solar radiation and you are sure it smells of space-mold. Has been dyed dark. Comes with a cape."
	icon_state = "mc_coat_cloak"

/obj/item/clothing/suit/storage/vest/formal/bleached
	name = "Military Surplus Bleached Overcoat Caped"
	desc = "One of the many warm overcoats found in a washed up crate that bumped one of the Nanotrasen's cargo vessels in the dead of space. It has been bleached by solar radiation and you are sure it smells of space-mold."
	icon_state = "ihc_coat_cloak"

//All of the armor below is mostly unused

/obj/item/clothing/suit/armor/centcom
	name = "CentCom armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	w_class = WEIGHT_CLASS_BULKY//bulky item
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/gun/projectile/ballistic/sec/flash, /obj/item/gun/projectile/energy,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/tank/emergency/oxygen,/obj/item/clothing/head/helmet)
	inv_hide_flags = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection_cover = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor"
	desc = "An old military-grade suit of armor. Incredibly robust against brute force damage! However, it offers little protection from energy-based weapons, which, combined with its bulk, makes it woefully obsolete."
	icon_state = "heavy"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "swat", SLOT_ID_LEFT_HAND = "swat")
	armor_type = /datum/armor/security/bulky_kinetic
	w_class = WEIGHT_CLASS_HUGE // Very bulky, very heavy.
	gas_transfer_coefficient = 0.90
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	inv_hide_flags = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 0
	encumbrance = ITEM_ENCUMBRANCE_ARMOR_SUPERHEAVY + ITEM_ENCUMBRANCE_ARMOR_SUPERHEAVY_GLOVES + ITEM_ENCUMBRANCE_ARMOR_SUPERHEAVY_BOOTS
	weight = ITEM_WEIGHT_ARMOR_SUPERHEAVY + ITEM_ENCUMBRANCE_ARMOR_SUPERHEAVY_GLOVES + ITEM_ENCUMBRANCE_ARMOR_SUPERHEAVY_BOOTS

/obj/item/clothing/suit/armor/tdome
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	inv_hide_flags = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor_type = /datum/armor/thunderdome

/obj/item/clothing/suit/armor/tdome/red
	name = "Thunderdome suit (red)"
	desc = "Reddish armor."
	icon_state = "tdred"
	siemens_coefficient = 1

/obj/item/clothing/suit/armor/tdome/green
	name = "Thunderdome suit (green)"
	desc = "Pukish armor."
	icon_state = "tdgreen"
	siemens_coefficient = 1

/obj/item/clothing/suit/armor/samurai
	name = "karuta-gane"
	desc = "An utterly ancient suit of Earth armor, reverently maintained and restored over the years. Designed for foot combat in an era where melee combat was the predominant focus, this suit offers no protection against energy attacks, although its lacquered exterior may occasionally deflect laser bolts."
	icon_state = "samurai"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "leather_coat", SLOT_ID_LEFT_HAND = "leather_coat")
	armor_type = /datum/armor/general/samurai
	w_class = WEIGHT_CLASS_BULKY
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	inv_hide_flags = HIDETIE|HIDEHOLSTER
	siemens_coefficient = 0.6
	valid_accessory_slots = null

//Modular plate carriers
/obj/item/clothing/suit/armor/pcarrier
	name = "plate carrier"
	desc = "A lightweight black plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own."
	icon = 'icons/obj/clothing/modular_armor.dmi'
	item_icons = list(SLOT_ID_SUIT = 'icons/mob/clothing/modular_armor.dmi')
	icon_state = "pcarrier"
	valid_accessory_slots = (\
		ACCESSORY_SLOT_OVER \
		|ACCESSORY_SLOT_INSIGNIA \
		|ACCESSORY_SLOT_ARMOR_C \
		|ACCESSORY_SLOT_ARMOR_A \
		|ACCESSORY_SLOT_ARMOR_L \
		|ACCESSORY_SLOT_ARMOR_S \
		|ACCESSORY_SLOT_ARMOR_M
		)
	restricted_accessory_slots = (\
		ACCESSORY_SLOT_OVER \
		|ACCESSORY_SLOT_INSIGNIA \
		|ACCESSORY_SLOT_ARMOR_C \
		|ACCESSORY_SLOT_ARMOR_A \
		|ACCESSORY_SLOT_ARMOR_L \
		|ACCESSORY_SLOT_ARMOR_S \
		|ACCESSORY_SLOT_ARMOR_M
		)
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/pcarrier/can_equip(mob/M, slot, mob/user, flags)
	. = ..()
	if(!.)
		return

	if(!ishuman(M))
		return

	var/mob/living/carbon/human/H = M

	if(H.gloves)
		if(H.gloves.body_cover_flags & ARMS)
			for(var/obj/item/clothing/accessory/A in src)
				if(A.body_cover_flags & ARMS)
					to_chat(H, "<span class='warning'>You can't wear \the [A] with \the [H.gloves], they're in the way.</span>")
					return FALSE
	if(H.shoes)
		if(H.shoes.body_cover_flags & LEGS)
			for(var/obj/item/clothing/accessory/A in src)
				if(A.body_cover_flags & LEGS)
					to_chat(H, "<span class='warning'>You can't wear \the [A] with \the [H.shoes], they're in the way.</span>")
					return FALSE
	return TRUE

/obj/item/clothing/suit/armor/pcarrier/alt
	desc = "A lightweight black plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own. This one has less material at the waist, making it more practical for belt-worn equipment."
	icon_state = "pcarrier_alt"

/obj/item/clothing/suit/armor/pcarrier/light
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate)

/obj/item/clothing/suit/armor/pcarrier/light/sol
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate, /obj/item/clothing/accessory/armor/tag)

/obj/item/clothing/suit/armor/pcarrier/light/nts
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate, /obj/item/clothing/accessory/armor/tag/nts)

/obj/item/clothing/suit/armor/pcarrier/light/ntbs
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate, /obj/item/clothing/accessory/armor/tag/ntbs)

/obj/item/clothing/suit/armor/pcarrier/light/ntc
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate, /obj/item/clothing/accessory/armor/tag/ntc)

/obj/item/clothing/suit/armor/pcarrier/medium
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches)

/obj/item/clothing/suit/armor/pcarrier/medium/sol
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag)

/obj/item/clothing/suit/armor/pcarrier/medium/civsec
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/civsec)

/obj/item/clothing/suit/armor/pcarrier/medium/command
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/com)

/obj/item/clothing/suit/armor/pcarrier/medium/nts
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/nts)

/obj/item/clothing/suit/armor/pcarrier/medium/ntc
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/ntc)

/obj/item/clothing/suit/armor/pcarrier/blue
	name = "blue plate carrier"
	desc = "A lightweight blue plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own."
	icon_state = "pcarrier_blue"

/obj/item/clothing/suit/armor/pcarrier/press
	name = "light blue plate carrier"
	desc = "A lightweight, light blue plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own."
	icon_state = "pcarrier_press"

/obj/item/clothing/suit/armor/pcarrier/blue/sol
	name = "peacekeeper plate carrier"
	desc = "A lightweight plate carrier vest with built-in spall guard. This one is in SCG Peacekeeper colors. It can be equipped with armor plates, but provides no protection of its own."
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches/blue, /obj/item/clothing/accessory/armor/armguards/blue, /obj/item/clothing/accessory/armor/tag)

/obj/item/clothing/suit/armor/pcarrier/green
	name = "green plate carrier"
	desc = "A lightweight green plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own."
	icon_state = "pcarrier_green"

/obj/item/clothing/suit/armor/pcarrier/navy
	name = "navy plate carrier"
	desc = "A lightweight navy blue plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own."
	icon_state = "pcarrier_navy"

/obj/item/clothing/suit/armor/pcarrier/tan
	name = "tan plate carrier"
	desc = "A lightweight tan plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own."
	icon_state = "pcarrier_tan"

/obj/item/clothing/suit/armor/pcarrier/tan/tactical
	name = "tactical plate carrier"
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/tactical, /obj/item/clothing/accessory/storage/pouches/large/tan)

/obj/item/clothing/suit/armor/pcarrier/combat
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/combat, /obj/item/clothing/accessory/storage/pouches/large)

//Brig Spec Variants
/obj/item/clothing/suit/armor/pcarrier/ballistic
	name = "ballistic plate carrier"
	desc = "A lightweight ballistic vest. Equipped with a ballistic armor plate by default, this armor consists of a kevlar weave augmented by a non-Newtonian gel layer."
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/ballistic)

/obj/item/clothing/suit/armor/pcarrier/ablative
	name = "ablative plate carrier"
	desc = "A lightweight deflector vest. Equipped with an ablative armor plate by default, this armor consists of a polished Cartesian Glance Plating and an inset network of heat sink channels."
	icon_state = "ablative"
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/ablative)

/obj/item/clothing/suit/armor/pcarrier/riot
	name = "riot suppression plate carrier"
	desc = "A lightweight padded vest. Equipped with a padded armor plate by default, this armor consists of a stab resistant kevlar weave and hardened fleximat padding."
	icon_state = "riot"
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/riot)

//Clown Op Carrier
/obj/item/clothing/suit/armor/pcarrier/clownop
	name = "clown commando plate carrier"
	desc = "A lightweight red and white plate carrier vest with built-in spall guard. It can be equipped with armor plates, but provides no protection of its own. Honk."
	icon_state = "clowncarrier"
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium)


//PARA Armor
/obj/item/clothing/suit/armor/vest/para
	name = "PARA light armor"
	desc = "Light armor emblazoned with the device of an Eye. When equipped by trained PMD agents, runes set into the interior begin to glow."
	icon_state = "para_ert_armor"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|ARMS
	armor_type = /datum/armor/centcom/ert/paracausal
	item_action_name = "Enable Armor Sigils"

	var/anti_magic = FALSE
	var/blessed = FALSE

/obj/item/clothing/suit/armor/vest/para/attack_self(mob/user, datum/event_args/actor/actor)
	. = ..()
	if(.)
		return
	if(user.mind.isholy && !anti_magic && !blessed)
		anti_magic = TRUE
		blessed = TRUE
		to_chat(user, "<font color=#4F49AF>You enable the armor's protective sigils.</font>")
	else
		anti_magic = FALSE
		blessed = FALSE
		to_chat(user, "<font color=#4F49AF>You disable the armor's protective sigils.</font>")

	if(!user.mind.isholy)
		to_chat(user, "<font color='red'>You can't figure out what these symbols do.</font>")

/obj/item/clothing/suit/armor/para/inquisitor
	name = "inquisitor's coat"
	desc = "A flowing, armored coat adorned with occult iconography."
	icon_state = "witchhunter"
	item_state_slots = list(SLOT_ID_RIGHT_HAND = "armor", SLOT_ID_LEFT_HAND = "armor")
	blood_overlay_type = "armor"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO
	armor_type = /datum/armor/centcom/ert/paracausal
	item_action_name = "Enable Coat Sigils"
	valid_accessory_slots = null

/obj/item/clothing/suit/armor/vest/wolftaur
	name = "wolf-taur armor vest"
	desc = "An armored vest that protects against some damage. It appears to be created for a wolf-taur."
	species_restricted = null //Species restricted since all it cares about is a taur half
	icon = 'icons/mob/clothing/taursuits_wolf.dmi'
	icon_state = "heavy_wolf_armor"
	item_state = "heavy_wolf_armor"
	valid_accessory_slots = null

/obj/item/clothing/suit/armor/vest/wolftaur/can_equip(mob/M, slot, mob/user, flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/H
	if(istype(H) && istype(H.tail_style, /datum/sprite_accessory/tail/legacy_taur/wolf))
		return
	else
		to_chat(H,"<span class='warning'>You need to have a wolf-taur half to wear this.</span>")
		return FALSE

/obj/item/clothing/suit/storage/vest/oricon
	name = "\improper Orion Confederation Government armored vest"
	desc = "A synthetic armor vest. This one is marked with the crest of the Orion Confederation Group."

/obj/item/clothing/suit/storage/vest/oricon/heavy
	name = "\improper Orion Confederation Government heavy armored vest"
	desc = "A synthetic armor vest with SECURITY printed in distinctive blue lettering on the chest. This one has added webbing and ballistic plates." // JSDF does peacekeeping, not these guys.

/obj/item/clothing/suit/storage/vest/oricon/security
	name = "master at arms heavy armored vest"
	desc = "A synthetic armor vest with MASTER AT ARMS printed in silver lettering on the chest. This one has added webbing and ballistic plates."

/obj/item/clothing/suit/storage/vest/oricon/command
	name = "command heavy armored vest"
	desc = "A synthetic armor vest with Orion Confederation Government printed in detailed gold lettering on the chest. This one has added webbing and ballistic plates."

/obj/item/clothing/suit/armor/combat/JSDF
	name = "marine body armor"
	desc = "When I joined the Corps, we didn't have any fancy-schmanzy armor. We had sticks! Two sticks, and a rock for the whole platoon - and we had to <i>share</i> the rock!"
	icon_state = "unsc_armor"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO // ToDo: Break up the armor into smaller bits.

/obj/item/clothing/suit/armor/combat/imperial
	name = "imperial soldier armor"
	desc = "Made out of an especially light metal, it lets you conquer in style."
	icon_state = "ge_armor"
	body_cover_flags = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/suit/armor/combat/imperial/centurion
	name = "imperial centurion armor"
	desc = "Not all heroes wear capes, but it'd be cooler if they did."
	icon_state = "ge_armorcent"

/obj/item/clothing/suit/armor/bone
	name = "bone armor"
	desc = "A tribal armor plate, crafted from animal bone."
	icon_state = "bonearmor"
	armor_type = /datum/armor/lavaland/bone
	body_cover_flags = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

//Strange Plate Armor
/obj/item/clothing/suit/armor/bulletproof/kettle
	name = "bulky imperial plate"
	desc = "Often sold in tandem with KTL helmets, this sturdy plate armor offers impressive protection against bullets. These suits are believed to originate from an isolationist human society on the Eastern Rim."
	icon_state = "ironplate"
	armor_type = /datum/armor/imperial/plate

/obj/item/clothing/suit/armor/bulletproof/kettle/adamant
	name = "adamant imperial plate"
	desc = "Much more rare than standard Imperial plate, adamant armor protects against lasers and radiation as well as bullets. These suits are believed to originate from an isolationist human society on the Eastern Rim."
	icon_state = "aplate"
	armor_type = /datum/armor/imperial/adamant

//Plate Harness Armor. Has no intrinsic protective value, but serves as a lightweight anchor for limb plating.
/obj/item/clothing/suit/armor/plate_harness
	name = "lightweight harness"
	desc = "A lightweight harness designed to attach to the torso. It serves as an anchor point for lightweight armor plating, but provides no protection of its own."
	icon = 'icons/obj/clothing/ties.dmi'
	item_icons = list(SLOT_ID_SUIT = 'icons/mob/clothing/ties.dmi')
	icon_state = "pilot_webbing1"
	valid_accessory_slots = (\
		ACCESSORY_SLOT_ARMOR_C\
		|ACCESSORY_SLOT_ARMOR_A\
		|ACCESSORY_SLOT_ARMOR_L\
		|ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = (\
		ACCESSORY_SLOT_ARMOR_C\
		|ACCESSORY_SLOT_ARMOR_A\
		|ACCESSORY_SLOT_ARMOR_L\
		|ACCESSORY_SLOT_ARMOR_M)
	blood_overlay_type = "armor"

//Pirate Armor
/obj/item/clothing/suit/storage/vest/tactical/pirate
	name = "surplus tactical vest"
	desc = "A surplus tactical vest. Although its aging webbing remains intact, its original armor plating has long since been replaced."
	armor_type = /datum/armor/pirate/light

/obj/item/clothing/suit/armor/tactical/pirate
	name = "defaced tactical armor"
	desc = "This tactical armor has been painted over and repaired multiple times. Accumulated battle damage has degraded its protective capabilities significantly."
	icon_state = "swatarmor_pirate"
	armor_type = /datum/armor/pirate/light
	siemens_coefficient = 0.7

//Ashlander armor
/obj/item/clothing/suit/armor/ashlander
	name = "ashen lamellar panoply"
	desc = "This worn armor is fashioned out of bronze plates connected by dried sinew. The hammered plates are scuffed by ash and soot."
	icon = 'icons/clothing/suit/ashlander.dmi'
	icon_state = "lamellar"
	armor_type = /datum/armor/lavaland/ashlander
	allowed = list(/obj/item/clothing/head/helmet/ashlander, /obj/item/melee, /obj/item/gun/projectile/ballistic)
	worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL

/obj/item/clothing/suit/armor/ashlander/xeno
	name = "wyrm chitin armor"
	desc = "Armor crafted from the chitin of now vanquished invading monsters from the stars. These relic suits are now prized symbols of Scorian victory over the invaders."
	icon_state = "surtxeno"
	armor_type = /datum/armor/lavaland/xeno

//More Warhammer Fun
/obj/item/clothing/suit/armor/utilitarian
	name = "utilitarian military armor"
	desc = "This high tech armor serves to protect the user from ranged attacks, rather than melee."
	icon = 'icons/clothing/suit/armor/utilitarian.dmi'
	icon_state = "tau"
	armor_type = /datum/armor/general/utilitarian_military
	worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL

/obj/item/clothing/suit/armor/baroque
	name = "baroque military armor"
	desc = "This ornately decorated armor has been lovingly adorned with holy symbols. It smells faintly of incense."
	icon = 'icons/clothing/suit/armor/baroque.dmi'
	icon_state = "sister"
	armor_type = /datum/armor/general/baroque_military
	worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL

/* Replika armor
/obj/item/clothing/suit/armor/replika/klbr
    name = "controller replikant armored chestplate"
    desc = "A sloped titanium-composite chest plate fitted for use by 2nd generation biosynthetics. The right shoulder has been painted an imposing shade of red."
    icon = 'icons/clothing/suit/armor/replika.dmi'
    icon_state = "klbr"
    worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL
    body_cover_flags = UPPER_TORSO
    armor_type = /datum/armor/station/medium

/obj/item/clothing/suit/armor/replika/lstr
    name = "combat-engineer replikant armored chestplate"
    desc = "A sloped titanium-composite chest plate fitted for use by 2nd generation biosynthetics. This plain-white version is a staple of SbRD's combat-engineer replikants."
    icon = 'icons/clothing/suit/armor/replika.dmi'
    icon_state = "lstr"
    worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL
    body_cover_flags = UPPER_TORSO
    armor_type = /datum/armor/station/medium

/obj/item/clothing/suit/armor/replika/stcr
    name = "security-controller replikant armored chestplate"
    desc = "A sloped titanium-composite chest plate fitted for use by 2nd generation biosynthetics. This version sports multiple red adjustable straps and a lack of shoulder pads."
    icon = 'icons/clothing/suit/armor/replika.dmi'
    icon_state = "stcr"
    worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL
    body_cover_flags = UPPER_TORSO
    armor_type = /datum/armor/station/medium

/obj/item/clothing/suit/armor/replika/star
    name = "security-technician replikant armored chestplate"
    desc = "A sloped titanium-composite chest plate with a matte black finish, fitted for use by 2nd generation biosynthetics. Comes with red adjustable straps."
    icon = 'icons/clothing/suit/armor/replika.dmi'
    icon_state = "star"
    worn_render_flags = WORN_RENDER_SLOT_ONE_FOR_ALL
    body_cover_flags = UPPER_TORSO
    armor_type = /datum/armor/station/medium */
