-- Создание базы данных
USE [master]
GO
DROP DATABASE IF EXISTS [TestDatabase];
CREATE DATABASE [TestDatabase]
   ON  PRIMARY 
   ( NAME = N'MainDataFile1', FILENAME = N'D:\MSSQL15.DBA01\MSSQL\DATA\TestDatabase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 307200KB )
   FILEGROUP [ArchiveData] 
   ( NAME = N'ArchiveDataFile1', FILENAME = N'D:\MSSQL15.DBA01\MSSQL\DATA\ArchiveDataFile1.ndf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5120KB )
   LOG ON 
   ( NAME = N'TestDatabase_log', FILENAME = N'D:\MSSQL15.DBA01\MSSQL\DATA\TestDatabase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 307200KB )
   WITH CATALOG_COLLATION = DATABASE_DEFAULT;
GO

-- Добавление таблиц в файловую группу "PRIMARY"
USE TestDatabase;
CREATE TABLE MainDataTable2 (ID INT, ProductName VARCHAR(50));
CREATE TABLE MainDataTable3 (ID INT, Quantity INT);

-- Добавление таблиц в файловую группу "ArchiveData"
CREATE TABLE ArchiveDataTable2 (ID INT, Note VARCHAR(100)) ON ArchiveData;
CREATE TABLE ArchiveDataTable3 (ID INT, Status VARCHAR(50)) ON ArchiveData;

-- Вставка тестовых данных в таблицы "MainData"
INSERT INTO MainDataTable2 VALUES (1, 'Product A');
INSERT INTO MainDataTable3 VALUES (1, 100);

-- Вставка тестовых данных в таблицы "ArchiveData"
INSERT INTO ArchiveDataTable2 VALUES (1, 'Note for ArchiveData');
INSERT INTO ArchiveDataTable3 VALUES (1, 'Active');

-- Создание частичной резервной копии для файловой группы "ArchiveData", дальше ее можно не бэкапить часто
BACKUP DATABASE TestDatabase
   FILEGROUP = 'ArchiveData'
   TO DISK = 'D:\MSSQL15.DBA01\MSSQL\Backup\PartialArchiveDataBackup.bak'
   WITH INIT, FORMAT;
GO

-- Имитация вставки данных в файловую группу "PRIMARY"
USE TestDatabase;
INSERT INTO MainDataTable2 VALUES (1, 'Product FF');

-- Бэкап только "PRIMARY"
BACKUP DATABASE TestDatabase
   FILEGROUP = 'PRIMARY'
   TO DISK = 'D:\MSSQL15.DBA01\MSSQL\Backup\PartialMainDataBackup.bak'
   WITH INIT, FORMAT;
GO

-- Имитация вставки данных в файловую группу "PRIMARY"
USE TestDatabase;
INSERT INTO MainDataTable2 VALUES (1, 'Product FF');
-- Имитация вставки данных в файловую группу "ArchiveData"
INSERT INTO ArchiveDataTable2 VALUES (1, 'Note22 for ArchiveData');

-- Бэкап лога
BACKUP LOG [TestDatabase] TO DISK = N'D:\MSSQL15.DBA01\MSSQL\Backup\PartialMainDataBackup.trn' 
   WITH NOFORMAT, INIT, NAME = N'TestDatabase-Full Database Backup',
   SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO

-- Имитация вставки данных в файловую группу "PRIMARY"
USE TestDatabase;
INSERT INTO MainDataTable2 VALUES (1, 'Product FF');
-- Имитация вставки данных в файловую группу "ArchiveData"
INSERT INTO ArchiveDataTable2 VALUES (1, 'Note22 for ArchiveData');

-- Бэкап лога
BACKUP LOG [TestDatabase] TO DISK = N'D:\MSSQL15.DBA01\MSSQL\Backup\PartialMainDataBackup.trn' 
   WITH NOFORMAT, NOINIT, NAME = N'TestDatabase-Full Database Backup',
   SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO

-- Восстановление последовательности бэкапов
USE master;

-- Восстановление последней частичной резервной копии для файловой группы "PRIMARY"
RESTORE DATABASE TestDatabase
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'D:\MSSQL15.DBA01\MSSQL\Backup\PartialMainDataBackup.bak'
   WITH REPLACE, PARTIAL, NORECOVERY;

-- Восстановление последней резервной копии лога
RESTORE LOG TestDatabase FROM  DISK = 'D:\MSSQL15.DBA01\MSSQL\Backup\PartialMainDataBackup.trn' 
   WITH  FILE = 1,  NOUNLOAD,  STATS = 10, RECOVERY;
GO
