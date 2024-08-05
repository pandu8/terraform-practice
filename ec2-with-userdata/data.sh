#! /bin/bash
sudo -i
yum update -y
yum install nginx -y
cd /usr/share/nginx/html
rm -rf index.html
echo "deputy CM gaari thaalukaa" | cat > index.html
systemctl restart nginx
