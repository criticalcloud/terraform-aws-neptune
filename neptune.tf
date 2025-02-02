// cria o cluster neptune
resource "aws_neptune_cluster" "neptune_cluster" {
  cluster_identifier                   = var.cluster_name
  engine                               = "neptune"
  engine_version                       = var.neptune_version
  backup_retention_period              = var.backup_retention_period
  preferred_backup_window              = "03:00-06:00"
  skip_final_snapshot                  = true
  deletion_protection                  = true
  iam_database_authentication_enabled  = false
  apply_immediately                    = true
  copy_tags_to_snapshot                = true
  storage_encrypted                    = true
  neptune_subnet_group_name            = aws_neptune_subnet_group.neptune_sg.name
  neptune_cluster_parameter_group_name = aws_neptune_cluster_parameter_group.cluster_pg.name
  vpc_security_group_ids               = [aws_security_group.sg.id]
  tags                                 = var.tags
}

// cria os nodes do cluster
resource "aws_neptune_cluster_instance" "neptune_instance" {
  count                        = var.number_of_instances
  cluster_identifier           = aws_neptune_cluster.neptune_cluster.id
  engine                       = "neptune"
  instance_class               = var.instance_type
  apply_immediately            = true
  neptune_subnet_group_name    = aws_neptune_subnet_group.neptune_sg.name
  neptune_parameter_group_name = aws_neptune_parameter_group.node_pg.name
  tags                         = var.tags
}

// cria o endpoint de acesso
//resource "aws_neptune_cluster_endpoint" "neptune_endpoint" {
//  cluster_identifier          = aws_neptune_cluster.neptune_cluster.cluster_identifier
//  cluster_endpoint_identifier = var.cluster_name
//  endpoint_type               = "ANY"
//}

// cria o parameter group do cluster
resource "aws_neptune_cluster_parameter_group" "cluster_pg" {
  family      = var.neptune_family
  name        = "cluster-pg-${var.cluster_name}"
  description = "Neptune cluster parameter group"
}

// cria o parameter group do node
resource "aws_neptune_parameter_group" "node_pg" {
  family = var.neptune_family
  name   = "node-pg-${var.cluster_name}"
}

// cria a subnet group para o cluster/nodes
resource "aws_neptune_subnet_group" "neptune_sg" {
  name       = "sg-${var.cluster_name}"
  subnet_ids = data.aws_subnets.subnets.ids

  tags = var.tags
}
