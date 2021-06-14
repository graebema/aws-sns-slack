resource "aws_security_group" "allow-ping" {
  vpc_id      = module.vpc.vpc_id
  name        = "allow-icmp"
  description = "security group that allows icmp and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
