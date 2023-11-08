#log_file="/tmp/expense.log"
#color="\e[36m"

#source means import
source common.sh

#bellow -z means empty if password is empty the display msg like "Password Input Missing" and exit
if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1

#status_check(){
#  if [ $? -eq 0 ]; then
#    echo -e "\e[32m SUCCESS \e[0m"
#  else
#    echo  -e "\e[31m FAILURE \e[0m"
#  fi
#}

echo -e "${color} Disable NodeJS default version \e[0m"
dnf module disable nodejs -y &>>$log_file
#echo $?
#instead of zero and non we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi

status_check

echo -e "${color} Enable nodeJS 18 version \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check


echo -e "${color} install NodeJS \e[0m"
dnf install nodejs -y &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check


echo -e "${color} Copy backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check


id expense &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
if [ $? -ne 0 ]; then
    echo -e "${color} Add application user \e[0m"
    #Instead of writing every where same code we can create a function like "Status_check" call that function.
#    if [ $? -eq 0 ]; then
#      echo -e "\e[32m SUCCESS \e[0m"
#    else
#      echo  -e "\e[31m FAILURE \e[0m"
#    fi
    status_check
fi

if [ ! -d /app ]; then
    echo -e "${color} Create Application directory \e[0m"
    mkdir /app &>>$log_file
    #echo $?
    #instead of zero and non zero we can give SUCCESS and FAILUER using if condition
    #Instead of writing every where same code we can create a function like "Status_check" call that function.
#    if [ $? -eq 0 ]; then
#      echo -e "\e[32m SUCCESS \e[0m"
#    else
#      echo  -e "\e[31m FAILURE \e[0m"
#    fi
     status_check
fi
echo -e "${color} delete old Application content \e[0m"
rm -rf /app/* &>>log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} Download the application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} Go to the app folder \e[0m"
cd /app &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} Extract the file \e[0m "
unzip /tmp/backend.zip &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} Download NodeJS dependencies \e[0m"
npm install &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} install mysql client to load schema \e[0m"
dnf install mysql -y &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} Load Schema \e[0m"
#mysql -h mysql-dev.kiran85.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
mysql -h mysql-dev.kiran85.online -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

echo -e "${color} Starting the backend service \e[0m"
systemctl daemon-reload &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

systemctl enable backend &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check

systemctl restart backend &>>$log_file
#echo $?
#instead of zero and non zero we can give SUCCESS and FAILUER using if condition
#Instead of writing every where same code we can create a function like "Status_check" call that function.
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m SUCCESS \e[0m"
#else
#  echo  -e "\e[31m FAILURE \e[0m"
#fi
status_check




