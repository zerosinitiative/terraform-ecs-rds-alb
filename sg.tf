resource "aws_security_group" "cluster" {
  name        = "${var.deployment_identifier}-${var.cluster_name}"
  description = "deployment: ${var.deployment_identifier}, cluster: ${var.cluster_name}"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name        = "${var.deployment_identifier}-${var.cluster_name}"
    ClusterName = var.cluster_name
  })
}

resource "aws_security_group_rule" "cluster_default_ingress" {
  count = var.include_default_ingress_rule == "yes" ? 1 : 0

  type = "ingress"

  security_group_id = aws_security_group.cluster.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0

  cidr_blocks = var.allowed_cidrs
}

resource "aws_security_group_rule" "cluster_default_ingress_app" {
  count = var.include_default_ingress_rule == "yes" ? 1 : 0

  type = "ingress"

  security_group_id = aws_security_group.cluster.id

  protocol  = "-1"
  from_port = 30000
  to_port   = 34000

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "cluster_default_egress" {
  count = var.include_default_egress_rule == "yes" ? 1 : 0

  type = "egress"

  security_group_id = aws_security_group.cluster.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0

  cidr_blocks = var.egress_cidrs
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description = "LB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LB security group"
  }
}

resource "aws_security_group" "allow_db" {
  name        = "allow_db"
  description = "Allow inbound traffic to db"
  vpc_id      = var.vpc_id

  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LB security group"
  }
}