#!/bin/bash
# copy the generated bandwidth file (from iperf3) and latency file (from ping)

# location of keys
keyGoogle=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Google/Google_tests/
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
machine_google[0]=35.221.118.215
machine_google[1]=35.244.62.86
machine_google[2]=35.240.239.67
machine_google[3]=35.244.67.82
machine_google[4]=35.242.176.77
machine_google[5]=35.246.199.235
machine_google[6]=35.247.214.66
machine_google[7]=35.197.57.246
machine_google[8]=35.245.150.179

keyName="AWStests.pem"	# name of key file


i=0
while [ $i -lt 9 ]; do
	scp -i $keyGoogle$keyName ubuntu@${machine_google[i]}:/home/ubuntu/combined_bandwidth* /Users/Dipesh/OneDrive/Research_Engineer/Papers/M2EC/results/combined/google/${name[i]}
	scp -i $keyGoogle$keyName ubuntu@${machine_google[i]}:/home/ubuntu/combined_latency* /Users/Dipesh/OneDrive/Research_Engineer/Papers/M2EC/results/combined/google/${name[i]}
	echo $i
	i=$[$i+1]
done
