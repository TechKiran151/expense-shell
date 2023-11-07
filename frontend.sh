echo -e "\e[36m Instlling Nginx \e[0m"
dnf install nginx -y

echo -e "\[36m Copy the expense config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[36m Clean/remove old Nginx content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m download the frontend application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m Extract downloaded application content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\2[36m Starting Nginx Service \e[0m"
systemctl enable nginx
systemctl restart nginx