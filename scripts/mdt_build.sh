#!/bin/bash

MDT_DIR=/home/ec2-user/projects/mdt
MDT_VENV=/home/ec2-user/virtualnev/mdt/bin/activate
SCRIPT_HOME=/home/ec2-user/scripts

cd $MDT_DIR
git fetch
if [[ $(git rev-parse HEAD) == $(git rev-parse @{u}) ]]; then
    # No new commits
	echo "`date` - No changes" >> $SCRIPT_HOME/mdt_build.log
	exit 0
else
	echo "`date` - New commit found" >> $SCRIPT_HOME/mdt_build.log
    # Stop MDT Project
	$SCRIPT_HOME/mdt_run.sh stop

	# Build project
	cd $MDT_DIR
	# Save local changes before update (config, etc.)
	git stash
	git pull origin master
	git stash pop
	
	# Activate virtualenv
	source $MDT_VENV
	
	#Install requirements
	pip install -r requirements.txt
	
	# migrate new DB structure 
	python manage.py makemigrations
	python manage.py migrate
	
	echo "`date` - MDT Project updated" >> $SCRIPT_HOME/mdt_build.log
	# start  MDT project
	$SCRIPT_HOME/mdt_run.sh start
fi
