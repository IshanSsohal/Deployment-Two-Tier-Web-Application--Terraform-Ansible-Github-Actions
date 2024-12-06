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
        .team-images { display: flex; justify-content: center; gap: 20px; }
        .team-images img { width: 150px; height: 150px; border-radius: 50%; }
    </style>
</head>
<body>
    <center>
        <br>
        <hr>
        <h1>WELCOME TO GROUP 7 WEBSERVER DEPLOYMENT IN AWS!</h1>
        <hr>
        <div class="team-images">
            <img src="https://group-7-prod.s3.us-east-1.amazonaws.com/Group7.jpg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGQaCXVzLWVhc3QtMSJIMEYCIQDiPzH%2BoNhPNX%2F2y%2F2hgUnK4HrkAeZ7UqQvxrUCqvc9fwIhALwsLhv9%2FTl2fW17xJg3%2B%2Fqu%2BWxo2Xis6qzUo9H9QjRVKtADCBwQABoMMzkxMzU2NjI3NTg3IgykSUPy9y6sLVvx30AqrQOOIt41e0ZBOO5H0pWTOhgsl3gGX%2Fip0NOOlKWyrfK8s0tppn8kdwGM1Pelj5cOAsqQqi8idEtppjs1F4MNJlQSsEndk2yfadJqgQl6AHSOdH%2BnOr5tnGnEvYTkZbdbt9I5ciHuQeWpSWqfNl3Q%2BrVWKB%2Bso5N%2F4Z0NgMuiO3SVJdK15NPZb95AIQZEWfiyZA6OxMktAwNTWdlw7kRq3dX1QbXYIScRqF0kSrcts9oWYfCmFa%2Be6bk8sgfuhOnLxZ4T3EwCmYdO68IYy3AzZoJPPKPCZdGWuJ%2FZBA9PURF6%2FBgrB9MQtnlDKd0Z86QHy%2Bx4%2BN5NOElk%2FjcKtKK21ufQeeNxFOV7MGwb1QMQDK3Jc6vqnF51cw3PxYeTs3a3YaBAaEmnlFnGRFJm8WBydm%2BKZxVXlHSrqeksuaycxgyDnOf6KJEtOwKB2LYj7PkH3bzU94fKFC%2BaZd81axitMQjNUhk08KJKuU1Mu%2F%2Bg2q8uqSA8SVZ%2FiM3G3gIBD40y20PkAJNJT2yEw1F2YE6GvLVu98R%2FES5E%2FiGarHtd66ko5%2BCak5CrKYXM4pDOOJ4w1M7HugY6tgKXnWY%2BKMjtDaLjYKsWjD9p8V36dW9wWD3Csv%2BvzL5Iw2JyrJq55UO4wqj%2F%2BTW7viw0VPEboGnQb9sxoh5S9HINADFJa7317%2F0fplpPu43N92vukVX1N%2FTlnmB3LHTjbaENE2qcIyBWpVatuynjqOD9J0IiJPd0sUZPpKCBpobWPIj%2Fc5LgVK7kwjWJ0sLzNaGdCJ%2Fh8feANGpPv24HikOz0D%2FHkwamUhhLa8NeS8MjAkAVmzK1KcxWuRyAU4yJCBshaDlEZVMlV%2FmH9P2txW3%2FK1HuigL4TIRYZkZ%2BTZXOfKnyjhbynataOqA5ZEx0%2BU%2BGWmk5w%2FkfcMYIg4SRzd4Z2RS5rKILKuhw0sNX91kXYOreE0vbWaA5VfHoWciwHqYlGvvVE2BFYDT9qIvu00UT8erYvYAI&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVWHVMHKB4A2H2Z45%2F20241205%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241205T191146Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=afb257c287a738f2ee3245b971a79a8d56600d8f0c986b6edb945b99d4fa6c8f" alt="Group7">
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
