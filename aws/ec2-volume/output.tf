output "aws_pub_ip" {
    value = aws_instance.ec2-volume.public_ip #this display the instance public ip address
}