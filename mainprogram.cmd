 
@echo off

cls
rem sicherung10.cmd 
rem Dieser Batch-Code führt eine Sicherung von Dateien oder Ordnern durch, indem er sie im Unterordner "Sicherung" mit Zeitstempeln versieht und nur die letzten 10 Versionen behält.

setlocal
goto mainprogramm

:hilfe
echo +----------------------------------------------------------------------------
echo +
echo + Gebrauch:
echo +
echo +  sicherung10 Datei1 OR Ordner [Datei2 OR Ordner2] [DateiN OR OrdnerN...]
echo + 
echo + Bemerkung:
echo + 1. Alle Dateien werden im dem Unterverzeichnis Sicherung unter den  
echo +    Namen JJJJ-MM-TT_HH-MM_Dateiname
echo +    angelegt.
echo + 2. Ist der Ordner Sicherung noch nicht vorhanden wird er Angelegt.
echo + 3. Es werden von der Datei die letzten 10 Versionen aufbewahrt 
echo + 4. Das loeschen der alten Sicherungen für Ordner ist derzeit deaktiviert
echo +    und wird nur als echo ausgegeben.
echo +   
echo + Tip:
echo + Kopiere dieses Programm ins "sendto" Verzeichnis, damit es mittels 
echo + rechter Maustaste aufrufbar ist.
echo + (Start-Ausführen und sendto eingeben oeffnet das passende Verzeichnis
echo + Unter Windows 10: 
echo + Start Ausfuehren (oder Windows R) und Eingabe: shell:sendto  
echo +----------------------------------------------------------------------------

goto :Ausgang

if x%1 EQU x goto :hilfe


:mainprogramm

FOR /F "tokens=1,2,3,4,5 delims=/. " %%a in ('date/T') do set CDATE=%%c%%d-%%b-%%a
FOR /F "tokens=1,2,3,4,5 delims=/: " %%a in ('time/T') do set CTIME=%%a-%%b

rem Ausgabe der zu kopierenden Dateien oder Ordner

echo S I C H E R U N G 1 0 . C M D

echo ------------------------------------

echo Sichere folgende Dateien oder Ordner

for %%i in ( %* ) do echo         %%~nxi

echo nach    Sicherung

echo ------------------------------------ 

pause


rem Sicherungsverzeichnis anlegen sofern noch nicht vorhanden

if exist "%~dp1Sicherung" goto :Sicherungvorhanden

mkdir "%~dp1Sicherung"

:Sicherungvorhanden 


rem In einer Schleife alle Dateien sichern

:AlleDateien

if x%1 EQU x goto :Ausgang
    
set DATEIPFAD=%~dp1

set DATEI=%~nx1

set BACKUPDATEI=%DATEIPFAD%Sicherung\%CDATE%_%CTIME%_%DATEI%

    
rem Nicht aus versehen das Sicherungsverzeichnis sichern

if x"%DATEI%" EQU x"Sicherung" GOTO :SHIFT_ENDE


rem Unterscheidung nach Ordner oder Datei (type Datei=ok(0), type Verzeichnis=Fehler(1))

type %1 2> NUL > NUL
    
    if  %errorlevel% EQU 1 Goto :KOPIE_ORDNER

      rem Sicherung einer Datei

      echo Sichere Datei : %DATEI%

      copy %1 "%BACKUPDATEI%" > NUL

      for /f %%i in ('dir /a /o-n /b "%DATEIPFAD%Sicherung\20??-??-??_??-??_%DATEI%" ^| more +10') do del /q "%DATEIPFAD%Sicherung\%%i"

GOTO :KOPIE_ENDE

:KOPIE_ORDNER

      rem Sicherung eines Verzeichnisses mit allen Unterverzeichnissen und Dateien

      echo sichere Ordner: %DATEI%

	  xcopy %1 "%BACKUPDATEI%"  /I/Q/E  > NUL   
	rem  I=Falls das Ziel nicht vorhanden ist und mehrere Dateien kopiert
	rem    werden, nimmt XCOPY an, dass das Ziel ein Verzeichnis ist
	rem  Q=Zeigt beim Kopieren keine Dateinamen an.
	rem  E=Kopiert alle Unterverzeichnisse (leer oder nicht leer).

	  echo xcopy %1 "%BACKUPDATEI%"
	  
	  
      for /f %%i in ('dir /a /o-n /b "%DATEIPFAD%Sicherung\20??-??-??_??-??_%DATEI%" ^| more +10') do echo rmdir /S /Q  "%DATEIPFAD%Sicherung\%%i"

:KOPIE_ENDE

:SHIFT_ENDE

shift

goto :AlleDateien

:Ausgang

echo Fertig!

pause

endlocal
