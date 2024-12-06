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
            <img src="https://group-7-dev.s3.us-east-1.amazonaws.com/Group7.jpg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEG0aCXVzLWVhc3QtMSJIMEYCIQDi0wigRy5qVRcnu%2BwY6yzBiDVxz2qlBpbg5ZlhhE3NFAIhAJm6xTCAyRjv3EkbF1eeY6SaTB%2FQedALmquAnXHT5xC2KtADCCYQABoMMzkxMzU2NjI3NTg3IgxHo7gifPQPp29zrKUqrQNbtBd%2FqWdk%2FWLLwbo909KfPnBn929%2BQKI6YGLhqyXTDH8vpCNVrgWGq9BYoJDAZkbMC7hfHGIJPJVba0uhkVnLtg%2BvY%2FrCacq87oQrcZxny%2ByhIcZq6bMpsfxnVigFwVQHvjziSI3a%2BJnMi2bsMLDFeyjVH09LOjgneKyTVW2oNbMV5kflJwDPEXn4OzY4bH3n4hUUCv3KsduvxXfEWpZKceq39toMQhuif77qy5UwOIQ6AOW6wfaQscqWCA8IXVZTCbu1XV5lhaxVvf2qPLJhggaPJS1EA2L%2BE4S%2BOCNar5r%2FuFPLVmSMqba%2Faej2HCE2fjfjmV9x3gM6xbzFWMOPLWdvs5lzkiKHR7%2Ft7%2B3%2BykT7TQk2yRiNoTSw%2BTJ31%2BTVfj03MQyX%2BBYqgRww5zmhdIP7rf2tLQMrps4eOoxQJtRs8umWZgD0lTeqrrKFrZFy2V3bUBtIZ1oIfY1ngs9sKU%2FhOvsIeTDmJq0bmwl7DIHtsxkvWHVi%2BQ%2BuUTMOC7auLRmOlrXuVbQTQQEOZX1NW7b7UBZGdsjDeiPExOgb%2BdM7jdtA8IsdbDySdtIwhfzJugY6tgKNFROIwbesAVqnbVveW3desllvlrPhCPRJdiOTvlZD7oO%2FlRvTsLhCeSbC%2Fglk0iR4ennG8h3MzSswwCjMoRWqU%2BFK2mhzTjkWjasf7i5AWPfKl6yRCFej6v%2Bp7567Vt1QXWzAZAo%2Ba2yJDoNM71Y4e%2FGxvoU9olmK0nnGEMjgvR%2Byzf0NEBopO1GNoyvF6uUihoU0Sn3pYT4jj8teMAKK9JGn%2BUIghPFE2oqlZ81YtelZlA7RbIZIq0uYGEXGaf52yEe6vHcYQeAw3Cw0TOtcorNMx8C38cD%2FmtseaziLRLi%2F%2FCLyNIq483%2FkeOAB%2BJSDOmQREXZHv25lc3YOThTBakWlw7UM%2F2UHPDnL6L9MCseV4UGrGl%2FVRei4FslXl7zbLrZnBDmLTaRq2LtQ2i23sK0nwwV%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVWHVMHKB5HLCINDE%2F20241206%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241206T044234Z&X-Amz-Expires=14400&X-Amz-SignedHeaders=host&X-Amz-Signature=7e2a369ff20f4c7b64032b6bd687e525654c2f5b5d9c789563b83d2dca132131" alt="Group Photo">
        </div>
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
