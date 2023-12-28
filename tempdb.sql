SELECT is_autoshrink_on, autoshrink_percent
FROM sys.databases
WHERE name = 'tempdb';

SELECT name, type_desc, physical_name
FROM sys.master_files
WHERE database_id = DB_ID('tempdb');

SELECT db_name(database_id) AS database_name, status, session_id
FROM sys.dm_db_session_users;
