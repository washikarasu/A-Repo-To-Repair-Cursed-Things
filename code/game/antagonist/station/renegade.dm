var/datum/antagonist/renegade/renegades

/datum/antagonist/renegade
	id = MODE_RENEGADE
	role_type = BE_RENEGADE
	role_text = "Renegade"
	role_text_plural = "Renegades"
	bantype = "renegade"
	restricted_jobs = list("AI", "Cyborg")
	welcome_text = "Something's going to go wrong today, you can just feel it. You're paranoid, you've got a gun, and you're going to survive."
	antag_sound = 'sound/effects/antag_notice/general_goodie_alert.ogg'
	antag_text = "You are a <b>minor</b> antagonist! Within the rules, \
		try to protect yourself and what's important to you. You aren't here to cause trouble, \
		you're just more willing (and equipped) to go to extremes to stop it than others are. \
		Your job is to somewhat oppose the other antagonists, should they threaten you, in ways that aren't quite legal themselves. \
		Try to make sure other players have <i>fun</i>! If you are confused or at a loss, always adminhelp, \
		and before taking extreme actions, please try to also contact the administration! \
		Think through your actions and make the roleplay immersive! <b>Please remember all \
		rules aside from those without explicit exceptions apply to antagonists.</b>"
	flags = ANTAG_SUSPICIOUS | ANTAG_IMPLANT_IMMUNE | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	can_speak_aooc = FALSE	// They aren't 'true' antags, but they still need to hear blanket antag instructions

	hard_cap = 8
	hard_cap_round = 12
	initial_spawn_req = 2
	initial_spawn_target = 4

	var/list/spawn_guns = list(
		/obj/item/gun/projectile/energy/laser,
		/obj/item/gun/projectile/energy/captain,
		/obj/item/gun/projectile/energy/lasercannon,
		/obj/item/gun/projectile/energy/xray,
		/obj/item/gun/projectile/energy/gun,
		/obj/item/gun/projectile/energy/gun/burst,
		/obj/item/gun/projectile/energy/gun/nuclear,
		/obj/item/gun/projectile/energy/crossbow,
		/obj/item/gun/projectile/energy/crossbow/largecrossbow,
		/obj/item/gun/projectile/ballistic/automatic,
		/obj/item/gun/projectile/ballistic/automatic/mini_uzi,
		/obj/item/gun/projectile/ballistic/automatic/c20r,
		/obj/item/gun/projectile/ballistic/automatic/sts35,
		/obj/item/gun/projectile/ballistic/automatic/bullpup,
		/obj/item/gun/projectile/ballistic/automatic/wt550,
		/obj/item/gun/projectile/ballistic/automatic/z8,
		/obj/item/gun/projectile/ballistic/automatic/tommygun,
		/obj/item/gun/projectile/ballistic/colt/detective,
		/obj/item/gun/projectile/ballistic/sec/wood,
		/obj/item/gun/projectile/ballistic/silenced,
		/obj/item/gun/projectile/ballistic/pistol,
		/obj/item/gun/projectile/ballistic/p92x,
		/obj/item/gun/projectile/ballistic/konigin,
		/obj/item/gun/projectile/ballistic/revolver,
		/obj/item/gun/projectile/ballistic/derringer,
		/obj/item/gun/projectile/ballistic/shotgun/pump,
		/obj/item/gun/projectile/ballistic/shotgun/pump/rifle,
		/obj/item/gun/projectile/ballistic/shotgun/pump/combat,
		/obj/item/gun/projectile/ballistic/shotgun/doublebarrel,
		/obj/item/gun/projectile/ballistic/revolver/judge,
		/obj/item/gun/projectile/ballistic/revolver/lemat,
		list(/obj/item/gun/projectile/ballistic/shotgun/doublebarrel/pellet, /obj/item/gun/projectile/ballistic/shotgun/doublebarrel/sawn),
		list(/obj/item/gun/projectile/ballistic/deagle, /obj/item/gun/projectile/ballistic/deagle/gold, /obj/item/gun/projectile/ballistic/deagle/camo),
		list(/obj/item/gun/projectile/ballistic/revolver/detective, /obj/item/gun/projectile/ballistic/revolver/deckard),
		list(/obj/item/gun/projectile/ballistic/luger,/obj/item/gun/projectile/ballistic/luger/brown)
		)

/datum/antagonist/renegade/New()
	..()
	renegades = src

/datum/antagonist/renegade/create_objectives(var/datum/mind/player)

	if(!..())
		return

	var/datum/objective/survive/survive = new
	survive.owner = player
	player.objectives |= survive

/datum/antagonist/renegade/equip(mob/living/carbon/human/player)

	if(!..())
		return

	var/gun_type = pick(spawn_guns)
	if(islist(gun_type))
		gun_type = pick(gun_type)
	var/obj/item/gun = new gun_type(player)

	// Attempt to put into a container.
	if(player.equip_to_slot_if_possible(gun, /datum/inventory_slot/abstract/put_in_storage, INV_OP_FLUFFLESS | INV_OP_SILENT))
		return

	// If that failed, attempt to put into any valid non-handslot
	if(player.equip_to_appropriate_slot(gun, INV_OP_SILENT | INV_OP_FLUFFLESS))
		return

	// If that failed, then finally attempt to at least let the player carry the weapon
	player.put_in_hands_or_drop(gun)


/proc/rightandwrong()
	to_chat(usr, "<B>You summoned guns!</B>")
	message_admins("[key_name_admin(usr, 1)] summoned guns!")
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == 2 || !(H.client)) continue
		if(is_special_character(H)) continue
		renegades.add_antagonist(H.mind)
