@echo off

:: At se muze pouzit !promenna!
setlocal enabledelayedexpansion

:: Vytvorit slozku C:\SCRIPTS\%USERNAME% jen pokud neexistuje
set slozka=C:\SCRIPTS\%USERNAME%
if not exist %slozka% (
  echo Vytvareni slozky: %slozka%
  mkdir %slozka%
)

:: Nastavit read write execute vsem uzivatelum, neukazuj vystup prikazu
icacls %slozka% /grant Everyone:(RX,W) > nul

:: Probehl prikaz spravne?
if errorlevel 1 (
    echo Nastala chyba v nastavovani prav ve slozce: %slozka%
) else (
    echo Nastavovani prav slozky problehlo uspesne: %slozka%
)

:: argument /s v prikazu dir to udela rekurzivne

:: Vypsat souboru stromovou strukturu adresářů na disku C
:: /A vypise v ASCII
echo Generovani stromove struktury...
tree C:\ /A > %slozka%\tree.txt


echo Generovani stuktury (jen normalni soubory a slozky)...
echo Normalni slozky a soubory: > %slozka%\hidden.txt
:: pomoci for projdeme kazdy bezny soubor a slozku v adresari 
:: cestu toho souboru dame do prikazu attrib, ktery napise atributy a cestu k souboru
for /f "delims=" %%a in ('dir /b C:\Windows') do (
    attrib "C:\Windows\%%a" >> %slozka%\hidden.txt
)

:: /ah-d : napis jenom hidden soubory, nikoliv slozky
:: /ah : napis hidden soubory a slozky
echo Generovani stuktury (skryte soubory a slozky)...
echo. >> %slozka%\hidden.txt
echo. Skryte soubory: >> %slozka%\hidden.txt
for /f "delims=" %%a in ('dir /b /ah C:\Windows') do (
    attrib "C:\Windows\%%a" >> %slozka%\hidden.txt
)

:: atribute link
:: /al : show links
echo Generovani stuktury (symlinks, hardlinks)...
echo. >> %slozka%\hidden.txt
echo Hardlinky and Softlinky: >> %slozka%\hidden.txt
for /f "delims=" %%a in ('dir /b /al C:\Windows 2^>nul') do (
    attrib "C:\Windows\%%a" >> %slozka%\hidden.txt
)
:: vypsani hardlinku
:: projdi vsechny soubory ve Windows adresari, pomoci fsutil prikazu zjisti, jestli je to hardlink
for %%f in (C:\Windows\*) do (
    set count=0
    for /f %%l in ('fsutil hardlink list "%%f" ^| find /c /v ""') do set count=%%l
    if !count! gtr 1 (
        attrib "%%f" >> %slozka%\hidden.txt
    )
)
