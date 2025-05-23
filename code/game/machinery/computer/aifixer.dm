/obj/machinery/computer/aifixer
	name = "\improper AI system integrity restorer"
	desc = "Used with intelliCards containing nonfunctional AIs to restore them to working order."
	req_one_access = list(ACCESS_SCIENCE_ROBOTICS, ACCESS_COMMAND_BRIDGE)
	circuit = /obj/item/circuitboard/aifixer
	icon_keyboard = "tech_key"
	icon_screen = "ai-fixer"
	light_color = LIGHT_COLOR_PINK

	active_power_usage = 1000

	/// Variable containing transferred AI
	var/mob/living/silicon/ai/occupier
	/// Variable dictating if we are in the process of restoring the occupier AI
	var/restoring = FALSE

/obj/machinery/computer/aifixer/attackby(obj/item/I, mob/living/user)
	if(I.is_screwdriver())
		if(occupier)
			if(machine_stat & (NOPOWER|BROKEN))
				to_chat(user, SPAN_WARNING("The screws on [name]'s screen won't budge."))
			else
				to_chat(user, SPAN_WARNING("The screws on [name]'s screen won't budge and it emits a warning beep."))
			return
	if(istype(I, /obj/item/aicard))
		if(machine_stat & (NOPOWER|BROKEN))
			to_chat(user, SPAN_WARNING("This terminal isn't functioning right now."))
			return
		if(restoring)
			to_chat(user, SPAN_DANGER("Terminal is busy restoring [occupier] right now."))
			return

		var/obj/item/aicard/card = I
		if(occupier)
			if(card.grab_ai(occupier, user))
				occupier = null
		else if(card.carded_ai)
			var/mob/living/silicon/ai/new_occupant = card.carded_ai
			to_chat(new_occupant, SPAN_NOTICE("You have been transferred into a stationary terminal. Sadly there is no remote access from here."))
			to_chat(user, "<span class='notice'>Transfer Successful:</span> [new_occupant] placed within stationary terminal.")
			new_occupant.forceMove(src)
			new_occupant.cancel_camera()
			new_occupant.control_disabled = TRUE
			occupier = new_occupant
			card.clear()
			update_icon()
		else
			to_chat(user, SPAN_NOTICE("There is no AI loaded onto this computer, and no AI loaded onto [I]. What exactly are you trying to do here?"))
	return ..()

/obj/machinery/computer/aifixer/attack_hand(mob/user, datum/event_args/actor/clickchain/e_args)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	ui_interact(user)

/obj/machinery/computer/aifixer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AiRestorer", name)
		ui.open()

/obj/machinery/computer/aifixer/ui_data(mob/user, datum/tgui/ui)
	var/list/data = list()

	data["ejectable"] = FALSE
	data["AI_present"] = FALSE
	data["error"] = null
	if(!occupier)
		data["error"] = "Please transfer an AI unit."
	else
		data["AI_present"] = TRUE
		data["name"] = occupier.name
		data["restoring"] = restoring
		data["health"] = (occupier.health + 100) / 2
		data["isDead"] = occupier.stat == DEAD
		var/list/laws = list()
		for(var/datum/ai_law/law in occupier.laws.all_laws())
			laws += "[law.get_index()]: [law.law]"
		data["laws"] = laws

	return data

/obj/machinery/computer/aifixer/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE
	if(!occupier)
		restoring = FALSE

	switch(action)
		if("PRG_beginReconstruction")
			if((occupier?.health < 100) || (occupier?.stat == DEAD))
				to_chat(usr, "<span class='notice'>Reconstruction in progress. This will take several minutes.</span>")
				playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 25, FALSE)
				restoring = TRUE
				var/mob/observer/dead/ghost //TODO: FIX THIS SHIT
				if(ghost)
					ghost.notify_revive("Your core files are being restored!")
				. = TRUE

/obj/machinery/computer/aifixer/proc/Fix()
	use_power(active_power_usage)
	occupier.adjustOxyLoss(-5, 0, FALSE)
	occupier.adjustFireLoss(-5, 0, FALSE)
	occupier.adjustBruteLoss(-5, 0)
	if(occupier.health >= 0 && occupier.stat == DEAD)
		occupier.revive()

	return occupier.health < 100

/obj/machinery/computer/aifixer/process()
	if(..())
		if(restoring)
			var/oldstat = occupier.stat
			restoring = Fix()
			if(oldstat != occupier.stat)
				update_icon()

/obj/machinery/computer/aifixer/make_legacy_overlays()
	var/list/to_add_overlays = list()
	if(machine_stat & (NOPOWER|BROKEN))
		return

	if(restoring)
		to_add_overlays += "ai-fixer-on"
	if (occupier)
		switch (occupier.stat)
			if (CONSCIOUS)
				to_add_overlays += "ai-fixer-full"
			if (UNCONSCIOUS)
				to_add_overlays += "ai-fixer-404"
	else
		to_add_overlays += "ai-fixer-empty"
	add_overlay(to_add_overlays)
