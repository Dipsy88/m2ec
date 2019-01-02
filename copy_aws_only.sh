#!/bin/bash
# copy the generated bandwidth file (from iperf3) and latency file (from ping)

# location of keys
keyLocation[0]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Tokyo/
keyLocation[1]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Mumbai/
keyLocation[2]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Singapore/
keyLocation[3]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Sydney/
keyLocation[4]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/London/
keyLocation[5]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Frankfurt/
keyLocation[6]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/SaoPaulo/
keyLocation[7]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Oregon/
keyLocation[8]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/NVirginia/

name[0]=tokyo
name[1]=mumbai
name[2]=singapore
name[3]=sydney
name[4]=london
name[5]=frankfurt
name[6]=saopaulo
name[7]=oregon
name[8]=northvirginia


# ip addresses of the machines (will change)
machine_aws[0]=13.231.233.76
machine_aws[1]=13.127.52.8
machine_aws[2]=52.77.226.118
machine_aws[3]=54.252.132.224
machine_aws[4]=35.178.39.117
machine_aws[5]=3.120.159.97
machine_aws[6]=18.228.14.238
machine_aws[7]=52.34.15.169
machine_aws[8]=100.24.70.248

keyName="AWStests.pem"	# name of key file


i=0
while [ $i -lt 9 ]; do
	scp -i ${keyLocation[i]}$keyName ubuntu@${machine_aws[i]}:/home/ubuntu/combined_bandwidth* /Users/Dipesh/OneDrive/Research_Engineer/Papers/M2EC/results/combined/aws/${name[i]}
	scp -i ${keyLocation[i]}$keyName ubuntu@${machine_aws[i]}:/home/ubuntu/combined_latency* /Users/Dipesh/OneDrive/Research_Engineer/Papers/M2EC/results/combined/aws/${name[i]}
	echo $i
	i=$[$i+1]
done
