@echo off
:: at muzeme pouzivat !promenna!
:: ve for loopu je to potrebne, jinak se pouzije stav promenne pred for loopou"
setlocal enabledelayedexpansion

:: prvni zkontrolujeme jestli ma uzivatel administratorske prava, pokud ne ukoncime program
:: udelame to zavolanim prikazu, ke kteremu maji pristup pouze admins
net session >nul 2>&1
if errorlevel 1 (
    echo ERROR: Script musi byt spusten jako admin
    exit /b 1
) else (
    rmdir "C:\Windows\System32\Test" >nul 2>&1
)

:: vytvorime vsechny skupiny:
:: pokud je error 2 znamena to, ze skupina uz existuje
set list=T1A T2A T3A T4A E1A E2A E3A E4A E1B E2B E3B E4B ICT ELEKTRO MUZI ZENY
(for %%a in (%list%) do ( 
  net localgroup %%a /add > nul 2>&1
  if errorlevel 2 (
      echo Skupina %%a jiz existuje
  ) else (
      echo Skupina %%a byla vytvorena
  )
))

:: pomoci opensource programu gocsv prekonvertujeme xlsx na textovy csv format
gocsv xlsx --sheet 1 studenti.xlsx > studenti.csv 2>nul
if errorlevel 1 (
    echo ERROR: Soubor studenti.xlsx je invalidni
    exit /b 1
)

:: pomoci for projdeme csv soubor
for /f "tokens=1-5 delims=," %%a in (studenti.csv) do (
    set prijmeni=%%a
    set jmeno=%%b
    set trida=%%c
    set rocnik=%%d
    set pohlavi=%%e
    REM echo !prijmeni!   !jmeno!   !trida!   !rocnik!  !pohlavi!

    net user !jmeno!.!prijmeni! !prijmeni!Q12020! /add /logonpasswordchg:yes
)
