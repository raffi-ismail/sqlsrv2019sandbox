# MS SQL Server 2019 Sandboxed Environment
Basically a sandboxed MS SQL Server Develop edition with Adventure Works 2017 demo data.
I use this to deploy SQL Server in publicly accessible demos, where anyone would be free to tinker but shouldn't be able to wreak havoc
So there has to be fairly restrictive rules / permissions in place

## Using this image
* change the environment variables in Dockerfile as you see fit.
* by default, SQL username for the service is **diddle** and password **#Diddl3#**
* User cannot change password. The trigger *trg_alter_login* ensures this does not happen (created in startup.sql)
* User can perform INSERT, UPDATE but NOT DELETE, along with some other permissions
* modify startup.sql to customise these permissions

## Running the container
* To run the SQL service:
```Dockerfile
docker run -p 1433:1433 -d chubbycat/sqlsrv2019sandbox /var/startup.sh
```
* To debug, and enter shell
```Dockerfile
docker run -p 1433:1433 -ti chubbycat/sqlsrv2019sandbox /bin/sh
```