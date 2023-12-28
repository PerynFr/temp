USE tempdb;
GO

-- Удалите все временные таблицы с префиксами #
EXEC sp_MSForEachTable "IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '?' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME LIKE '#%')
    DROP TABLE ?";
GO

-- Удалите все временные таблицы с префиксами ##
EXEC sp_MSForEachTable "IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '?' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME LIKE '##%')
    DROP TABLE ?";
GO
