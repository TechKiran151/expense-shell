log_file="/tmp/expense.log"
color="\e[36m"

echo -e "${color} Disable NodeJS default version \e[0m"
dnf module disable nodejs -y &>>$log_file
echo $?

echo -e "${color} Enable nodeJS 18 version \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
echo $?

echo -e "${color} install NodeJS \e[0m"
dnf install nodejs -y &>>$log_file
echo $?

echo -e "${color} Copy backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo -e "${color} Add application user \e[0m"
useradd expense &>>$log_file
echo $?

echo -e "${color} Create Application directory \e[0m"
mkdir /app &>>$log_file
echo $?

echo -e "${color} delete old Application content \e[0m"
rm -rf /app/* &>>log_file
echo $?

echo -e "${color} Download the application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
echo $?

echo -e "${color} Go to the app folder \e[0m"
cd /app &>>$log_file
echo $?

echo -e "{color} Extract the file \e[0m "
unzip /tmp/backend.zip &>>$log_file
echo $?

echo -e "${color} Download NodeJS dependencies \e[0m"
npm install &>>$log_file
echo $?

echo -e "${color} install mysql client to load schema \e[0m"
dnf install mysql -y &>>$log_file
echo $?

echo -e "${color} Load Schema \e[0m"
mysql -h mysql-dev.kiran85.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?

echo -e "${color} Starting the backend service \e[0m"
systemctl daemon-reload &>>$log_file
echo $?
systemctl enable backend &>>$log_file
echo  $?
systemctl restart backend &>>$log_file
echo $?



