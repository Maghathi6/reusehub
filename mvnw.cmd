@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM Begin all REM://maven.apache.org/ :
@REM Maven Wrapper script for Windows

@echo off
setlocal

set MAVEN_PROJECTBASEDIR=%~dp0
set MAVEN_CMD_LINE_ARGS=%*

@REM Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.
echo.
goto error

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%\bin\java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.
echo.
goto error

:execute
@REM Setup Maven Wrapper

set WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
set WRAPPER_PROPERTIES="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties"

@REM Check if wrapper jar exists, if not download it
if exist %WRAPPER_JAR% goto runMaven

echo Downloading Maven Wrapper...
@REM Download wrapper jar
for /f "tokens=2 delims==" %%a in ('findstr /i "wrapperUrl" %WRAPPER_PROPERTIES%') do set WRAPPER_URL=%%a
"%JAVA_EXE%" -cp "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper" org.apache.maven.wrapper.MavenWrapperMain %MAVEN_CMD_LINE_ARGS%
if %ERRORLEVEL% equ 0 goto end
@REM If that fails, try direct download approach
powershell -Command "& {Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile '%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar' -UseBasicParsing}" >NUL 2>&1

:runMaven
@REM Find Maven distribution
for /f "tokens=2 delims==" %%a in ('findstr /i "distributionUrl" %WRAPPER_PROPERTIES%') do set MAVEN_DIST_URL=%%a

@REM Setup local Maven repo path
set MAVEN_USER_HOME=%USERPROFILE%\.m2
set MAVEN_WRAPPER_DIR=%MAVEN_USER_HOME%\wrapper\dists

@REM Extract Maven version from URL
for %%f in (%MAVEN_DIST_URL%) do set MAVEN_ZIP_NAME=%%~nf
set MAVEN_HOME_DIR=%MAVEN_WRAPPER_DIR%\%MAVEN_ZIP_NAME%

@REM Download Maven if not present
if exist "%MAVEN_HOME_DIR%\bin\mvn.cmd" goto runWithMaven

echo.
echo Downloading Apache Maven (first time only, this may take a minute)...
echo URL: %MAVEN_DIST_URL%
echo.

if not exist "%MAVEN_WRAPPER_DIR%" mkdir "%MAVEN_WRAPPER_DIR%"
set MAVEN_ZIP=%MAVEN_WRAPPER_DIR%\%MAVEN_ZIP_NAME%.zip

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%MAVEN_DIST_URL%' -OutFile '%MAVEN_ZIP%' -UseBasicParsing}"

if not exist "%MAVEN_ZIP%" (
    echo ERROR: Failed to download Maven. Check your internet connection.
    goto error
)

echo Extracting Maven...
powershell -Command "& {Expand-Archive -Path '%MAVEN_ZIP%' -DestinationPath '%MAVEN_WRAPPER_DIR%' -Force}"

@REM Rename extracted folder
for /d %%d in ("%MAVEN_WRAPPER_DIR%\apache-maven-*") do (
    if not "%%d"=="%MAVEN_HOME_DIR%" (
        if exist "%MAVEN_HOME_DIR%" rmdir /s /q "%MAVEN_HOME_DIR%"
        rename "%%d" "%MAVEN_ZIP_NAME%"
    )
)

del "%MAVEN_ZIP%" >NUL 2>&1

:runWithMaven
set MAVEN_HOME=%MAVEN_HOME_DIR%
set M2_HOME=%MAVEN_HOME%
set PATH=%MAVEN_HOME%\bin;%PATH%
set MAVEN_OPTS=-Dfile.encoding=UTF-8

"%MAVEN_HOME%\bin\mvn.cmd" %MAVEN_CMD_LINE_ARGS%
if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end
endlocal & set ERROR_CODE=%ERROR_CODE%
cmd /C exit /B %ERROR_CODE%
