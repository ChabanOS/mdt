#!/bin/bash

# Stop/Start script for MDT projects/mdt

MDT_DIR=/home/ec2-user/projects/mdt
MDT_VENV=/home/ec2-user/virtualnev/mdt/bin/activate

if [[ $1 == "start" ]]; then
	# Start part
	source $MDT_VENV
	cd $MDT_DIR
	python manage.py runserver 0.0.0.0:8000

elif [[ $1 == "stop" ]]; then
	# Stop part
	for proc in `ps -ef | grep manage.py | grep -v grep | awk {'print $2'}`
	do
		kill -9 $proc
	done

else
	# no or wrong argument
	echo 'You should specify correct argument. It can be start or stop'
	exit 0	

fi
