$env:PATH += ";C:\Windows\System32"
$driverPath = ".\KX_Universal_Printer_Driver\Kx84_UPD_8.4.1716_en_RC5_WHQL\64bit\OEMSETUP.INF"
$driverPublishedName = "oem258.inf"




function addDriverInStore {
    param (
        [string]$DriverPublishedName,
        [string]$driverPath
    )

    # Get the list of all installed drivers
    $drivers = pnputil /enum-drivers

    # Check if the specific driver is in the list
    if ($drivers -match "$DriverPublishedName") {
        Write-Output "Driver exists"
    } else {
        Write-Output "Driver does not exist, so add new one to driver store"
        pnputil /add-driver "$driverPath" /install
    }
}


function addPrinterPort {
    param (
        [string]$PrinterPortName
    )

    # Get the list of installed printer drivers
    $drivers = Get-PrinterPort

    # Secure queue name
    $printerQueue = "Secure_Printer"

    # Check if the specific driver exists
    if ($drivers | Where-Object { $_.Name -like "$PrinterPortName" }) {
        Write-Output "Port exists"
    } else {
        Write-Output "Port does not exist, so add new one"
        Add-PrinterPort -Name "$PrinterPortName" -LprHostAddress  "192.168.10.35" -LprByteCounting -LprQueueName $printerQueue

    }
}

function addPrinterDriverExists {
    param (
        [string]$DriverName
    )

    # Get the list of installed printer drivers
    $drivers = Get-PrinterDriver

    # Check if the specific driver exists
    if ($drivers | Where-Object { $_.Name -like "$DriverName" }) {
        Write-Output "Driver exists"
    } else {
        Write-Output "Driver does not exist, so install new one"
        add-printerdriver -name "$DriverName"

    }

}


addDriverInStore -DriverPublishedName "oem258.inf" -driverPath "$driverPath"
addPrinterPort -PrinterPortName "IP_192.168.10.35"
addPrinterDriverExists -DriverName "Kyocera TASKalfa 5003i KX"

Add-Printer -Name "Kyocera Printer" -DriverName "Kyocera TASKalfa 5003i KX" -portname "IP_192.168.10.35"



