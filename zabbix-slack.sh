#!/bin/bash

# Slack Incoming webhook URL and username

slack_url=''  # put your Slack Webhook URL here
slack_username='' # choose whatever you want to see as a message from in Slack

slack_channel="$1"
zabbix_trigger_status="$2"      # It's either PROBLEM or OK
zabbix_message="$3"

# Parse the Zabbix message 

zabbix_trigger_date=`echo $3 | cut -d '@' -f1`
zabbix_trigger_time=`echo $3 | cut -d '@' -f2`
zabbix_trigger_severity=`echo $3 | cut -d '@' -f3`
zabbix_host_name=`echo $3 | cut -d '@' -f4`
zabbix_trigger_message=`echo $3 | cut -d '@' -f5`

# Change Slack message's attachment color depending on the severity

if [ "$zabbix_trigger_status" == 'OK' ]
then
        color="#4AC948"

elif [ "$zabbix_trigger_severity" == "Not classified" ]
then
        color="#DBDBDB"

elif [ "$zabbix_trigger_severity" == "Information" ]
then
        color="#D6F6FF"

elif [ "$zabbix_trigger_severity" == "Warning" ]
then
        color="#FFF6A5"

elif [ "$zabbix_trigger_severity" == "Average" ]
then
        color="#FFB689"

elif [ "$zabbix_trigger_severity" == "High" ]
then
        color="#FF9999"

elif [ "$zabbix_trigger_severity" == "Disaster" ]
then
        color="#FF3838"

fi

# Define payload to be used in your curl request to Slack Webhook

payload="payload={\"channel\": \"${slack_channel}\", \"username\": \"${slack_username}\", \"attachments\":[{\"fallback\":\"${zabbix_trigger_status}\",\"text\":\"${zabbix_trigger_status}\", \"fields\":[{\"title\":\"Date\",\"value\":\"${zabbix_trigger_date}\",\"short\":false},{\"title\":\"Time\",\"value\":\"${zabbix_trigger_time}\",\"short\":false},{\"title\":\"Hostname\",\"value\":\"${zabbix_host_name}\",\"short\":false},{\"title\":\"Trigger severity\",\"value\":\"${zabbix_trigger_severity}\",\"short\":false},{\"title\":\"Trigger message\",\"value\":\"${zabbix_trigger_message}\",\"short\":false}],\"color\":\"${color}\"}]}"

# POST data to Slack Webhook using curl

curl -m 5 --data-urlencode "${payload}" $slack_url
echo
