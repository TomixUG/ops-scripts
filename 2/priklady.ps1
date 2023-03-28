# musime pridat relativni a absolutni path
$source_file = Join-Path -Path $PSScriptRoot -ChildPath "priklady.txt"

$i = 0 # pocitani pocet iteraci

"" | Out-File -FilePath priklady.txt -Append # novy radek

# iterujeme kazdy radek v souboru
foreach ($line in Get-Content $source_file) {
    $i = $i + 1
    $err = $false

    $problem = $line.Split(" ")

    # pokud je radek prazdny ignoruj
    if($line -eq ""){
        continue
    }

    # FIXME: zero fails this check
    if(!($problem[0] -as [decimal])){
         "ERROR radek $($i): invalidni prvni cislo" | Out-File -FilePath priklady.txt -Append
        continue
    }
    if(!($problem[2] -as [decimal])){
        "ERROR radek $($i): invalidni druhe cislo" | Out-File -FilePath priklady.txt -Append
        continue
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
            "ERROR radek $($i): bylo nalezeno invalidni znamenko" | Out-File -FilePath priklady.txt -Append
            $err = $true
        }
    }

    # napsat zadani a vysledek pokud se nestal error
    if (-not $err){
        "$line = $answer" | Out-File -FilePath priklady.txt -Append
    }
}
