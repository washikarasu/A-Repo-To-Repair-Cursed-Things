// TODO: Hygienize EVERYTHING, say NO to unused areas
/area/sector/nebula_station
	name = "\improper Nebula Station"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	area_flags = AREA_RAD_SHIELDED // Requires power removed, like stationmaps should be defined by APC presence in area?
	ambience = AMBIENCE_GENERIC

/area/sector/nebula_station/maintenance
	name = "\improper Nebula Station Maintenance"
	icon_state = "maintcentral"
	ambience = AMBIENCE_MAINTENANCE


// Hallways
/area/sector/nebula_station/hallway_main
	icon_state = "dark"

/area/sector/nebula_station/hallway_secondary
	icon_state = "dark160"


// Facility Areas
/area/sector/nebula_station/common
	icon_state = "green"

/area/sector/nebula_station/common/cafebar
	name = "\improper Nebula Cafe & Bar"
	icon_state = "cafeteria"

/area/sector/nebula_station/common/cafeteria
	name = "\improper Cafeteria"
	icon_state = "cafeteria"

/area/sector/nebula_station/common/pantry
	name = "\improper Pantry"
	icon_state = "hydro"

/area/sector/nebula_station/common/chapel
	name = "\improper Chapel"
	icon_state = "chapel"
	ambience = AMBIENCE_CHAPEL


// Cargo Areas
/area/sector/nebula_station/cargo
	icon_state = "yellow"

/area/sector/nebula_station/cargo/cargo_waiting
	name = "\improper Waiting Room"
	icon_state = "cargo_hallway"

/area/sector/nebula_station/cargo/trade_dock
	name = "\improper Trade Dock"
	icon_state = "quartoffice"
	ambience = AMBIENCE_HANGAR


// Medical Areas
/area/sector/nebula_station/medical
	icon_state = "bluenew"

/area/sector/nebula_station/medical/medbay
	name = "\improper Medbay"
	icon_state = "medbay"

/area/sector/nebula_station/medical/oproom
	name = "\improper Emergency OR"
	icon_state = "surgery"


// Engineering Areas
/area/sector/nebula_station/engineering
	icon_state = "engineering"
	ambience = AMBIENCE_ENGINEERING

/area/sector/nebula_station/engineering/power

/area/sector/nebula_station/engineering/gas_storage
	name = "\improper "
	icon_state = "maint_pumpstation"
