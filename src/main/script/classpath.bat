@echo off

SET s=.\lib\*

SET t=.\tools\*

setlocal EnableDelayedExpansion
FOR /F "delims=" %%i IN ('dir datomic-*.jar /b') DO (set d=%%i)

echo .\script;.\resources;%d%;%s%;%t%

