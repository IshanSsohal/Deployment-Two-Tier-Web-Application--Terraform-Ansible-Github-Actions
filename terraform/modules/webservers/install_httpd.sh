#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>ACS Group Project Fall 2024</title>
</head>
<body>
    <center>
        <br>
        <hr>
        <h1>
            WELCOME TO <span style=color:#FF0000;>GROUP 7</span> WEBSERVER DEPLOYMENT IN AWS!
        </h1>
        <hr>
        <img src='https://group-7-dev.s3.us-east-1.amazonaws.com/Images/1731876860385.jpg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEAcaCXVzLWVhc3QtMSJIMEYCIQDOaKX3OaGOqhPjSr1KAI0qbPVbbASXVPnAlOlUILsZSwIhANuLcz34sztPuNNdr2jq6mjWbBGFsIBZeiSmkmbi6l74KtkDCK%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMzkxMzU2NjI3NTg3IgxhIllbKWVKqA1589gqrQM%2FwAS1000CV3O6uX2MQ6yK6sYpApYEQEIF6qEC2D6PE8HQjhi8mB8zYNZMhCVTXlGaREdMwysJyvVvUK6aqIpDg%2Fzw3FKsookj%2Fhw8Ptdjc3JcRGSIp9G1UZT9nRoOzhSv0ENMPCgpvBLy4uoCOVAGlVcLg%2Bdw9NOaoq43iHR31lPR238yMzfVK7fF1ClZasyGfkjZTrSdsy7Df%2FXWiHpJ1eeWAYF2nFgEqAiVmRkAFkN6WIRXH0xyfsaOMv3flAoLtu%2FRbkaX7t875TVzFOCOwWzSe1uLad7hCdthq%2FGfRcqzL7f2as0x2wqcaGMCmoj9d0q2eIb4r0e1LTpNweePKxuzV8u%2B%2BmcG9EImrdTzAu0qXQ6e3JgNoDibxiE78bTJjU4FCwgOSaz7ro5rfpcmwXZYc9nir3FYLyPIYXVBYyJrYUzA9fBAn2PjcinUAS0xhWwLVx4ARCFQ7Zxws%2BfYLeRwL1jE8WdKvBZZEGaSiidnidAzLtYlz8CQUq1XTHamGqeJuC%2BcEd51f%2F78blXPBNMS99nmtfoMJqyz8ea%2F8wiHa2EquJhGZJzMy2Mw096yugY6tgISlXdoSMqd9jEYSxv5eZdYj3UQPk9dOvzOEusOHHCY8Q9tj7P0cEqcn7XzSv3NAF9%2FcU9i487z%2BtsdqZ2pypvcUoX3ppYFre9QkDuTnEvTlSMrSAfcaADdS6u5VG%2Fis6D02uGSi81wR45jfduaGAuQ7AdsLr%2BFIBd0Tq377tLt5RmUdb%2B0J6VA1T%2BYHPvg0Z8q%2BeXeTMEzn8meZ9Zti%2BrjTmiivPxEWkP2h5RBlCqmk%2BAhq5kO5ltFFVR7ha7kHlPc4aA9L2h0kLWNsAmicQo7jZjrnDyOosqmDZyi1oV8Hbo4gCqBUlzGcSVECN4C45vz2zo1QDgYrPAZJCBzk%2FNgbxKxskekmVZ155Ef2pdBLqBVkZ6cvk8LGBLG5HTXUa71AzCo8QNuCkPMbckRbMV8IEdfRZhX&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVWHVMHKB27VSJC2J%2F20241201%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241201T221657Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=64920625e835e2d5cd9505f1249b25237e67cc0601719faa57b4792278c8412a' alt=\"Image from S3\" width=\"100\" height=\"100\">
        <h1>
            This is a dev environment provisioned by the team<br>
            <br>
            <strong style=color:#FF0000;>
                Ishan Sohal<br>
                Vishnu Reghunath<br>
                Rony Hopeman<br>
                Yash Gujral<br>
            </strong>
            <br>
            ACS 730 - Fall 2024
        </h1>
        <h3>
            My private IP address is <font color=\"red\">$myip</font>!
        </h3>
    </center>
</body>
</html>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
