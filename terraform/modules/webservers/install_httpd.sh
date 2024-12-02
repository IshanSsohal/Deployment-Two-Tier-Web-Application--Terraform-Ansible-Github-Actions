#!/bin/bash
sudo yum -y update
sudo yum -y install httpd

# Fetch instance metadata and current time
myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
availability_zone=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
current_time=$(date)

# Create index.html with dynamic content
sudo cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ACS Group Project Fall 2024</title>
    <style>
        body { font-family: Arial, sans-serif; }
        h1 { color: #FF0000; }
        .metadata { color: blue; }
    </style>
</head>
<body>
    <center>
        <br>
        <hr>
        <h1>WELCOME TO GROUP 7 WEBSERVER DEPLOYMENT IN AWS!</h1>
        <hr>
        <img src='https://group-7-dev.s3.us-east-1.amazonaws.com/Images/1731876860385.jpg' alt="Image from S3" width="100" height="100">
        <h2>This is a dev environment provisioned by our team</h2>
        <strong style="color:#FF0000;">
            Ishan Sohal<br>
            Vishnu Reghunath<br>
            Rony Hopeman<br>
            Yash Gujral<br>
        </strong>
        <h3 class="metadata">
            Private IP: $myip<br>
            Instance ID: $instance_id<br>
            Availability Zone: $availability_zone<br>
            Current Server Time: $current_time<br>
        </h3>
        <p>ACS 730 - Fall 2024</p>
    </center>
</body>
</html>
EOF

# Start and enable httpd service
sudo systemctl start httpd
sudo systemctl enable httpd
