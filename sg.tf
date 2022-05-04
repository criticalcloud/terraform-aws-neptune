resource "aws_security_group" "sg" {
  name        = "neptune-${var.cluster_name}"
  description = "SG Neptune Cluster"

  vpc_id = data.aws_vpc.vpc.id

  ingress {
    description = ""
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.subnet_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}