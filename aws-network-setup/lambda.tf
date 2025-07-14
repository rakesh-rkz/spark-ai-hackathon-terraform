resource "aws_security_group" "lambda_sg" {
  name   = "lambda-sg"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lambda_function" "my_lambda" {
  filename         = "lambda.zip"   # Place your zip here
  function_name    = "privateLambda"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  vpc_config {
    subnet_ids         = [aws_subnet.private_lambda.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}
