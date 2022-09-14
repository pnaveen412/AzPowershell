#Creating a Resource Group
$ResourceGroupName = "ResourceGroup"
$Location = "North Europe"

$Resourcegroup=New-AzResourceGroup -Name $ResourceGroupName -Location $Location 

$Resourcegroup.ResourceGroupName

#Creating a NSG 
$NSGName = "MyNSG"

$SecurityRule1 = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" -Direction Inbound -Protocol Tcp -Access Allow -SourcePortRange * -SourceAddressPrefix * -DestinationAddressPrefix * -DestinationPortRange 3389 -Priority 101

$NSG = New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $ResourceGroupName -Location $Location -SecurityRules $SecurityRule1 

#Creating a Virtual Network 
$VirtualNetworkName = "MyVirtualNetwork"
$VirtualNetworkAddressSpace = "10.0.0.0/16"
$SubnetName = "MySubnet"
$SubnetAddressSpace = "10.0.0.0/24"

$Subnet = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace -NetworkSecurityGroup $NSG

$Subnet.Name

$VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -AddressPrefix $VirtualNetworkAddressSpace -ResourceGroupName $ResourceGroupName -Location $Location -Subnet $Subnet

$VirtualNetwork.Name 

#Creating a Network Interface
$NetworkInterfaceName = "MyNIC"
$VirtualNetwork = Get-AzVirtualnetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

$NetworkInterface = New-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name $NetworkInterfaceName -Location $Location -Subnet $Subnet

$NetworkInterface.Name

#Creating a Public IP Address 

$PublicIPName = "MyPublicIp"

$PublicIP = New-AzPublicIpAddress -Name $PublicIPName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Static -Sku Standard

$PublicIP.Name

#Attaching the Public IP Address to Network Interface 

$IPConfig = Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface

Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIP -Name $IPConfig.Name  -NetworkInterface $NetworkInterface

$NetworkInterface | Set-AzNetworkInterface

#Creating a Virtual Machine 

$VMName = "MyVM"
$VMSize = "Standard_DS2_v2"
$Credential = Get-Credential

$VMConfig = New-AzVMConfig -Name $VMName -VMSize $VMSize

Set-AzVMOperatingSystem -VM $VMConfig -ComputerName $VMName -Credential $Credential -Windows

Set-AzVMSourceImage -VM $VMConfig -PublisherName "MicrosoftWindowsServer" -Skus "2019-DataCenter" -Offer "WindowsServer" -Version "latest"

Add-AzVMNetworkInterface -VM $VMConfig -Id $NetworkInterface.Id

Set-AzVMBootDiagnostic -Disable -VM $VMConfig

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VMConfig
