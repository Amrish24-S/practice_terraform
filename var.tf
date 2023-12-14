variable "REGION" {
  default = "us-east-1"
}
variable "ZONE" {
  default = "us-east-1a"
}
variable "IP" {
  default = "103.197.115.62/32"
}
variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0230bd60aa48260c6"
  }
}
variable "IT" {
  default = "t2.micro"
}
variable "USER" {
  default = "ec2-user"
}