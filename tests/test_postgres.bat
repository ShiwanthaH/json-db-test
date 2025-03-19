@echo off
set PGUSER=postgres
set PGPASSWORD=admin
set PGHOST=localhost
set DBNAME=psql_test

:: Check if database exists, create if not
psql -U %PGUSER% -h %PGHOST% -tc "SELECT 1 FROM pg_database WHERE datname='%DBNAME%'" | findstr /C:"1" >nul
if %errorlevel% neq 0 (
    echo Creating database %DBNAME%...
    psql -U %PGUSER% -h %PGHOST% -c "CREATE DATABASE %DBNAME%;"
)

:: Start the PostgreSQL Benchmark
pgbench -i -s 10 -h %PGHOST% -U %PGUSER% %DBNAME%

echo Creating tables and data...
:: Run SQL scripts
psql -U %PGUSER% -h %PGHOST% -d %DBNAME% -f ../dbscripts/postgres.sql
echo Tables and data created.

echo Running test scripts...
:: Run test scripts
psql -U %PGUSER% -h %PGHOST% -d %DBNAME% -f ../dbscripts/testscripts/postgres.sql
echo Test scripts completed.

:: Delete the database after execution
echo Dropping database %DBNAME%...
psql -U %PGUSER% -h %PGHOST% -c "DROP DATABASE %DBNAME%;"

echo Database and data setup completed and deleted!
exit
