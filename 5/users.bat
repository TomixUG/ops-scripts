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
echo ===== Skupiny: =====  >> logs.txt
set list=T1A T2A T3A T4A E1A E2A E3A E4A E1B E2B E3B E4B ICT ELEKTRO MUZI ZENY STUDENTI
(for %%a in (%list%) do ( 
  net localgroup %%a /add > nul 2>&1
  if errorlevel 2 (
      echo Skupina %%a jiz existuje
      echo  Skupina %%a jiz existuje >> logs.txt
  ) else (
      echo Skupina %%a byla vytvorena
      echo Skupina %%a byla vytvorena >> logs.txt
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

    :: hloupym zpusobem odstran diakritiku a dej mala pismena
    set "jmeno=!jmeno:á=a!"
    set "jmeno=!jmeno:č=c!"
    set "jmeno=!jmeno:é=e!"
    set "jmeno=!jmeno:ě=e!"
    set "jmeno=!jmeno:í=i!"
    set "jmeno=!jmeno:ň=n!"
    set "jmeno=!jmeno:ó=o!"
    set "jmeno=!jmeno:ř=r!"
    set "jmeno=!jmeno:š=s!"
    set "jmeno=!jmeno:Š=s!"
    set "jmeno=!jmeno:ť=t!"
    set "jmeno=!jmeno:ú=u!"
    set "jmeno=!jmeno:ů=u!"
    set "jmeno=!jmeno:ý=y!"
    set "jmeno=!jmeno:ž=z!"

    set "jmeno=!jmeno:A=a!"
    set "jmeno=!jmeno:B=b!"
    set "jmeno=!jmeno:C=c!"
    set "jmeno=!jmeno:D=d!"
    set "jmeno=!jmeno:E=e!"
    set "jmeno=!jmeno:F=f!"
    set "jmeno=!jmeno:G=g!"
    set "jmeno=!jmeno:H=h!"
    set "jmeno=!jmeno:I=i!"
    set "jmeno=!jmeno:J=j!"
    set "jmeno=!jmeno:K=k!"
    set "jmeno=!jmeno:L=l!"
    set "jmeno=!jmeno:M=m!"
    set "jmeno=!jmeno:N=n!"
    set "jmeno=!jmeno:O=o!"
    set "jmeno=!jmeno:P=p!"
    set "jmeno=!jmeno:Q=q!"
    set "jmeno=!jmeno:R=r!"
    set "jmeno=!jmeno:S=s!"
    set "jmeno=!jmeno:T=t!"
    set "jmeno=!jmeno:U=u!"
    set "jmeno=!jmeno:V=v!"
    set "jmeno=!jmeno:W=w!"
    set "jmeno=!jmeno:X=x!"
    set "jmeno=!jmeno:Y=y!"
    set "jmeno=!jmeno:Z=z!"

    set "prijmeni=!prijmeni:á=a!"
    set "prijmeni=!prijmeni:č=c!"
    set "prijmeni=!prijmeni:é=e!"
    set "prijmeni=!prijmeni:ě=e!"
    set "prijmeni=!prijmeni:í=i!"
    set "prijmeni=!prijmeni:ň=n!"
    set "prijmeni=!prijmeni:ó=o!"
    set "prijmeni=!prijmeni:ř=r!"
    set "prijmeni=!prijmeni:š=s!"
    set "prijmeni=!prijmeni:Š=s!"
    set "prijmeni=!prijmeni:ť=t!"
    set "prijmeni=!prijmeni:ú=u!"
    set "prijmeni=!prijmeni:ů=u!"
    set "prijmeni=!prijmeni:ý=y!"
    set "prijmeni=!prijmeni:ž=z!"
    set "prijmeni=!prijmeni:ť=t!"

    set "prijmeni=!prijmeni:A=a!"
    set "prijmeni=!prijmeni:B=b!"
    set "prijmeni=!prijmeni:C=c!"
    set "prijmeni=!prijmeni:D=d!"
    set "prijmeni=!prijmeni:E=e!"
    set "prijmeni=!prijmeni:F=f!"
    set "prijmeni=!prijmeni:G=g!"
    set "prijmeni=!prijmeni:H=h!"
    set "prijmeni=!prijmeni:I=i!"
    set "prijmeni=!prijmeni:J=j!"
    set "prijmeni=!prijmeni:K=k!"
    set "prijmeni=!prijmeni:L=l!"
    set "prijmeni=!prijmeni:M=m!"
    set "prijmeni=!prijmeni:N=n!"
    set "prijmeni=!prijmeni:O=o!"
    set "prijmeni=!prijmeni:P=p!"
    set "prijmeni=!prijmeni:Q=q!"
    set "prijmeni=!prijmeni:R=r!"
    set "prijmeni=!prijmeni:S=s!"
    set "prijmeni=!prijmeni:T=t!"
    set "prijmeni=!prijmeni:U=u!"
    set "prijmeni=!prijmeni:V=v!"
    set "prijmeni=!prijmeni:W=w!"
    set "prijmeni=!prijmeni:X=x!"
    set "prijmeni=!prijmeni:Y=y!"
    set "prijmeni=!prijmeni:Z=z!"

    REM echo !prijmeni!   !jmeno!   !trida!   !rocnik!  !pohlavi!

    echo. >> logs.txt 
    echo Vytvareni uctu uzivateli: !jmeno! !prijmeni! ...:
    echo. >> logs.txt 
    echo ===== Vytvareni uctu uzivateli: !jmeno! !prijmeni!: ===== >> logs.txt

    :: vytvorime uzivatele pomoci jeho jmena a prijmeni
    :: /Y automaticky potvrdi kdyz se program zepta, jestli chceme vytvorit heslo delsi nez 14 znaku
    net user !jmeno!.!prijmeni! !prijmeni!Q12020 /add /logonpasswordchg:yes /Y >nul 2>&1

    :: nastavime datum expirace
    echo nastavovani data expirace uctu >> logs.txt
    if "!rocnik!"=="První ročník" (
      net user !jmeno!.!prijmeni! /expires:08/31/2026 >nul 2>&1
    ) else if "!rocnik!"=="Druhý ročník" (
      net user !jmeno!.!prijmeni! /expires:08/31/2025 >nul 2>&1
    ) else if "!rocnik!"=="Třetí ročník" (
      net user !jmeno!.!prijmeni! /expires:08/31/2024 >nul 2>&1
    ) else if "!rocnik!"=="Čtvrtý ročník" (
      net user !jmeno!.!prijmeni! /expires:08/21/2023 >nul 2>&1
    )

    :: priradime skupinu STUDENTI
    echo prirazovani skupiny STUDENTI >> logs.txt
    net localgroup STUDENTI !jmeno!.!prijmeni! /add >nul 2>&1

    :: zjistime do jako chodi tridy, podle toho pridadime skupinu
    :: pouzivam if, aby bylo mozne pridat pouze jednu z povolenych trid, kdybych tam dal rovnou tu promennou mohli by nastat errory
    echo prirazovani skupiny podle tridy >> logs.txt
    if "!trida!"=="T1A" (
      net localgroup T1A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="T2A" (
      net localgroup T2A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="T3A" (
      net localgroup T3A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="T4A" (
      net localgroup T4A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E1A" (
      net localgroup E1A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E2A" (
      net localgroup E2A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E3A" (
      net localgroup E3A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E4A" (
      net localgroup E4A !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E1B" (
      net localgroup E1B !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E2B" (
      net localgroup E2B !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E3B" (
      net localgroup E3B !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida!"=="E4B" (
      net localgroup E4B !jmeno!.!prijmeni! /add >nul 2>&1
    ) 

    :: podle prvniho pismena ze tridy pridarime bud ICT nebo ELEKTRO
    echo prirazovani skupiny podle druhu oboru >> logs.txt
    if "!trida:~0,1!"=="T" (
      net localgroup ICT !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!trida:~0,1!"=="E" (
      net localgroup ELEKTRO !jmeno!.!prijmeni! /add >nul 2>&1
    )

    :: priradime skpinu podle pohlavi
    echo prirazovani skupiny podle pohlavi >> logs.txt
    if "!pohlavi!"=="Muž" (
      net localgroup MUZI !jmeno!.!prijmeni! /add >nul 2>&1
    ) else if "!pohlavi!"=="Žena" (
      net localgroup ZENY !jmeno!.!prijmeni! /add >nul 2>&1
    ) 

    echo. >> logs.txt
    echo Informace o vytvorenem uctu: >> logs.txt
    net user !jmeno!.!prijmeni! >> logs.txt

    echo. >> logs.txt
    echo. >> logs.txt
    echo. >> logs.txt
    echo. >> logs.txt
)
