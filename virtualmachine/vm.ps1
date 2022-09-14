Connect-AzAccount 
$VMName = "MyFirstVM"
$Size = "Standard_DS2_v2"
$ResourceGroupName = "MyResourceGroup"
$Location = "East US"
$Credential = Get-Credential 
$NetworkInterfaceName = "MyNIC"

#Getting the Network Interface Details
$NetworkInterface = Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName

$VMConfig = New-AzVMConfig -Name $VMName -VMSize $Size

Set-AzVMOperatingSystem -VM $VMConfig -ComputerName $VMName -Credential $Credential -Windows

Set-AzVMSourceImage -VM $VMConfig -PublisherName "MicrosoftWindowsServer" -Skus "2019-DataCenter" -Offer "WindowsServer" -Version "latest"

Add-AzVMNetworkInterface -VM $VMConfig -Id $NetworkInterface.Id

Set-AzVMBootDiagnostic -Disable -VM $VMConfig

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VMConfig

