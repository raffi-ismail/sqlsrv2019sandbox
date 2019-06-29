#!/bin/sh
# Sleep for 30 seconds before running sqlcmd with inputfile startup.sql
# This SQL file will restore AdventureWorks2017 demo database at [AdventureWorks]
# along with a trigger to prevent demo user from changing their own password
# and sets some pretty restrictive permissions to sandbox the environment
# The delay before running sqlcmd in background is needed becasuse it is the only way to
# perform the necessary transact-SQL statements AFTER the sqlservr starts.

echo :setvar TMP_DIR $TMP_DIR >> $TMP_DIR/startups.sql
echo :setvar SA_PASSWORD $SA_PASSWORD > $TMP_DIR/startups.sql
echo :setvar SANDBOX_DB $SANDBOX_DB >> $TMP_DIR/startups.sql
echo :setvar SANDBOX_USERNAME $SANDBOX_USERNAME >> $TMP_DIR/startups.sql
echo :setvar SANDBOX_PASSWORD $SANDBOX_PASSWORD >> $TMP_DIR/startups.sql
echo :setvar SQL_DATA_DIR $SQL_DATA_DIR >> $TMP_DIR/startups.sql
echo :setvar DEMO_BACKUP_NAME $DEMO_BACKUP_NAME >> $TMP_DIR/startups.sql
echo :setvar DEMO_BACKUP_FILENAME $TMP_DIR/$DEMO_BACKUP_NAME\.bak >> $TMP_DIR/startups.sql
echo :setvar DEMO_BACKUP_NAME_MDF_PATH $SQL_DATA_DIR/$DEMO_BACKUP_NAME\.mdf >> $TMP_DIR/startups.sql
echo :setvar DEMO_BACKUP_NAME_LOG $DEMO_BACKUP_NAME\_log >> $TMP_DIR/startups.sql
echo :setvar DEMO_BACKUP_NAME_LOG_PATH $SQL_DATA_DIR/$DEMO_BACKUP_NAME\.ldf >> $TMP_DIR/startups.sql

cat $TMP_DIR/startups.sql

sleep 30 && /opt/mssql-tools/bin/sqlcmd \
    -S localhost \
    -U SA \
    -P $SA_PASSWORD \
    -i $TMP_DIR/startups.sql &
MSSQL_PID=$MSSQL_PID /opt/mssql/bin/sqlservr --accept-eula
#/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD

