/datum/map/sector/nebula_station
	id = "nebula_station"
	name = "Sector - Nebula Station"
	width = 192
	height = 192
	levels = list(
		/datum/map_level/sector/nebula_station,
	)
	legacy_assert_shuttle_datums = list(
		/datum/shuttle/autodock/overmap/trade,
		/datum/shuttle/autodock/overmap/trade/udang,
		/datum/shuttle/autodock/overmap/trade/scoophead,
		/datum/shuttle/autodock/overmap/trade/arrowhead,
		/datum/shuttle/autodock/overmap/trade/caravan,
		/datum/shuttle/autodock/overmap/trade/adventurer,
		/datum/shuttle/autodock/overmap/trade/tug,
		/datum/shuttle/autodock/overmap/trade/utilitymicro,
		/datum/shuttle/autodock/overmap/trade/runabout,
		/datum/shuttle/autodock/overmap/trade/salvager,
	)

/datum/map_level/sector/nebula_station
	id = "NebulaStation"
	name = "Sector - Nebula Station"
	display_name = "Nebula Gas Station"
	path = "maps/sectors/nebula_station/levels/nebula_station.dmm"
	base_turf = /turf/space
	base_area = /area/space
