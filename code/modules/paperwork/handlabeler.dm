/obj/item/hand_labeler
	name = "hand labeler"
	desc = "A combined label printer, applicator, and remover, all in a single portable device. Designed to be easy to operate and use."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler0"
	item_flags = ITEM_NO_BLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	drop_sound = 'sound/items/handling/tape_drop.ogg'
	pickup_sound = 'sound/items/handling/tape_pickup.ogg'
	worth_intrinsic = 50
	/// Tracks the current label text
	var/label
	/// How many labels are left in the current roll? Also serves as our "max".
	var/labels_left = 30
	/// Whether we are in label mode
	VAR_FINAL/mode = FALSE

/obj/item/hand_labeler/legacy_mob_melee_hook(mob/target, mob/user, clickchain_flags, list/params, mult, target_zone, intent)
	if(user.a_intent == INTENT_HARM)
		return ..()

/obj/item/hand_labeler/allow_auto_storage_insert(datum/event_args/actor/actor, datum/object_system/storage/storage)
	return ..() && !mode

/obj/item/hand_labeler/afterattack(atom/target, mob/user, clickchain_flags, list/params)
	if(!(clickchain_flags & CLICKCHAIN_HAS_PROXIMITY))
		return
	if(!mode)	//if it's off, give up.
		return
	if(target == loc)	// if placing the labeller into something (e.g. backpack)
		return		// don't set a label

	if(!labels_left)
		to_chat(user, "<span class='notice'>No labels left.</span>")
		return
	if(!label || !length(label))
		to_chat(user, "<span class='notice'>No text set.</span>")
		return
	if(length(target.name) + length(label) > 64)
		to_chat(user, "<span class='notice'>Label too big.</span>")
		return
	if(ishuman(target))
		to_chat(user, "<span class='notice'>The label refuses to stick to [target.name].</span>")
		return
	if(issilicon(target))
		to_chat(user, "<span class='notice'>The label refuses to stick to [target.name].</span>")
		return
	if(isobserver(target))
		to_chat(user, "<span class='notice'>[src] passes through [target.name].</span>")
		return
	if(istype(target, /obj/item/reagent_containers/glass))
		to_chat(user, "<span class='notice'>The label can't stick to the [target.name].  (Try using a pen)</span>")
		return
	if(istype(target, /obj/machinery/portable_atmospherics/hydroponics))
		var/obj/machinery/portable_atmospherics/hydroponics/tray = target
		if(!tray.mechanical)
			to_chat(user, "<span class='notice'>How are you going to label that?</span>")
			return
		tray.labelled = label
		spawn(1)
			tray.update_icon()

	user.visible_message("<span class='notice'>[user] labels [target] as [label].</span>", \
						 "<span class='notice'>You label [target] as [label].</span>")
	target.name = "[target.name] ([label])"

/obj/item/hand_labeler/attack_self(mob/user, datum/event_args/actor/actor)
	. = ..()
	if(.)
		return
	mode = !mode
	icon_state = "labeler[mode]"
	if(mode)
		to_chat(user, "<span class='notice'>You turn on \the [src].</span>")
		//Now let them chose the text.
		var/str = sanitizeSafe(input(user,"Label text?","Set label",""), MAX_NAME_LEN)
		if(!str || !length(str))
			to_chat(user, "<span class='notice'>Invalid text.</span>")
			return
		label = str
		to_chat(user, "<span class='notice'>You set the text to '[str]'.</span>")
	else
		to_chat(user, "<span class='notice'>You turn off \the [src].</span>")
