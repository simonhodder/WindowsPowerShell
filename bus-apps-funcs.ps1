
function Get-PayaraDir {
    param(
        [string]$PayaraVersion="4"
    )

    if ($PayaraVersion -eq "4") {
        return $PAYARA_BIN_DIR="$($env:PAYARA_HOME)\payara41\bin"
    } else {
        return $PAYARA_BIN_DIR="$($env:PAYARA_HOME)\payara-5.183\payara5\bin"
    }
}

function Start-Domain {
    param(
        [String]$DomainNumber="1",
        [String]$Debug=$false,
        [String]$LaunchAdminWindow=$true,
        [string]$PayaraVersion="4"
    )
    Push-Location (Get-PayaraDir $PayaraVersion)

    $debugSwitch = ""
    if ($debug) {
        $debugSwitch = "--debug"
    }

    .\asadmin.bat start-domain $debugSwitch --domaindir C:\payara\domains "domain$DomainNumber"
    if ($LaunchAdminWindow) {
        Open-PayaraAdmin -DomainNumber $DomainNumber
    }

    Pop-Location
}

function Stop-Domain {
    param(
        [String]$DomainNumber="1",
        [string]$PayaraVersion="4"
    )

    Push-Location (Get-PayaraDir $PayaraVersion)
    .\asadmin.bat stop-domain --domaindir C:\payara\domains "domain$DomainNumber"
    Pop-Location
}

function Restart-Domain {
    param(
        [String]$DomainNumber="1",
        [String]$Debug=$false,
        [String]$LaunchAdminWindow=$true
    )
    Stop-Domain -DomainNumber $DomainNumber
    Start-Domain -DomainNumber $DomainNumber -Debug $Debug -LaunchAdminWindow $LaunchAdminWindow
}

function Open-PayaraAdmin {
    param(
        [String]$Url="http://localhost",
        [String]$DomainNumber="1"
    )
    if ($DomainNumber -eq "1") {
        $urlWithPort = $Url + ":4848"
    } else {
        $urlWithPort = $Url + ":15562"
    }

    & "C:\Program Files\Google\Chrome\Application\chrome.exe" $urlWithPort
}

New-Alias -Name github -Value Open-Repo -Force -Option AllScope

function Start-VisualStudioAsAdmin {
    param(
        [String]$Credential='clrc\mhr3934903',
        [String]$Version='2019'
    )

    $vsPath =  "C:\Program Files (x86)\Microsoft Visual Studio\$Version\Enterprise\Common7\IDE\devenv.exe"
    $cmd = "-noprofile -command &{Start-Process '$vsPath' -verb runas}"
    Start-Process PowerShell -Credential $Credential -ArgumentList $cmd
}

New-Alias -Name vsadmin -Value Start-VisualStudioAsAdmin -Force -Option AllScope

function Start-VisualStudioAsAdmin2017 {
    Start-VisualStudioAsAdmin -Version "2017"
}

New-Alias -Name vsadmin17 -Value Start-VisualStudioAsAdmin2017 -Force -Option AllScope


###########################
# Shortcuts
###########################
$workspace = Join-Path -Path $HOME -ChildPath 'workspace'
$scratch = Join-Path -Path $workspace -ChildPath 'scratch'
$busapps = 'C:\Programming'
$si = Join-Path -Path $busapps -ChildPath 'sisites'
$users = Join-Path -Path $busapps -ChildPath 'Users'
$userofficetools = Join-Path -Path $busapps -ChildPath 'UserOfficeTools'
$messages = Join-Path -Path $busapps -ChildPath 'Messages'
$facilitiesSharePoint = Join-Path -Path $busapps -ChildPath 'facilities-sharepoint'

$ps = Join-Path -Path $HOME -ChildPath 'Documents/WindowsPowerShell'
$dots = Join-Path -Path $HOME -ChildPath 'dotfiles'

$gopath = $env:GOPATH
$releasenotes = Join-Path -Path $env:GOPATH -ChildPath 'src\github.com\isisbusapps\releasenotesgenerator'

$fbs = 'C:\fbs\apps'
$bissettings = $fbs

# Shortcut functions
function ws { Set-Location $workspace }
function scratch { Set-Location $scratch }
function busapps { Set-Location $busapps }
function ba { Set-Location $busapps }
function sites { Set-Location $si }
function users { Set-Location $users }
function userofficetools { Set-Location $userofficetools }
function messages { Set-Location $messages }
function dots { Set-Location $dots }
function profile { Set-Location $ps }
function gogo { Set-Location $env:GOPATH }
function releasenotes { Set-Location $releasenotes }
function fbs { Set-Location $fbs }
function bissettings { Set-Location $bissettings }
function releasenotes { Set-Location $releasenotes }
function facsp { Set-Location $facilitiesSharePoint }

function onedrive {
    cd 'C:\Users\mhr39349\OneDrive - Science and Technology Facilities Council'
    explorer .
}

function Run-OracleDev {
    & 'C:\oracle-sql-developer\sqldeveloper.exe'
}

New-Alias -Name oracledev -Value Run-OracleDev -Force -Option AllScope
