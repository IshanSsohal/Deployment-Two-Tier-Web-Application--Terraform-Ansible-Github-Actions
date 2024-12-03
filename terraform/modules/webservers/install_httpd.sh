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
            <img src="https://group-7-dev.s3.us-east-1.amazonaws.com/ishan.jpeg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDgaCXVzLWVhc3QtMSJGMEQCIG9GLP%2Btuc9yFxXOjxnCuDhUzoQxPZYZHOo%2BEHrjO5R3AiAwCcOmxIqxCAwnTfG%2FQZ8siBalcFahvB0MVSmQfmnFxyrhAwjh%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDg0NjMxMjA0NjA2MyIMa39cRxk996c%2Bk8p%2BKrUDe1w1GbSY6iAIUxqNT%2BmTbj6nYxk95tnlTC91TefE6GSkWHsaFaEZUq3%2FZCljh5S3oDuLyK1oIivP1I6sF8HIOSZna0YIvln5TAztfP3N04XS0slhnSg8Qnyer1dSzdvpfLlRu1UAFwfB5Tbqewm5%2FX0SlCv1BRmlyfh70dTcL5ToD0LVTMtj7HQtfR%2FCRKbdolt%2FcOTUfy3%2F6gfeEkA%2B1sdmkGOLEYYoQV0vhPhfMeDdbUWdsq64IEoj%2FEQZco2gTjyVcNnE6cy3c6Y59MSEd%2BiHszwl1OtY3HWGVWEbqg%2FEM%2Bs5VtEwUjUggy6s1JL94yZIsK9PbeF1pa6SlSeUv4LeqtiyoRltgvdR9a0ONyt7pwEBw%2BmMxLHLXTkMRci7bi9gEr3pjOOyy9WUnn%2BQbshCuolvx9%2Fi6LiMlKAORNn3%2BbCjvSMOJlxQvzuOdWVwqN7MNoKaTGcE3%2BAxi84sUjnjcEHd17HTszmEhWyQR%2BGkReZhplrX6ndXIIReWz6EXnET5YAOTH3GBvFp%2FNiBMMnNFIyVOIcDCrlFQUFi2Z%2BHhT0GWEG9MQNPAD8tvGTDma6j08EwmeK9ugY6uALs4AcFgZJJL4hjxHUCFqJwccwaJqYvUQ6bW6RVAo%2BQBPxtrTPN9E8MMB8OloSKY2N59cxAWjgp9DD1QopU4tdOOsInYfKF8wzCOL8brbbCvX3H9ok3rnM6YoFb6vhheBU%2BNAjyWqW4sX7lpfB1evvOB5La502Z6uzZjUtSl05XVucQ24aZV9qaXhihwGlv7IszA3E0IEgagsMR8sVDTzt3dUOoqn3jUwRxQ5YLqtBAqdD%2FmkOSYhgJTXq0Bf5CPGRM1bAtQWOiWRbwzoMPFkLZrkm%2B2ejcRKwZMb5wy41S9TlknNtchMmFJHgUkQnwU%2FnvZS5P5wKiWvZuIlyXNzyYn6%2Fgs8w8Wh6aYUm1gSknVloPb3VJUiXVns75pgzX0gm%2BstNrzOFQWUcJcC3RpV87qpV86ApawP4%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4KDBA7XXW4SMJ77F%2F20241203%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241203T234235Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=794c17df4d41c730c453240bd0ab6250cdaf2dfcf0cc667f5a7757aee04ff1d1" alt="Ishan">
            <img src="https://group-7-dev.s3.us-east-1.amazonaws.com/vishnu.jpeg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDgaCXVzLWVhc3QtMSJGMEQCIG9GLP%2Btuc9yFxXOjxnCuDhUzoQxPZYZHOo%2BEHrjO5R3AiAwCcOmxIqxCAwnTfG%2FQZ8siBalcFahvB0MVSmQfmnFxyrhAwjh%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDg0NjMxMjA0NjA2MyIMa39cRxk996c%2Bk8p%2BKrUDe1w1GbSY6iAIUxqNT%2BmTbj6nYxk95tnlTC91TefE6GSkWHsaFaEZUq3%2FZCljh5S3oDuLyK1oIivP1I6sF8HIOSZna0YIvln5TAztfP3N04XS0slhnSg8Qnyer1dSzdvpfLlRu1UAFwfB5Tbqewm5%2FX0SlCv1BRmlyfh70dTcL5ToD0LVTMtj7HQtfR%2FCRKbdolt%2FcOTUfy3%2F6gfeEkA%2B1sdmkGOLEYYoQV0vhPhfMeDdbUWdsq64IEoj%2FEQZco2gTjyVcNnE6cy3c6Y59MSEd%2BiHszwl1OtY3HWGVWEbqg%2FEM%2Bs5VtEwUjUggy6s1JL94yZIsK9PbeF1pa6SlSeUv4LeqtiyoRltgvdR9a0ONyt7pwEBw%2BmMxLHLXTkMRci7bi9gEr3pjOOyy9WUnn%2BQbshCuolvx9%2Fi6LiMlKAORNn3%2BbCjvSMOJlxQvzuOdWVwqN7MNoKaTGcE3%2BAxi84sUjnjcEHd17HTszmEhWyQR%2BGkReZhplrX6ndXIIReWz6EXnET5YAOTH3GBvFp%2FNiBMMnNFIyVOIcDCrlFQUFi2Z%2BHhT0GWEG9MQNPAD8tvGTDma6j08EwmeK9ugY6uALs4AcFgZJJL4hjxHUCFqJwccwaJqYvUQ6bW6RVAo%2BQBPxtrTPN9E8MMB8OloSKY2N59cxAWjgp9DD1QopU4tdOOsInYfKF8wzCOL8brbbCvX3H9ok3rnM6YoFb6vhheBU%2BNAjyWqW4sX7lpfB1evvOB5La502Z6uzZjUtSl05XVucQ24aZV9qaXhihwGlv7IszA3E0IEgagsMR8sVDTzt3dUOoqn3jUwRxQ5YLqtBAqdD%2FmkOSYhgJTXq0Bf5CPGRM1bAtQWOiWRbwzoMPFkLZrkm%2B2ejcRKwZMb5wy41S9TlknNtchMmFJHgUkQnwU%2FnvZS5P5wKiWvZuIlyXNzyYn6%2Fgs8w8Wh6aYUm1gSknVloPb3VJUiXVns75pgzX0gm%2BstNrzOFQWUcJcC3RpV87qpV86ApawP4%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4KDBA7XXW4SMJ77F%2F20241203%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241203T234638Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=c0381c4b1ca247b850b6f4b8d65fd8e8fc09686103034e71080345c1ce9f1e60" alt="Vishnu">
            <img src="https://group-7-dev.s3.us-east-1.amazonaws.com/rony.jpeg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDgaCXVzLWVhc3QtMSJGMEQCIG9GLP%2Btuc9yFxXOjxnCuDhUzoQxPZYZHOo%2BEHrjO5R3AiAwCcOmxIqxCAwnTfG%2FQZ8siBalcFahvB0MVSmQfmnFxyrhAwjh%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDg0NjMxMjA0NjA2MyIMa39cRxk996c%2Bk8p%2BKrUDe1w1GbSY6iAIUxqNT%2BmTbj6nYxk95tnlTC91TefE6GSkWHsaFaEZUq3%2FZCljh5S3oDuLyK1oIivP1I6sF8HIOSZna0YIvln5TAztfP3N04XS0slhnSg8Qnyer1dSzdvpfLlRu1UAFwfB5Tbqewm5%2FX0SlCv1BRmlyfh70dTcL5ToD0LVTMtj7HQtfR%2FCRKbdolt%2FcOTUfy3%2F6gfeEkA%2B1sdmkGOLEYYoQV0vhPhfMeDdbUWdsq64IEoj%2FEQZco2gTjyVcNnE6cy3c6Y59MSEd%2BiHszwl1OtY3HWGVWEbqg%2FEM%2Bs5VtEwUjUggy6s1JL94yZIsK9PbeF1pa6SlSeUv4LeqtiyoRltgvdR9a0ONyt7pwEBw%2BmMxLHLXTkMRci7bi9gEr3pjOOyy9WUnn%2BQbshCuolvx9%2Fi6LiMlKAORNn3%2BbCjvSMOJlxQvzuOdWVwqN7MNoKaTGcE3%2BAxi84sUjnjcEHd17HTszmEhWyQR%2BGkReZhplrX6ndXIIReWz6EXnET5YAOTH3GBvFp%2FNiBMMnNFIyVOIcDCrlFQUFi2Z%2BHhT0GWEG9MQNPAD8tvGTDma6j08EwmeK9ugY6uALs4AcFgZJJL4hjxHUCFqJwccwaJqYvUQ6bW6RVAo%2BQBPxtrTPN9E8MMB8OloSKY2N59cxAWjgp9DD1QopU4tdOOsInYfKF8wzCOL8brbbCvX3H9ok3rnM6YoFb6vhheBU%2BNAjyWqW4sX7lpfB1evvOB5La502Z6uzZjUtSl05XVucQ24aZV9qaXhihwGlv7IszA3E0IEgagsMR8sVDTzt3dUOoqn3jUwRxQ5YLqtBAqdD%2FmkOSYhgJTXq0Bf5CPGRM1bAtQWOiWRbwzoMPFkLZrkm%2B2ejcRKwZMb5wy41S9TlknNtchMmFJHgUkQnwU%2FnvZS5P5wKiWvZuIlyXNzyYn6%2Fgs8w8Wh6aYUm1gSknVloPb3VJUiXVns75pgzX0gm%2BstNrzOFQWUcJcC3RpV87qpV86ApawP4%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4KDBA7XXW4SMJ77F%2F20241203%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241203T234702Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=1f446604f64106cd6a96a200508fd2e0b850cdc4b9d61ac6f9e6dc521e56c1d3" alt="Rony">
            <img src="https://group-7-dev.s3.us-east-1.amazonaws.com/yash.jpeg?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDgaCXVzLWVhc3QtMSJGMEQCIG9GLP%2Btuc9yFxXOjxnCuDhUzoQxPZYZHOo%2BEHrjO5R3AiAwCcOmxIqxCAwnTfG%2FQZ8siBalcFahvB0MVSmQfmnFxyrhAwjh%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDg0NjMxMjA0NjA2MyIMa39cRxk996c%2Bk8p%2BKrUDe1w1GbSY6iAIUxqNT%2BmTbj6nYxk95tnlTC91TefE6GSkWHsaFaEZUq3%2FZCljh5S3oDuLyK1oIivP1I6sF8HIOSZna0YIvln5TAztfP3N04XS0slhnSg8Qnyer1dSzdvpfLlRu1UAFwfB5Tbqewm5%2FX0SlCv1BRmlyfh70dTcL5ToD0LVTMtj7HQtfR%2FCRKbdolt%2FcOTUfy3%2F6gfeEkA%2B1sdmkGOLEYYoQV0vhPhfMeDdbUWdsq64IEoj%2FEQZco2gTjyVcNnE6cy3c6Y59MSEd%2BiHszwl1OtY3HWGVWEbqg%2FEM%2Bs5VtEwUjUggy6s1JL94yZIsK9PbeF1pa6SlSeUv4LeqtiyoRltgvdR9a0ONyt7pwEBw%2BmMxLHLXTkMRci7bi9gEr3pjOOyy9WUnn%2BQbshCuolvx9%2Fi6LiMlKAORNn3%2BbCjvSMOJlxQvzuOdWVwqN7MNoKaTGcE3%2BAxi84sUjnjcEHd17HTszmEhWyQR%2BGkReZhplrX6ndXIIReWz6EXnET5YAOTH3GBvFp%2FNiBMMnNFIyVOIcDCrlFQUFi2Z%2BHhT0GWEG9MQNPAD8tvGTDma6j08EwmeK9ugY6uALs4AcFgZJJL4hjxHUCFqJwccwaJqYvUQ6bW6RVAo%2BQBPxtrTPN9E8MMB8OloSKY2N59cxAWjgp9DD1QopU4tdOOsInYfKF8wzCOL8brbbCvX3H9ok3rnM6YoFb6vhheBU%2BNAjyWqW4sX7lpfB1evvOB5La502Z6uzZjUtSl05XVucQ24aZV9qaXhihwGlv7IszA3E0IEgagsMR8sVDTzt3dUOoqn3jUwRxQ5YLqtBAqdD%2FmkOSYhgJTXq0Bf5CPGRM1bAtQWOiWRbwzoMPFkLZrkm%2B2ejcRKwZMb5wy41S9TlknNtchMmFJHgUkQnwU%2FnvZS5P5wKiWvZuIlyXNzyYn6%2Fgs8w8Wh6aYUm1gSknVloPb3VJUiXVns75pgzX0gm%2BstNrzOFQWUcJcC3RpV87qpV86ApawP4%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4KDBA7XXW4SMJ77F%2F20241203%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241203T234723Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=68e45d34a11cc5e4941ba0e3bc53351cddba4c41cb52464356a75a4d0fbf87ba" alt="Yash">
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
