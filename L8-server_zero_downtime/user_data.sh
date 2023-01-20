#!/bin/bash
sudo apt -y update
apt -y install nginx
sudo su
systemctl stop nginx.service

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="white">
<h2><font color="black">Terraform test build <font color="purple"> v4.48.0</font></h2><br><p>
<font color="DarkSlateBlue">Server PrivateIP: <font color="aqua">$myip<br><br>
<b>Version 2.0</b>
</body>
</html>
EOF
systemctl start nginx.service
