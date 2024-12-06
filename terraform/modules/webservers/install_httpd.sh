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
            <img src="https://group-7-staging.s3.us-east-1.amazonaws.com/Group7.jpg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGwaCXVzLWVhc3QtMSJIMEYCIQCvl0rlih35D6YhNaXmIY6S7G9%2F8UQ3efX9soigSAJHYQIhAMYjbINOGZoxBzQlXPmmihmH%2BiSoMfrSyNfXmygjucuOKtADCCUQABoMMzkxMzU2NjI3NTg3IgxAWJPt0xw45cAe8GUqrQMTXiso%2BK8mpDIdbxUvuAhU9vdD23Jybj5RuoEXm%2FXHoR2CeTnjGhC0XziUIjYiRK12MaBssSwTGywcFlaGJGv%2FehY%2B8c7DHdqVbm0vxgQ0NI%2Fnoo8%2FNGEvvox6bRLlfbZHoh3e0m2I36jm0jVuzoMtIl%2Bc5T0PSD%2BYbwjubuK0oeTVSWjZAGUaBKUQvppExVj5DpKKiG6fPrjdP0L9tdHM3t8uhoOi7rTT1nbKJy%2Fp%2F0ZJrmHcuivf8I3SBNJuFPHPR%2FNmhhjKi2cfq6MqCmC3mVpmawqtDkHOVyTzrHX9DZ0xaho5gXELodY1qBGh2QbyYmvZENZU3Ij9njaKnnua66OKn4UvIG9DDrJG456N0v7Bx%2FmzE6adruFJ39VXUvuPJpCqDDsAJdM6ReyXH6whPKcbFPnZZDDy1GHhCOZZpUcLliPtgGujxtkqQjmu5JlM8exxwAXUx6yHK3rov6V%2FLD77OQWYv3f3Ml11MqFBiYVpXBbkPYLpGZdMykxxaptNRwv8ExiOGdZNUybJUcqW32wVOV4%2F0gIc1dg9RxiUs4tlkQGZgViUYNyLS7swrYvJugY6tgLhZChf4H8vptCyLR06oIaxjArjo3iA%2FHwVui0uGoo9evgwXvDtoM6sajcNpw8TK74tJ3EEhO9OlPsRJKTzjvRwSLLee21LaRSr9Flc5W7flxHJJDnMuwc5zTEq6J44Z%2FWhcIpT5KJdnVFMmcKp9ZMba4OLNT4D9sEtbcvxWiLWMsIGrIbFasXnDAL8CTxJ0mCJhlnpTxwTtVyv2F6WKTdI37VfckytMrRal1JZrtYXk2%2FQsu%2BKbyJ%2BN2%2BkQeekA9Dc1HxokVD7YC5Cn2Nmq72pUiuEGQfAcKUBY994%2FS7KzbMSBZsN4IGq9rH4rtYybDkFY3aLAPuwy3MZkR%2FvSQpUzng6%2BhvxiD74nbuQxx4KwtLKKLfXI0qX2uo%2FiOMGpSLelTCht77SsI3mdPoRtpBEfQDCl0oJ&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVWHVMHKBSSBSVMTL%2F20241206%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241206T034414Z&X-Amz-Expires=21600&X-Amz-SignedHeaders=host&X-Amz-Signature=27855a14cebfbb4386a1a1624f1de1a9ea9910cdd7fcb7fe25847aae8c0c4138" alt="Group7">
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
