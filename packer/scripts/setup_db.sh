#!/bin/bash -e

setup_db() {
                echo \"Database setup...\"
                sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
                sudo mysql -u root -e "create database cinq; use cinq; grant ALL on cinq.* to '$APP_DB_USER'@'localhost' identified by '$APP_DB_PW';"
                source $APP_PYENV_PATH/bin/activate
                export INQUISITOR_SETTINGS=$APP_CONFIG_BASE_PATH/production.py
                cd $APP_CONFIG_BASE_PATH
                $APP_PYENV_PATH/bin/cloud-inquisitor db upgrade
                echo ''
                echo \"Ignore line above about 'Failed loading configuration from database.' It was buffered before creating DB\"
                # $APP_PYENV_PATH/bin/cloud-inquisitor setup --headless
                $APP_PYENV_PATH/bin/cloud-inquisitor setup
}

setup_db
