/*
	Telekinesis

	This needs more thinking out, but I might as well.
*/
var/const/tk_maxrange = 15

/*
	Telekinetic attack:

	By default, emulate the user's unarmed attack
*/
/atom/proc/attack_tk(mob/user)
	if(user.stat) return
	user.UnarmedAttack(src,0) // attack_hand, attack_paw, etc
	return

/*
	This is similar to item attack_self, but applies to anything
	that you can grab with a telekinetic grab.

	It is used for manipulating things at range, for example, opening and closing closets.
	There are not a lot of defaults at this time, add more where appropriate.
*/
/atom/proc/attack_self_tk(mob/user)
	return

/obj/attack_tk(mob/user)
	if(user.stat) return
	if(anchored)
		..()
		return

	var/obj/item/tk_grab/O = new(src)
	user.put_in_active_hand(O)
	O.host = user
	O.focus_object(src)
	return

/obj/item/attack_tk(mob/user)
	if(user.stat || !isturf(loc)) return
	if((MUTATION_TELEKINESIS in user.mutations) && !user.get_active_held_item()) // both should already be true to get here
		var/obj/item/tk_grab/O = new(src)
		user.put_in_active_hand(O)
		O.host = user
		O.focus_object(src)
	else
		warning("Strange attack_tk(): MUTATION_TELEKINESIS([MUTATION_TELEKINESIS in user.mutations]) empty hand([!user.get_active_held_item()])")
	return


/mob/attack_tk(mob/user)
	return // needs more thinking about

/*
	MUTATION_TELEKINESIS Grab Item (the workhorse of old MUTATION_TELEKINESIS)

	* If you have not grabbed something, do a normal tk attack
	* If you have something, throw it at the target.  If it is already adjacent, do a normal attackby()
	* If you click what you are holding, or attack_self(), do an attack_self_tk() on it.
	* Deletes itself if it is ever not in your hand, or if you should have no access to MUTATION_TELEKINESIS.
*/
/obj/item/tk_grab
	name = "Telekinetic Grab"
	desc = "Magic"
	icon = 'icons/obj/magic.dmi'//Needs sprites
	icon_state = "2"
	item_flags = ITEM_DROPDEL | ITEM_NO_BLUDGEON
	//item_state = null
	w_class = WEIGHT_CLASS_HUGE
	layer = HUD_LAYER_BASE

	var/last_throw = 0
	var/atom/movable/focus = null
	var/mob/living/host = null

//stops MUTATION_TELEKINESIS grabs being equipped anywhere but into hands
/obj/item/tk_grab/equipped(mob/user, slot, accessory, creation, silent)
	. = ..()
	if(slot != SLOT_ID_HANDS)
		qdel(src)

/obj/item/tk_grab/attack_self(mob/user, datum/event_args/actor/actor)
	. = ..()
	if(.)
		return
	if(focus)
		focus.attack_self_tk(user)

/obj/item/tk_grab/afterattack(atom/target, mob/user, clickchain_flags, list/params)
	if(!target || !user)	return
	if(last_throw+3 > world.time)	return
	if(!host || host != user)
		qdel(src)
		return
	if(!(MUTATION_TELEKINESIS in host.mutations))
		qdel(src)
		return
	if(isobj(target) && !isturf(target.loc))
		return

	var/d = get_dist(user, target)
	if(focus)
		d = max(d, get_dist(user, focus)) // whichever is further
	if(d > tk_maxrange)
		to_chat(user, "<span class='notice'>Your mind won't reach that far.</span>")
		return

	if(!focus)
		focus_object(target, user)
		return

	if(target == focus)
		target.attack_self_tk(user)
		return // todo: something like attack_self not laden with assumptions inherent to attack_self


	if(!istype(target, /turf) && istype(focus,/obj/item) && target.Adjacent(focus))
		var/obj/item/I = focus
		var/resolved = target.attackby(I, user, user:get_organ_target())
		if(!resolved && target && I)
			I.afterattack(target,user,1) // for splashing with beakers
	else
		apply_focus_overlay()
		focus.throw_at_old(target, 10, 1, user)
		last_throw = world.time
	return

/obj/item/tk_grab/proc/focus_object(var/obj/target, var/mob/living/user)
	if(!istype(target,/obj))	return//Cant throw non objects atm might let it do mobs later
	if(target.anchored || !isturf(target.loc))
		qdel(src)
		return
	focus = target
	update_icon()
	apply_focus_overlay()
	return

/obj/item/tk_grab/proc/apply_focus_overlay()
	if(!focus)	return
	var/obj/effect/overlay/O = new /obj/effect/overlay(locate(focus.x,focus.y,focus.z))
	O.name = "sparkles"
	O.anchored = 1
	O.density = 0
	O.layer = FLY_LAYER
	O.setDir(pick(GLOB.cardinal))
	O.icon = 'icons/effects/effects.dmi'
	O.icon_state = "nothing"
	flick("empdisable",O)
	spawn(5)
		qdel(O)
	return

/obj/item/tk_grab/update_icon()
	cut_overlays()
	. = ..()
	if(focus && focus.icon && focus.icon_state)
		add_overlay(image(focus.icon,focus.icon_state))
