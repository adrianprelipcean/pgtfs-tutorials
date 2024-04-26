-- SPDX-FileCopyrightText: 2024 Adrian C. Prelipcean <adrianprelipceanc@gmail.com>
--
-- SPDX-License-Identifier: CC-BY-NC-SA-4.0

CREATE SCHEMA IF NOT EXISTS gtfs;

CREATE EXTENSION IF NOT EXISTS pgtfs;
CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS gtfs.stops (
    stop_id TEXT PRIMARY KEY,
    stop_name TEXT,
    stop_lat DOUBLE PRECISION,
    stop_lon DOUBLE PRECISION,
    location_type TEXT,
    stop_code TEXT,
    stop_desc TEXT,
    zone_id TEXT,
    parent_station TEXT,
    stop_url TEXT,
    stop_timezone TEXT,
    wheelchair_boarding INT
);

CREATE TABLE IF NOT EXISTS gtfs.trips (
    route_id TEXT,
    service_id TEXT,
    trip_id TEXT PRIMARY KEY,
    trip_headsign TEXT,
    trip_short_name TEXT,
    direction_id TEXT,
    block_id TEXT,
    shape_id TEXT,
    wheelchair_accessible INT, 
    bikes_allowed INT
);

CREATE TABLE IF NOT EXISTS gtfs.stop_times (
    trip_id TEXT,
    arrival_time INTERVAL,
    departure_time INTERVAL,
    stop_id TEXT,
    stop_sequence INTEGER,
    stop_headsign TEXT,
    pickup_type TEXT,
    dropoff_type TEXT,
    shape_dist_traveled DOUBLE PRECISION,
    timepoint TEXT,
    PRIMARY KEY (trip_id, stop_sequence),
    FOREIGN KEY (trip_id) REFERENCES gtfs.trips (trip_id),
    FOREIGN KEY (stop_id) REFERENCES gtfs.stops (stop_id)
);
