$NetworkInterfaceName = "MyNIC"
$ResourceGroupName = "MyResourceGroup"
$Location = "East US"
$VirtualNetworkName = "MyVirtualNetwork"
$SubnetName = "MySubnet"

$VirtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName 

$Subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $SubnetName

$NetworkInterface = New-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -Subnet $Subnet

$NetworkInterface.Name +"is Created"