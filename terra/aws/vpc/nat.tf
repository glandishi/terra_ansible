#Define External IP 
resource "aws_eip" "myeip" {
  vpc = true
}

resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.mysub_public1.id
  depends_on    = [aws_internet_gateway.my_gw]
}

resource "aws_route_table" "myroute-private" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mynatgw.id
  }

  tags = {
    Name = "myroute-private"
  }
}

# route associations private
resource "aws_route_table_association" "route-priv1-assoca" {
  subnet_id      = aws_subnet.mysub_priv1.id
  route_table_id = aws_route_table.myroute-private.id
}

resource "aws_route_table_association" "route-priv2-assocb" {
  subnet_id      = aws_subnet.mysub_priv2.id
  route_table_id = aws_route_table.myroute-private.id
}

resource "aws_route_table_association" "route-priv3-assocc" {
  subnet_id      = aws_subnet.mysub_priv3.id
  route_table_id = aws_route_table.myroute-private.id
}
