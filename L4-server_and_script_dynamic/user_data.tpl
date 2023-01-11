#!/bin/bash
sudo apt -y update
apt -y install nginx
sudo su
systemctl stop nginx.service

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.nginx-debian.html
<html>
<h2>Terraform test build <font color="purple"> v4.48.0</font></h2><br>
Owner ${f_name} ${l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}

</html>
EOF
systemctl start nginx.service
