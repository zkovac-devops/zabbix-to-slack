Zabbix-to-Slack alertscript
===========================
A shell script to send Zabbix notifications to Slack

This is the modification of original ericos's [shell script](https://github.com/ericoc/zabbix-slack-alertscript/raw/master/slack.sh). I just wanted to have the output more customizable. :)

Compatibility
=============
This script was tested on Zabbix version 2.2, but will definitely work with higher (lower) versions as well.

Step-by-step procedure
======================
1. Place the script in /usr/lib/zabbix/alertscripts/ directory on your Zabbix server.
2. Make it executable and set ownership for zabbix user: 

         **$ chmod 755 zabbix-slack.sh && chown zabbix:zabbix zabbix-slack.sh**
         
3. Log into Slack and Add Incoming Webhook Integration to your channel.
4. Copy Webhook URL and paste it at the beginning of the script (slack_url variable)
5. Log into Zabbix Web-UI frontend
   
   a) Navigate to Administration --> Media types and click Create media type button in the upper right corner
   
    * **Name**: Slack
    * **Type**: Script
    * **Script name**: zabbix-slack.sh
  
   b) Navigate to Administration --> Users --> Click on member you'd like to add media to --> Go to Media tab

    * **Type**: Slack
    * **Send to**: #alerts      
    
    Note: #alerts is a slack's channel name, so use the one that fits your channel name
    
    Click Add
    
   c) Last step is to create an action: Configuration --> Actions --> Click on existing name or Create action button
      On Action tab, use following:
    
    * **Default subject**: {TRIGGER.STATUS}
    * **Default message**: {DATE}@{TIME}@{TRIGGER.SEVERITY}@{HOST.NAME1}@{TRIGGER.NAME}
    
    * **Recovery subject**: {TRIGGER.STATUS}
    * **Recovery message**: {DATE}@{TIME}@{TRIGGER.SEVERITY}@{HOST.NAME1}@{TRIGGER.NAME}

6. Restart zabbix-server service on Zabbix server: 

         **$ service zabbix-server restart**


    
