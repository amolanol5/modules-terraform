

# resource "aws_nat_gateway" "example" {
#   allocation_id = aws_eip.example.id
#   subnet_id     = aws_subnet.example.id

#   tags = {
#     Name = "gw NAT"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.example]
# }