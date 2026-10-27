/*
РГР2 — этап 1. Создание базы данных Doc_circulation_db.
СУБД: Microsoft SQL Server 2022 (Docker/Linux).

Запускать в соединении с экземпляром SQL Server, а не внутри транзакции.
Путь FILENAME относится к файловой системе СЕРВЕРА (контейнера).
Перед запуском проверьте наличие каталога /var/opt/mssql/data.
Данный скрипт не удаляет существующую базу.
*/
USE [master];
GO

IF DB_ID(N'Doc_circulation_db') IS NULL
BEGIN
    CREATE DATABASE [Doc_circulation_db]
    ON PRIMARY
    (
        NAME = N'Doc_circulation_db_data',
        FILENAME = N'/var/opt/mssql/data/Doc_circulation_db.mdf',
        SIZE = 16MB,
        MAXSIZE = 256MB,
        FILEGROWTH = 8MB
    )
    LOG ON
    (
        NAME = N'Doc_circulation_db_log',
        FILENAME = N'/var/opt/mssql/data/Doc_circulation_db_log.ldf',
        SIZE = 8MB,
        MAXSIZE = 128MB,
        FILEGROWTH = 8MB
    );
    PRINT N'База Doc_circulation_db создана.';
END
ELSE
BEGIN
    PRINT N'База Doc_circulation_db уже существует. Создание пропущено.';
END;
GO

/* Проверка параметров обоих файлов (размеры в МБ). */
SELECT
    d.name AS DatabaseName,
    mf.name AS LogicalFileName,
    mf.type_desc AS FileType,
    mf.physical_name AS PhysicalPath,
    CONVERT(decimal(12,2), mf.size / 128.0) AS CurrentSizeMB,
    CASE WHEN mf.max_size = -1 THEN NULL
         ELSE CONVERT(decimal(12,2), mf.max_size / 128.0) END AS MaxSizeMB,
    CASE WHEN mf.is_percent_growth = 1 THEN NULL
         ELSE CONVERT(decimal(12,2), mf.growth / 128.0) END AS GrowthMB
FROM sys.databases AS d
JOIN sys.master_files AS mf ON mf.database_id = d.database_id
WHERE d.name = N'Doc_circulation_db'
ORDER BY mf.type;
GO
