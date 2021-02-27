############################################################
##
## Function: NTNX-Connect-NTNX
## Author: Steven Poitras
## Description: Connect to NTNX function
## Language: PowerShell
##
############################################################
function NTNX-Connect-NTNX {
<#
.NAME
	NTNX-Connect-NTNX
.SYNOPSIS
	Connect to NTNX function
.DESCRIPTION
	Connect to NTNX function
.NOTES
	Authors:  thedude@nutanix.com
	
	Logs: C:\Users\<USERNAME>\AppData\Local\Temp\NutanixCmdlets\logs
.LINK
	www.nutanix.com
.EXAMPLE
    NTNX-Connect-NTNX -IP "99.99.99.99.99" -User "BlahUser"
#> 
	Param(
	    [parameter(mandatory=$true)][AllowNull()]$ip,
		
		[parameter(mandatory=$false)][AllowNull()]$credential
	)

	begin{
		# Make sure requried snappins are installed / loaded
		$loadedSnappins = Get-PSSnapin
		
		if ($loadedSnappins.name -notcontains "NutanixCmdletsPSSnapin") {
			Write-Host "Nutanix snappin not installed or loaded, trying to load..."
			
			# Try to load snappin
			Add-PSSnapin NutanixCmdletsPSSnapin
			
			# Refresh list of loaded snappins
			$loadedSnappins = Get-PSSnapin
			
			if ($loadedSnappins.name -notcontains "NutanixCmdletsPSSnapin") {
				Write-Host "Nutanix snappin not installed or loaded, exiting..."
				break
			}
		}
		
		# If values not set use defaults
		if ([string]::IsNullOrEmpty($credential.UserName)) {
			Write-Host "No Nutanix user passed, using default..."
			$credential = (Get-Credential -Message "Please enter the Nutanix Prism credentials <admin/*******>")
		}

	}
	process {
		# Check for connection and if not connected try to connect to Nutanix Cluster
		if ([string]::IsNullOrEmpty($IP)) { # Nutanix IP not passed, gather interactively
			$IP = Read-Host "Please enter a IP or hostname for the Nutanix cluter"
		}
		
		# If not connected, try connecting
		if ($(Get-NutanixCluster -Servers $IP -ErrorAction SilentlyContinue).IsConnected -ne "True") {  # Not connected
			Write-Host "Connecting to Nutanix cluster ${IP} as $($credential.UserName.Trim("\")) ..."
			$connObj = Connect-NutanixCluster -Server $IP -UserName $($credential.UserName.Trim("\")) `
				-Password $credential.Password -AcceptInvalidSSLCerts -F
		} else {  # Already connected to server
			Write-Host "Already connected to server ${IP}, continuing..."
		}
	}
	end {
		$nxServerObj = New-Object PSCustomObject -Property @{
			IP = $IP
			Credential = $credential
			connObj = $connObj
		}
		
		return $nxServerObj
	}
}
############################################################
##
## Function: NTNX-ProtectAll-VM
## Author: Steven Poitras
## Description: Protect unprotected VM
## Language: PowerShell
##
############################################################
Disconnect-NutanixCluster -NutanixClusters $(Get-NutanixCluster) -ErrorAction SilentlyContinue | Out-Null

############################################################
## Inputs and defaults
############################################################

$pdPrefix = "BarPD" #<-- INPUT
$nxIPs = $null #<-- INPUT
$vmPerPD = 50
		
if (!$nxIPs) {
	# Gather Nutanix addresses
	$nxIPs = ((Read-Host "Please enter the target Nutanix server addresses seperated by commas (if multiple)") -split ",").Trim(" ")
}
		
# For each Nutanix cluster try to connect
$nxIPs | %{
	# Connect to Nutanix servers
	$l_ntnxConn = NTNX-Connect-NTNX -ip $_ -credential `
		$(Get-Credential -Message "Please enter the Nutanix Prism credentials for $($_) <admin/*******>")
	
	# Add connection to connection array
	$ntnxConn += $l_ntnxConn
}

clear

# Get existing PDs matching prefix
$pds = Get-NTNXProtectionDomain | where {$_.name -match $pdPrefix}

# Get VMs
$vms = Get-NTNXVM

# Get Un-protected VMs
[System.Collections.ArrayList]$unProtectedVM = Get-NTNXUnprotectedVM

if ($unProtectedVM.count -gt 0) {
	Write-Host "Found $($unProtectedVM.count) unprotected vms..."
} else {
	Write-Host "No unprotected VMs found, exiting..."
	break
}

if ($pds.Count -gt 0) {
	# Matching PDs exist
	Write-Host "Found $($pds.Count) matching existing PDs with space..."
	
	[int]$existingPDSpace = 0
	
	# Find available space in existing PDs
	[System.Collections.ArrayList]$pdsWithSpace = $pds | where {($_.vms).count -lt $vmPerPD}
	
	$pdsWithSpace | %{
		# Find available space
		$l_pdSpace = $vmPerPD - ($_.vms).count
		
		# Add available space to counter
		$existingPDSpace += $l_pdSpace
	}
	
	# Find starting increment from existing
	$startingInt = (($pds.name).split("-") -match "^[0-9]+$" | measure -Maximum).maximum + 1
} else {
	$startingInt = 0
}

# Find needed space
$newPDSpace = if ($existingPDSpace -lt $unProtectedVM.Count) {$unProtectedVM.Count - $existingPDSpace}

# Find number of new PD required
$numNewPD = [Math]::Round($newPDSpace/$vmPerPD)

# Create $numNewPD Protection Domains
Write-Host "Creating $numNewPD new PDs..."
if ($numNewPD -gt 0) {
	1..$numNewPD | %{
		$l_int = $startingInt + $_

		$l_pdName = "$pdPrefix-$l_int"

		# Create PD
		Write-Host "Creating PD: $l_pdName"
		$l_PD = Add-NTNXProtectionDomain -pdName $l_pdName
		
		# Add cron schedule to PD
		
		$pdsWithSpace += $l_PD
	}
}

$pdsWithSpace | %{
	# Get avail space
	$l_availSpace = $vmPerPD - ($_.vms).count
	
	# Get list of VM UUIDs
	$l_vmObj = $unProtectedVM | Select-Object -First $l_availSpace
	if ($l_vmObj) {
		$l_vmUUIDs = $l_vmObj.uuid	
		
		# Add VMs to PD
		Write-Host "Adding $($l_vmObj.count) VMs to PD: $($_.name)"
		Add-NTNXProtectionDomainVM -Name $_.name -Uuids $l_vmUUIDs
		
		# Remove added VMs from array
		$unProtectedVM = $unProtectedVM | where {$l_vmObj -notcontains $_}
	} else {
		Write-Host "All vms added, exiting..."
		break
	}
}