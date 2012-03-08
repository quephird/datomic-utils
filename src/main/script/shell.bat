@echo off

setlocal EnableDelayedExpansion
FOR /F "delims=" %%i IN ('.\script\classpath.bat') DO (set CLASSPATH=%%i)

SET USER_SCRIPT=%1
SHIFT

IF NOT DEFINED XMS SET XMS=96m

REM This heap size is less than the one specified for a Linux environment;
REM See http://stackoverflow.com/questions/171205/java-maximum-memory-on-windows-xp
REM for some background information.
IF NOT DEFINED XMX SET XMX=1G

IF DEFINED LOG_GC SET LOG_GC=-Xloggc:%LOG_GC% -XX:+PrintGCDetails

IF NOT DEFINED LOG_DIR SET LOG_DIR=log

echo XMS is %XMS%
echo XMX is %XMX%
echo LOG_GC is %LOG_GC%
echo LOG_DIR is %LOG_DIR%

java %LOGBACK_OVERRIDE% -server %LOG_GC% -Xmx%XMX% -Xms%XMS% -XX:-PrintGCDetails -XX:-PrintGCApplicationConcurrentTime -XX:-PrintGCApplicationStoppedTime -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -cp %CLASSPATH% -DLOG_DIR=%LOG_DIR% jline.ConsoleRunner clojure.main script\shell.clj %*

