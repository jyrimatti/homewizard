create table active_current_l1_a       (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_current_l2_a       (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_current_l3_a       (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_power_l1_w         (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_power_l2_w         (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_power_l3_w         (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_power_w            (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_voltage_l1_v       (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_voltage_l2_v       (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table active_voltage_l3_v       (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table total_power_export_kwh    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table total_power_export_t1_kwh (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table total_power_import_kwh    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table total_power_import_t1_kwh (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table wifi_strength             (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);