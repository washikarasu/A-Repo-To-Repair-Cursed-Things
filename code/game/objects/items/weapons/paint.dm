//NEVER USE THIS IT SUX	-PETETHEGOAT
//THE GOAT WAS RIGHT - RKF

var/global/list/cached_icons = list()

/obj/item/reagent_containers/glass/paint
	desc = "It's a paint bucket."
	name = "paint bucket"
	icon = 'icons/obj/items.dmi'
	icon_state = "paint_neutral"
	item_state = "paintcan"
	materials_base = list(MAT_STEEL = 200)
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(10,20,30,60)
	volume = 60
	integrity_flags = INTEGRITY_ACIDPROOF
	atom_flags = OPENCONTAINER
	var/paint_type = "red"

/obj/item/reagent_containers/glass/paint/afterattack(atom/target, mob/user, clickchain_flags, list/params)
	if(!(clickchain_flags & CLICKCHAIN_HAS_PROXIMITY)) return
	if(istype(target) && reagents.total_volume > 5)
		user.visible_message("<span class='warning'>\The [target] has been splashed with something by [user]!</span>")
		reagents.trans_to_turf(target, 5)
	else
		return ..()

/obj/item/reagent_containers/glass/paint/New()
	if(paint_type && length(paint_type) > 0)
		name = paint_type + " " + name
	..()
	reagents.add_reagent("water", volume*3/5)
	reagents.add_reagent("plasticide", volume/5)
	if(paint_type == "white") //why don't white crayons exist
		reagents.add_reagent("aluminum", volume/5)
	else if (paint_type == "black")
		reagents.add_reagent("carbon", volume/5)
	else
		reagents.add_reagent("marker_ink_[paint_type]", volume/5)

/obj/item/reagent_containers/glass/paint/red
	icon_state = "paint_red"
	paint_type = "red"

/obj/item/reagent_containers/glass/paint/yellow
	icon_state = "paint_yellow"
	paint_type = "yellow"

/obj/item/reagent_containers/glass/paint/green
	icon_state = "paint_green"
	paint_type = "green"

/obj/item/reagent_containers/glass/paint/blue
	icon_state = "paint_blue"
	paint_type = "blue"

/obj/item/reagent_containers/glass/paint/purple
	icon_state = "paint_violet"
	paint_type = "purple"

/obj/item/reagent_containers/glass/paint/black
	icon_state = "paint_black"
	paint_type = "black"

/obj/item/reagent_containers/glass/paint/white
	icon_state = "paint_white"
	paint_type = "white"
