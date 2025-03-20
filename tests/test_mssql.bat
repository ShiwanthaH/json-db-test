@echo off
set MSSQLUSER=admin
set MSSQLPASSWORD=admin
set MSSQLHOST=localhost
set DBNAME=mssql_test

:: Check if database exists, create if not
sqlcmd -S %MSSQLHOST% -U %MSSQLUSER% -P %MSSQLPASSWORD% -Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '%DBNAME%') CREATE DATABASE %DBNAME%"

:: Run SQL scripts
sqlcmd -S %MSSQLHOST% -U %MSSQLUSER% -P %MSSQLPASSWORD% -d %DBNAME% -i ../dbscripts/mssql.sql

echo Tables and data created.

echo Running test scripts...
:: Run test scripts
sqlcmd -S %MSSQLHOST% -U %MSSQLUSER% -P %MSSQLPASSWORD% -d %DBNAME% -i ../dbscripts/testscripts/mssql.sql

echo Test scripts completed.

:: Delete the database after execution
echo Dropping database %DBNAME%...
sqlcmd -S %MSSQLHOST% -U %MSSQLUSER% -P %MSSQLPASSWORD% -Q "DROP DATABASE %DBNAME%"

echo Database and data setup completed and deleted!
exit
