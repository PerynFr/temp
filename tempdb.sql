USE [tempdb];
GO
EXEC sp_MSforeachtable "IF (OBJECT_ID(N'[dbo].[##temp_##]') IS NOT NULL) DROP TABLE [dbo].[##temp_##];";
GO
DBCC SHRINKDATABASE (tempdb, 0);
GO
