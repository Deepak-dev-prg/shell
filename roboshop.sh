#!/bin/bash

AMI=ami-0b72821e2f351e396 #this keeps on changing
SG_ID=sg-0dba54ee5570f65ab #replace with your SG ID
KEY_NAME=shell
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")

for i in "${INSTANCES[@]}"
do
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi

    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-group-ids sg-0dba54ee5570f65ab --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text )
    
    echo "$i: $IP_ADDRESS"
    done   