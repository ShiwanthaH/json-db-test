@echo off
set DB2_CONTAINER_NAME=db2-container  
set DB2_USER=db2inst1
set DB2_PASSWORD=password
set DBNAME=db2_test

:: Check if the database exists
docker exec -i %DB2_CONTAINER_NAME% bash -c "su - %DB2_USER% -c 'db2 connect to %DBNAME%'" >nul 2>&1
if %errorlevel% neq 0 (
    echo Creating database %DBNAME%...
    docker exec -i %DB2_CONTAINER_NAME% bash -c "su - %DB2_USER% -c 'db2 CREATE DATABASE %DBNAME%'"
)

:: Connect to the database and initialize schema
echo Creating tables and data...
docker exec -i %DB2_CONTAINER_NAME% bash -c "su - %DB2_USER% -c 'db2 connect to %DBNAME% && db2 -tvf /database/scripts/db2.sql'"
echo Tables and data created.

:: Run test scripts
echo Running test scripts...
docker exec -i %DB2_CONTAINER_NAME% bash -c "su - %DB2_USER% -c 'db2 connect to %DBNAME% && db2 -tvf /database/scripts/testscripts/db2.sql'"
echo Test scripts completed.

:: Delete the database after execution
echo Dropping database %DBNAME%...
docker exec -i %DB2_CONTAINER_NAME% bash -c "su - %DB2_USER% -c 'db2 DROP DATABASE %DBNAME%'"

echo Database and data setup completed and deleted!
@REM exit
