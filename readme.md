USE AdventureWorks;
SELECT s.name
FROM sys.schemas s
WHERE s.principal_id = USER_ID('your username');
после взятия имени схемы вы можете изменить авторизацию на схеме следующим образом:

ALTER AUTHORIZATION ON SCHEMA::db_owner TO dbo;
