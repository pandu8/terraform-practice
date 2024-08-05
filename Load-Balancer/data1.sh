#! /bin/bash
sudo -i
yum update -y
yum install nginx -y
cd /usr/share/nginx/html
rm -rf index.html
echo "server-1" | cat > index.html
systemctl restart nginx
