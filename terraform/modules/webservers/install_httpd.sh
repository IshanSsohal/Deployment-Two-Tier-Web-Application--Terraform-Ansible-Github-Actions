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
            <img src="https://group-7-staging.s3.us-east-1.amazonaws.com/Group7.jpg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEG4aCXVzLWVhc3QtMSJGMEQCIA6MprVylkIvkWvAAvTelwdWDtTgoqy7tdTNg0gaqVU%2BAiBrB4zEV8mDHaRTbn0W6i7WxgqQ%2B6shwiwtCplOBoNnGSrQAwgmEAAaDDM5MTM1NjYyNzU4NyIMNmNoQa%2FDIT6NT2KxKq0Duv1V5JJoTj3hApZoYRo%2F8LKMVRWViT%2Fre%2FaszYhU5Oi5JhjANQeDYbIsBtq9CQpO9YbWSi1WdvPvNEBNVJk1U%2BLDO4Q1ByZ06HU6RMBwUTdvx9TRuNgRJf64s2onU4oYBtQf9WrV5Lg1j8xzq0VaVGTnBGVs%2BohzsSAM%2BRHHE6R5OPOL7z110X%2FHBi%2FdE8D0CBz1VYuI7vYHwQVjwQO9ytZne%2Frt9rAVsk5IWWCI2RTNADvoYgK5YvrbqoOau%2BdkdG4z7MuIcI9REc7UfZIjDXaHewmnvo7gdanTO1iEw4f9JBXYdWEYeXQHJBrdpRZAEn0n4Gc08lRVwN2I9%2FVa%2Bi2NhvlpP6AleaWhgK7AqD%2FGyc6P5cyXA%2Fw6II4AYnJUD2OGv6kkd4M6kuvEE0XBpA3fk5lIsVvMAD5nWBnCfWs4Cugx8kSwo3SIa%2BxjvYbCcyO7pTaP4YxPKGS%2BcY57b2T83qlAfrTWVX1Flw%2F7Cc1mTWaP6GAZyU4zURfB1dqryzofYBiQ3LtHPss5yWjuONiK9L9dF4lWSUSYy1j0EKdHL4H5w9FgSzRemX6PMIX8yboGOrgCfK2PVN4xBGtH7iALHzNo9RwHNBsawia1uOyAA0z6H2NIIYmav0X%2BZn6mPs1QdrVHIEZLsAOCOvDcfV%2Fyg7seuJGD2NGxWsG7N1%2BFHlZ%2ByscHovBHQRBFjxDJS%2BqTboNkuSsORklLVEiaiIRQm7EqWJRKPpNg1j%2BdgBM29v0drw%2FVvpG%2BbegPqui%2B29bR9g1GBTxxbrveS1bcypU3rKZ6BuLxUyII3BGmz0bdCNfi0%2BhpP6c%2Bn98B1TzesPMao48lvQZdibzNpIXlXTB8wow1RNz6rqJ7TZ4gKGglL1nTlcicVBR5c3RdDfSvixkP9CN609FJ0fd3UtRKeNCOKaC8JKE3HD7OhjEdMbDnT6YgcWJ%2Fx%2BXzOAO614TGPUfpsS1YuJjuGPa8M9M7ZKYaxaKQB4PoAYKewMR2&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVWHVMHKB2XLYJBYK%2F20241206%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241206T050941Z&X-Amz-Expires=14400&X-Amz-SignedHeaders=host&X-Amz-Signature=54701ec3995b378a1406c6552a3f717bbf98a14c9d800c1e9fcdc03a97dbe899" alt="Group7">
        </div>
        <h2>This is a staging environment provisioned by our team</h2>
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
