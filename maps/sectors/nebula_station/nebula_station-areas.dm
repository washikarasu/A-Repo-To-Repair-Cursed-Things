// TODO: Hygienize EVERYTHING, say NO to unused areas
/area/sector/nebula_station
	name = "Nebula Station"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	area_flags = AREA_RAD_SHIELDED // Requires power removed, like stationmaps should be defined by APC presence in area?
	// ambience = AMBIENCE_GENERIC // TODO: redefine later

// Facility Areas
/area/sector/nebula_station/cafebar
	name = "\improper Nebula Cafe & Bar"
	icon_state = "cafeteria"

// Cargo Areas
/area/sector/nebula_station/cargo

/area/sector/nebula_station/cargo/cargo_waiting
	name = "\improper Waiting Room"
	icon_state = "yellow"

// Medical Areas
/area/sector/nebula_station/medical

/area/sector/nebula_station/medical/medbay
	name = "\improper Medbay"
	icon_state = "medbay"

/area/sector/nebula_station/medical/oproom
	name = "\improper Emergency OR"
	icon_state = "surgery"
