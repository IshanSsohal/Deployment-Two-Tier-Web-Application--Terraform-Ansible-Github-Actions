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
        .team-image { 
            display: flex; 
            justify-content: center; 
            margin-top: 20px; 
        }
        .team-image img { 
            width: 100%; /* Responsive scaling */
            max-width: 800px; /* Limit max size */
            height: auto; /* Maintain aspect ratio */
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5); /* Optional shadow */
        }
    </style>
</head>
<body>
    <center>
        <br>
        <hr>
        <h1>WELCOME TO GROUP 7 WEBSERVER DEPLOYMENT IN AWS!</h1>
        <hr>
        <div class="team-image">
            <img src="https://group-7-prod.s3.us-east-1.amazonaws.com/Group7.jpg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEG8aCXVzLWVhc3QtMSJHMEUCIDSi00uKcpV6NKz8v34PxhOK2Xpv5DI9bk9D3t95GEuEAiEA2CZRRf4HDy%2B4d3PGkR4KfUxW2cS%2FKezLbdFL8KIgVu4q0AMIKBAAGgwzOTEzNTY2Mjc1ODciDJMwVRRnL3xJ%2FNXFRSqtA4AwU%2BDENMtQEjhez%2Fi%2FmKIo0IOvXwq2YbDIkIMglu8Aknb7tEy4mHDWr8BkkZNlAqQ5S0gx%2B96XOFGXheljt2tidsEh4dGEmI602hnC2mxIAeYv%2FAoIMZc3SUzeVNC4LTZ4dB%2BFxnK1NKEPIDgBSLkkxXvk4mUJEUMBMQ%2FMclS2CIYd7txpGGU1N1p6GN8%2F91ikbaj%2FPzhu6VrtPQqiahpxgrZbRKTlNcjvWdKg9yf96XNxdiZAk1c1ysv0icpi%2B7zKioFuwRIgVGdSrpFMEF0g7sIcBeXXYMaS4QoMigC1%2FBhkfMhxSIk%2BCs04yzsK2QxQ8eYR%2F7nEWsaUB5mD08R9WZboAR7P9QhWO3anXL6PXGDngz%2BP%2BD4VV3ZuPMkZ643Djymy9ywpqFGmqJcJlre%2FmsF1nw7bSBxOVRoBI8t3%2BxXkWKFh7SRskL%2FfSPb%2BBKKcPPNchRuN%2B6em6jwLOqyOr50NBBMOZKvkU5vqpIqQVBVzKvHalUqYqePbss9fw10ULDGvLNqftuYQchaYGPQKT0ljGTqcUKK4AGsabh5fNY%2Fty5NYpxbNDmH3KzCF%2FMm6Bjq3Anju%2FVrxG%2B%2FANKMvlu43yOF2XKjuAJBXMnuri1HOiIKdDu%2FqGQ5C3x0Soa85ehd2gJoglWpTg%2FlxTkXtRAcT8eAxuI4PIxjN%2Fzz225eu2yAsI5jIPgAAvBDzdMe41DPCfMwAxEyKbZxqIyhBTrhk%2FWVkEDeqpY%2FjZG%2FM%2BH9NUe%2FEa%2BE5wpPvFOdrWiPM8RRhChsLDvyq6jbqwRH2AROr5Bb8p%2B8YI1LH9kwUX5IC2kniT9gfk6XNkVdwUdTFv8eG%2BXiXLpL8DS%2B86FrFCDVq6Jj09QDZ0olRxyZl99S64K5hp%2BejB4XZihycCXlQylD2YtAlkJQd%2Bi6i4BSPGW16NlAModIxmuxFrlFxyxPHh5Jz5fguNd8PyWzsNzgqC8AFM9B1%2Fa9tK2o1efrGUWWDXKIE2x4CMBuU&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVWHVMHKBXX3J6ZK6%2F20241206%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241206T062237Z&X-Amz-Expires=14400&X-Amz-SignedHeaders=host&X-Amz-Signature=4d6532bc7adfcaccfbb88733b9b4fb67269c7b5f5cf1fe27b56d3fbba0a6f1cb" alt="Group Photo">
        </div>
        <h2>This is a prod environment provisioned by our team</h2>
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