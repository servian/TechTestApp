#!/bin/bash

APP_PACKAGE="TechChallenge.zip"

curl -L -o $APP_PACKAGE ${latest_app_package_path}

mv $APP_PACKAGE /opt

cd /opt

unzip $APP_PACKAGE
rm -rf $APP_PACKAGE
cd dist/

# Replace the existing contents with the new contents
echo "\"DbUser\" = \"dummy\"
\"DbPassword\" = \"dummy\"
\"DbName\" = "\"${db_name}\""
\"DbPort\" = "\"${db_port}\""
\"DbHost\" = "\"${db_host}\""
\"ListenHost\" = "\"${listen_host}\""
\"ListenPort\" = "\"${listen_port}\""
" > conf.toml

# Environment variables override config file.
export VTT_DBUSER = ${db_user}
export VTT_DBPASSWORD = ${db_password}

# Now run the TecChallngeApp
nohup ./TechChallengeApp serve &

ps -fx | grep TechChallengeApp

echo "App is running successfully"