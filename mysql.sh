#log_file="/tmp/expense.log"
#color="\e[36m"

source common.sh

#bellow -z means empty if password is empty the display msg like "Password Input Missing" and exit
if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "${color} Disable mysql default version \e[0m"
dnf module disable mysql -y &>>$log_file
status_check

echo -e "${color} copy mysql repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo -e "${color} Install mysql server \e[0m"
dnf install mysql-community-server -y &>>$log_file
status_check

echo -e "${color} Start mysql server \e[0m"
systemctl enable mysqld &>>$log_file
status_check
systemctl start mysqld &>>$log_file
status_check

echo -e "${color} Set mysql password \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>$log_file
status_check

echo -e "${color} Verify weather it is working fine/not \e[0m"
mysql -uroot -pExpenseApp@1 &>>$log_file
status_check