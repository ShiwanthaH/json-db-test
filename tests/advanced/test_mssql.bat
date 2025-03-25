@echo off
set MSSQLUSER=admin
set MSSQLPASSWORD=admin
set MSSQLHOST=localhost
set DBNAME=mssql_test

:: Check if database exists, create if not
sqlcmd -S %MSSQLHOST% -U %MSSQLUSER% -P %MSSQLPASSWORD% -Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '%DBNAME%') CREATE DATABASE %DBNAME%"

echo Running test scripts...
:: Run test scripts
sqlcmd -S %MSSQLHOST% -U %MSSQLUSER% -P %MSSQLPASSWORD% -d %DBNAME% -i ../../dbscripts/testscripts/advanced/mssql.sql

echo Test scripts completed.
