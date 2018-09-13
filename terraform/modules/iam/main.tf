#TODO: Add label

resource "aws_iam_role" "role" {
  count    = "${var.generate_iam_role == "true" ? 1 : 0}"
  name = "${var.name}"
  path = "/"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    }
  }]
}
EOF
}

resource "aws_iam_role_policy" "default_policy" {
  count    = "${var.generate_iam_role == "true" ? 1 : 0}"
  name  = "${var.name}-default"
  role  = "${aws_iam_role.role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "ec2:CreateTags",
      "s3:*",
      "ecr:getLogin",
      "ecr:getImage"
    ],
    "Resource": "*"
  }]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  count    = "${var.generate_iam_role == "true" ? 1 : 0}"
  name     = "${var.name}"
  role     = "${aws_iam_role.role.name}"

  lifecycle {
    create_before_destroy = true
  }
}
