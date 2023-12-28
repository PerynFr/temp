EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all_constraints"
GO
DBCC SHRINKDATABASE (tempdb, 0)
GO
EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all_constraints"
GO
