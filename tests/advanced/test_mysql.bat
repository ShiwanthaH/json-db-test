@echo off
set MYSQLUSER=root
set MYSQLPASSWORD=Test123#
set MYSQLHOST=localhost
set DBNAME=mysql_test

:: Check if database exists, create if not
mysql -u %MYSQLUSER% -p%MYSQLPASSWORD% -h %MYSQLHOST% -e "CREATE DATABASE IF NOT EXISTS %DBNAME%;"

echo Running test scripts...
:: Run test scripts
mysql -u %MYSQLUSER% -p%MYSQLPASSWORD% -h %MYSQLHOST% %DBNAME% < ../../dbscripts/testscripts/advanced/mysql.sql

echo Test scripts completed.

