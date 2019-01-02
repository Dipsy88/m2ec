#!/bin/bash
# compute bandwidth and latency between cloud providers at different locations

# location of keys
# google
keyGoogle=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Google/Google_tests/
name[0]=tokyo_google
name[1]=mumbai_google
name[2]=singapore_google
name[3]=sydney_google
name[4]=london_google
name[5]=frankfurt_google
name[6]=saopaulo_google
name[7]=oregon_google
name[8]=northvirginia_google

# amazon
keyLocation[0]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Tokyo/
keyLocation[1]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Mumbai/
keyLocation[2]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Singapore/
keyLocation[3]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Sydney/
keyLocation[4]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/London/
keyLocation[5]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Frankfurt/
keyLocation[6]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/SaoPaulo/
keyLocation[7]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Oregon/
keyLocation[8]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/NVirginia/

nameAws[0]=tokyo_aws
nameAws[1]=mumbai_aws
nameAws[2]=singapore_aws
nameAws[3]=sydney_aws
nameAws[4]=london_aws
nameAws[5]=frankfurt_aws
nameAws[6]=saopaulo_aws
nameAws[7]=oregon_aws
nameAws[8]=northvirginia_aws

# ip addresses of the machines (will change)
# google
machine_google[0]=35.221.118.215
machine_google[1]=35.244.62.86
machine_google[2]=35.240.239.67
machine_google[3]=35.244.67.82
machine_google[4]=35.242.176.77
machine_google[5]=35.246.199.235
machine_google[6]=35.247.214.66
machine_google[7]=35.197.57.246
machine_google[8]=35.245.150.179

# amazon
machine_aws[0]=13.230.197.117
machine_aws[1]=13.233.231.202
machine_aws[2]=54.169.96.154
machine_aws[3]=13.239.64.172
machine_aws[4]=3.8.167.46
machine_aws[5]=3.122.54.42
machine_aws[6]=54.233.156.226
machine_aws[7]=52.12.99.134
machine_aws[8]=18.232.117.113

time=100	#how long to run the experiments for
# time_between=118
keyName="AWStests.pem"

# from aws to google
i=6
while [ $i -lt 9 ]; do
	ssh -i ${keyLocation[i]}$keyName ubuntu@${machine_aws[i]} "pkill iperf"
	sleep 3s
	ssh -i ${keyLocation[i]}$keyName ubuntu@${machine_aws[i]} "iperf3 -s"& # run concurrently
	j=0
	while [ $j -lt 9 ]; do
		echo ${keyLocation[i]}$keyName ubuntu@${machine_aws[i]}

		sleep 3s
		if [ $j -lt 9 ]
		then
			echo $keyGoogle$keyName ubuntu@${machine_google[j]}
			ssh -i $keyGoogle$keyName ubuntu@${machine_google[j]} "iperf3 -c ${machine_aws[i]} -i 1 -t $time > combined_bandwidth_aws_${nameAws[i]}_${name[j]}.txt"&
			ssh -i $keyGoogle$keyName ubuntu@${machine_google[j]} "ping -w $time ${machine_aws[i]} > combined_latency_aws_${nameAws[i]}_${name[j]}.txt"
			sleep 10s
			j=$[$j+1]
		fi
	done
	ssh -i ${keyLocation[i]}$keyName ubuntu@${machine_aws[i]} "pkill iperf"
echo $i
i=$[$i+1]
done



