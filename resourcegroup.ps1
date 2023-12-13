#Creating a Resource Group 
$ResourceGroupName = "MyResourceGroup"
$Location = "East US"

Connect-AzAccount 
$ResourceGroup = New-AzResourceGroup -Name $ResourceGroupName -Location $Location

$ResourceGroup.ResourceGroupName + "is creared"

#This is updated
