remove-printer -Name "Kyocera Printer"




# Define the name of the printer driver you are looking for
$driverName = "Kyocera TASKalfa 5003i KX"

# Get the list of installed printer drivers
$drivers = Get-PrinterDriver

# Check if the specific driver exists
if ($drivers | Where-Object { $_.Name -like "$driverName" }) {
    Write-Output "Driver exists, so remove it"
    remove-printerdriver -Name "$driverName"
} 


# Define the name of the printer driver you are looking for
$printerPortName = "IP_192.168.10.35"

# Get the list of installed printer drivers
$printerPort = Get-PrinterPort


# Check if the specific driver exists
if ($printerPort | Where-Object { $_.Name -like "$printerPortName" }) {
    Write-Output "Port exists, so remove it"
    remove-printerport -name "$printerPortName"
} 



# Define the published name of the driver you are looking for
$driverPublishedName = "oem258.inf"

# Get the list of all installed drivers
$driverStore = pnputil /enum-drivers

# Check if the specific driver is in the list
if ($driverStore -match "$driverPublishedName") {
    Write-Output "Driver exists, so remove it"
    pnputil /delete-driver  "$driverPublishedName" /uninstall
}
