@echo off
set MYSQLUSER=root
set MYSQLPASSWORD=Test123#
set MYSQLHOST=localhost
set DBNAME=mysql_test

:: Check if database exists, create if not
mysql -u %MYSQLUSER% -p%MYSQLPASSWORD% -h %MYSQLHOST% -e "CREATE DATABASE IF NOT EXISTS %DBNAME%;"

echo Creating tables and data...
:: Run SQL scripts
mysql -u %MYSQLUSER% -p%MYSQLPASSWORD% -h %MYSQLHOST% %DBNAME% < ../dbscripts/mysql.sql

echo Tables and data created.

echo Running test scripts...
:: Run test scripts
mysql -u %MYSQLUSER% -p%MYSQLPASSWORD% -h %MYSQLHOST% %DBNAME% < ../dbscripts/testscripts/mysql.sql

echo Test scripts completed.

:: Delete the database after execution
echo Dropping database %DBNAME%...
mysql -u %MYSQLUSER% -p%MYSQLPASSWORD% -h %MYSQLHOST% -e "DROP DATABASE %DBNAME%;"

echo Database and data setup completed and deleted!
exit
