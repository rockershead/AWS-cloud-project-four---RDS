# AWS-cloud-project-four---RDS

This simple project aims to create 2 lambda functions triggered by API_GATEWAY which will interact with a RDS table(mysql) hosted in AWS, within the default vpc.


# Steps to deploy in aws
- in my case I am using a linux terminal
- make sure access_keys and secret key are all configured in the terminal 
- cd to each of the lambda folders, create_user and get_users
- npm install
- Under create_user folder, command:zip -r create_user.zip .
- Under get_users folder, command:zip -r get_user.zip .
- cd into terraform folder
- ./run_script.sh