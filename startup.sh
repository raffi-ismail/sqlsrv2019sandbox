#!/bin/sh
sleep 30 && /opt/mssql-tools/bin/sqlcmd \
    -S localhost \
    -U SA \
    -P $SA_PASSWORD \
    -i /var/startup.sql &
/opt/mssql/bin/sqlservr --accept-eula
#/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $PASSWORD
