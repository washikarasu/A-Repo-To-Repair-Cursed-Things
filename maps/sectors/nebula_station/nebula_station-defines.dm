// TODO: Find out where this is actually supposed to go
/turf/simulated/wall/prepainted/nebula
	color = COLOR_DARK_RED
	paint_color = COLOR_WALL_GUNMETAL
	stripe_color = COLOR_DARK_RED

/turf/simulated/wall/r_wall/prepainted/nebula
	color = COLOR_DARK_RED
	paint_color = COLOR_WALL_GUNMETAL
	stripe_color = COLOR_DARK_RED

/obj/machinery/door/airlock/nebula
	name = "Medical Airlock"
	icon_state = "preview"
	req_one_access = list(ACCESS_MEDICAL_MAIN)
	assembly_type = /obj/structure/door_assembly/medical
	open_sound_powered = 'sound/machines/door/med1o.ogg'
	close_sound_powered = 'sound/machines/door/med1c.ogg'
	door_color = COLOR_WHITE
	stripe_color = COLOR_DARK_RED


/obj/map_helper/paint_stripe/nebula/color=COLOR_DARK_RED
