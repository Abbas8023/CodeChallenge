resource "aws_security_group" "web-server" {
  name        = "web-server"
  description = "allow ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
        Name = "webserver"
      }
}

resource "aws_instance" "terraform" {
ami = "ami-0f7919c33c90f5b58"
instance_type = "t2.micro"
user_data = <<-EOF
            #! /bin/bash
            sudo yum install httpd -y
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "<h1>Hello from AAA.BBB.CCC.DDD </h1>" | sudo tee  /var/www/html/index.html
EOF

tags = {
    Name = "webserver"
}
}
