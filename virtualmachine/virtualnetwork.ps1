#Creating a Virtual Network
$ResourceGroupName = "MyResourceGroup"
$Location = "East US"
$SubnetName = "MySubnet"
$SubnetAddressSpace = "10.0.0.0/24"
$VirtualNetworkName = "MyVirtualNetwork"
$VirtualNetworkAddressSpace = "10.0.0.0/16"

#In order to create a Virtual Network we need to create Subnet
#Creating Subnet

$Subnet = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

#Creating a Virtual Network

$VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $Subnet

$VirtualNetwork.Name 