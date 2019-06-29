USE master
GO
sp_configure 'contained database authentication', 1;  
GO  
RECONFIGURE
GO  
CREATE TRIGGER trg_alter_login ON ALL SERVER
FOR ALTER_LOGIN
AS
    IF ORIGINAL_LOGIN()= 'diddle' 
    Begin   
        RAISERROR(N'Password change is not allowed here', 10, 1);
        ROLLBACK
    end
GO
RESTORE DATABASE AdventureWorks FROM DISK = N'/tmp/AdventureWorks2017.bak'
WITH REPLACE, FILE = 1,
    MOVE N'AdventureWorks2017' TO N'/var/opt/mssql/data/AdventureWorks2017.mdf',
    MOVE N'AdventureWorks2017_log' TO N'/var/opt/mssql/data/AdventureWorks2017.ldf'
GO
ALTER DATABASE AdventureWorks SET CONTAINMENT = PARTIAL
GO
USE AdventureWorks
GO
CREATE LOGIN diddle WITH PASSWORD = '#Diddl3#';
CREATE USER diddle FOR LOGIN diddle;
GRANT CREATE TABLE, SELECT, INSERT, UPDATE TO diddle;
DENY BACKUP DATABASE, BACKUP LOG, CREATE FUNCTION, CREATE PROCEDURE, CREATE RULE TO diddle;
GO




