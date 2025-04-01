@echo off
set ORACLE_CONTAINER=oracle-demo
set ORACLE_USER=system
set ORACLE_PASSWORD=password
set SCRIPT_PATH=../dbscripts

:: Copy SQL scripts to container
echo Copying SQL scripts into container...
docker cp %SCRIPT_PATH% %ORACLE_CONTAINER%:/home/oracle/dbscripts

echo Creating schema and tables...
docker exec -i %ORACLE_CONTAINER% sqlplus %ORACLE_USER%/%ORACLE_PASSWORD%@%ORACLE_SERVICE% as sysdba @/home/oracle/dbscripts/oracle.sql

echo Schema and tables created.

echo Running test scripts...
docker exec -i %ORACLE_CONTAINER% sqlplus %ORACLE_USER%/%ORACLE_PASSWORD%@%ORACLE_SERVICE% as sysdba @/home/oracle/dbscripts/testscripts/oracle.sql

echo Test scripts completed.

:: Drop the schema (simulating database deletion)
echo Dropping schema and cleaning up...
docker exec -i %ORACLE_CONTAINER% sqlplus %ORACLE_USER%/%ORACLE_PASSWORD%@%ORACLE_SERVICE% as sysdba @/home/oracle/dbscripts/drop_schema.sql

:: Remove scripts from container after execution
echo Removing SQL scripts from container...
docker exec -i %ORACLE_CONTAINER% rm -r /home/oracle/dbscripts

echo Database setup completed and deleted!
exit
