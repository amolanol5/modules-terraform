resource "aws_eip" "eip_natgateway" {
  count = var.enable_nat_gateway ? 1 : 0  
  vpc      = true

     tags = {
     Name = "IP_NAT_GW_${local.vpc_namespace}"
   }
}

resource "aws_nat_gateway" "ng_main" {
 count = var.enable_nat_gateway ? 1 : 0  
   allocation_id = aws_eip.eip_natgateway[count.index].id
   subnet_id     = aws_subnet.public_subnet_1.id
   tags = {
     Name = "NAT_GW_${local.vpc_namespace}"
   }
   # To ensure proper ordering, it is recommended to add an explicit dependency
   # on the Internet Gateway for the VPC.
   depends_on = [aws_internet_gateway.gw]
 }