README.md for Group 7 deployment of Static Two-tier Web Application in AWS CLOUD

# ACS730FinalProjectGroup7
![image](https://github.com/user-attachments/assets/f888b455-ca84-4dc1-a233-e2812a0c9942)

Fall-2024 Automation and Control Systems ACS730 Final Project

Step- 1 Create S3 buckets for respective environment Dev or staging or prod
with the name group-7-dev, or group-7-staging or group-7-prod


Step 2- clone the repo and upload the image to the bucket.
a. upload the image you want to display on the Application and create a pre-signed URL for that image.
b. now spin up your env where you want to clone the repository ACS730FinalProjectGroup7
c. Clone the repository and checkout to the branch(dev, staging and prod) where you want to deploy the web app.

Step 3- Copy the pre-signed URL created and then paste it into playbook.yaml in the s3_image_url: file in the ansible directory and install_httpd.sh template in "img_src=" terraform/modules/webservers/ directory.

Step 4-Navigate to terraform/(branchname)/network and run :
                a. terraform init
                b terraform  validate
                c. terraform plan
                d. terraform apply -auto-approve

Step 5- Navigate to terraform/(branch-name)/webservers and create the ssh key by running this command.
              "ssh-keygen -t rsa -f (branch-name)-keypair"
Step 6- Run the following commands
                a. terraform init
                b terraform  validate
                c. terraform plan
                d. terraform apply -auto-approve


TO CONFIGURE WEBSERVER3 AND WEBSERVER4 WITH ANSIBLE
Step 7- Navigate to ACS730FinalProjectGroup7/ansible directory and install ansible, boto3, botocore and run the following commands
                a. sudo yum install -y ansible
                b. ansible --version
                c. pip3 install boto3 botocore
                d. ansible-inventory --list
                e. ansible all -m ping
                f. ansible-playbook playbook.yaml


