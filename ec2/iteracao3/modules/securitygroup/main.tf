resource "aws_security_group" "security_group" {
  name = var.sg_name
  description = var.sg_description
  tags = {
    "Environment" = var.environment
  }
}

resource "aws_security_group_rule" "security_group_rule" {
  from_port         = var.from_port
  protocol          = var.protocol
  security_group_id = aws_security_group.security_group.id
  to_port           = var.to_port
  type              = var.type
  cidr_blocks       = var.cidr_blocks
}
