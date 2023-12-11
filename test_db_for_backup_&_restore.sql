-- Создание тестовой базы данных
CREATE DATABASE TestDatabase;

-- Создание первой файловой группы
ALTER DATABASE TestDatabase
ADD FILEGROUP MainData;

-- Добавление файла в первую файловую группу
ALTER DATABASE TestDatabase
ADD FILE
(
    NAME = 'MainDataFile1',
    FILENAME = 'C:\Path\To\Data\MainDataFile1.ndf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5MB
)
TO FILEGROUP MainData;

-- Создание второй файловой группы
ALTER DATABASE TestDatabase
ADD FILEGROUP ArchiveData;

-- Добавление файла во вторую файловую группу
ALTER DATABASE TestDatabase
ADD FILE
(
    NAME = 'ArchiveDataFile1',
    FILENAME = 'C:\Path\To\Data\ArchiveDataFile1.ndf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5MB
)
TO FILEGROUP ArchiveData;

-- Добавление таблиц в файловую группу "MainData"
USE TestDatabase;
CREATE TABLE MainDataTable2 (ID INT, ProductName VARCHAR(50)) ON MainData;
CREATE TABLE MainDataTable3 (ID INT, Quantity INT) ON MainData;

-- Добавление таблиц в файловую группу "ArchiveData"
CREATE TABLE ArchiveDataTable2 (ID INT, Note VARCHAR(100)) ON ArchiveData;
CREATE TABLE ArchiveDataTable3 (ID INT, Status VARCHAR(50)) ON ArchiveData;

-- Вставка тестовых данных в таблицы "MainData"
INSERT INTO MainDataTable2 VALUES (1, 'Product A');
INSERT INTO MainDataTable3 VALUES (1, 100);

-- Вставка тестовых данных в таблицы "ArchiveData"
INSERT INTO ArchiveDataTable2 VALUES (1, 'Note for ArchiveData');
INSERT INTO ArchiveDataTable3 VALUES (1, 'Active');

