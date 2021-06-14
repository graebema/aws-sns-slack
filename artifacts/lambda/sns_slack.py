import json
import re
import os
import boto3
import urllib3

# Lambda global variables
region = os.environ["AWS_REGION"]  # from Lambda default envs
slack_url = os.environ["SLACK_URL"]
slack_channel = os.environ["SLACK_CHANNEL"]
slack_user = os.environ["SLACK_USER"]


http = urllib3.PoolManager()
def lambda_handler(event, context):
    url = slack_url  
    msg = {
        "channel": slack_channel,
        "username": slack_user,
        "text": event['Records'][0]['Sns']['Message'],
        "icon_emoji": ""
    }

    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST',url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'],
        "status_code": resp.status,
        "response": resp.data
    })
