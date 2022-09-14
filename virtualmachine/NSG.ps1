$NSGName = "MyNSG"
$ResourceGroupName = "MyResourceGroup"
$Location = "East US"
$SubnetName = "MySubnet"
$VirtualNetworkName = "MyVirtualNetwork"

#Before Creating the NSG we need to create a security Rule to attach it to NSG
#Creating a Security Rule 
$SecurityRule1 = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Direction Inbound -Access Allow -Protocol Tcp -Priority 101

#Creating NSG 
$NSG = New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $ResourceGroupName -Location $Location -SecurityRules $SecurityRule1

$NSG.Name

#Once we create a NSG, we need to attach it to a Subnet or NIC, we are attaching it to the Subnet here

$VirtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName 

$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork 

Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork -NetworkSecurityGroup $NSG -AddressPrefix $SubnetAddressSpace

$VirtualNetwork | Set-AzVirtualNetwork
