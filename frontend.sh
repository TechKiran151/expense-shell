echo -e "\e[36m Instlling Nginx \e[0m"
dnf install nginx -y &>>/tmp/expense.log

echo -e "\[36m Copy the expense config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log

echo -e "\e[36m Clean/remove old Nginx content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log

echo -e "\e[36m download the frontend application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log

echo -e "\e[36m Extract downloaded application content \e[0m"
cd /usr/share/nginx/html &>>/tmp/expense.log
unzip /tmp/frontend.zip &>>/tmp/expense.log

echo -e "\e[36m Starting Nginx Service \e[0m"
systemctl enable nginx &>>/tmp/expense.log
systemctl restart nginx &>>/tmp?expense.log