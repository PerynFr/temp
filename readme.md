USE AdventureWorks;
SELECT s.name
FROM sys.schemas s
WHERE s.principal_id = USER_ID('your username');
после взятия имени схемы вы можете изменить авторизацию на схеме следующим образом:

ALTER AUTHORIZATION ON SCHEMA::db_owner TO dbo;

  
  SELECT s.name AS [schema_name], dp1.name AS [owner_name]
  FROM sys.schemas AS s
  INNER JOIN sys.database_principals AS dp1 ON dp1.principal_id = s.principal_id  
  
https://meet.vtbcapital.ru/en-US/meeting/977840590?secret=Gw0nDnGqsaMcMJpBpRkRD
