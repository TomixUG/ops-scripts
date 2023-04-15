# musime pridat relativni a absolutni path
$source_file = Join-Path -Path $PSScriptRoot -ChildPath "priklady.txt"

$buffer = "" # buffer vystupu

$i = 0 # pocitani pocet iteraci

# iterujeme pres kazdy radek v souboru
foreach ($line in Get-Content $source_file) {
    $i = $i + 1
    $problem = $line.Split(" ")

    # pokud je radek prazdny ignoruj
    if($line -eq ""){
        continue
    }

    # FIXME: zero fails this check
    if(!($problem[0] -as [decimal])){
        Write-Error "ERROR radek $($i): invalidni prvni cislo"
        exit
    }
    if(!($problem[2] -as [decimal])){
        Write-Error "ERROR radek $($i): invalidni druhe cislo" 
        exit
    }

    # zjistime jake je znemenko, podle toho bud pricteme, odecteme, nasobime, delime
    # vysledek zaokrouhlime na 2 des mista
    switch ($problem[1]) {
        "+" {
            $answer = [math]::Round([float]$problem[0] + [float]$problem[2], 2)
            break
        }
        "-" {
            $answer = [math]::Round([float]$problem[0] - [float]$problem[2], 2)
            break
        }
        "*" {
            $answer = [math]::Round([float]$problem[0] * [float]$problem[2], 2)
            break
        }
        "/" {
            $answer = [math]::Round([float]$problem[0] / [float]$problem[2], 2) 
            break
        }
        default {
           Write-Error "ERROR radek $($i): bylo nalezeno invalidni znamenko"
           exit
        }
    }

    # zapsat do bufferu
    $buffer += "$line = $answer`n"
}

# pokud kod dosel na toto misto, znamena to, ze vse probehlo bez erroru
# zapis tedy vystup do souboku

"" | Out-File -FilePath priklady.txt -Append # novy radek
$buffer | Out-File -FilePath priklady.txt -Append
