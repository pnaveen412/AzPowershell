$ResourceGroupName = "MyResourceGroup"
$Location = "East US"
$NetworkInterfaceName = "MyNIC"

$PublicIPAddressName = "MyPublicIP"

#Creating the Public IP Address

$PublicIP = New-AzPublicIpAddress -Name $PublicIPAddressName -ResourceGroupName $ResourceGroupName -Location $Location -Sku Standard -AllocationMethod Static

#Once the Public IP Address is created we need to attach the public Ip Address to our NIC 

$NetworkInterface = Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName

$IpConfig = Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface

Set-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface -PublicIpAddress $PublicIP -Name $IpConfig.Name

$NetworkInterface | Set-AzNetworkInterface

