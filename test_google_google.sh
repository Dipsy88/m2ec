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


time=100	#how long to run the experiments for
# time_between=118
keyName="AWStests.pem"


i=0
#
sleep 2s
while [ $i -lt 9 ]; do
	ssh -i $keyGoogle$keyName ubuntu@${machine_google[i]} "pkill iperf"
	sleep 3s
	ssh -i $keyGoogle$keyName ubuntu@${machine_google[i]} "iperf3 -s"& # run concurrently
	
	j=0
	while [ $j -lt 9 ]; do
		echo $keyGoogle$keyName ubuntu@${machine_aws[i]}

		sleep 3s
		if [ $j -eq $i ]
		then
			j=$[$j+1]
		fi
		if [ $j -lt 9 ]
		then
			echo $keyGoogle$keyName ubuntu@${machine_google[j]}
			ssh -i $keyGoogle$keyName ubuntu@${machine_google[j]} "iperf3 -c ${machine_google[i]} -i 1 -t $time > combined_bandwidth_google_${name[i]}_${name[j]}.txt"&
			ssh -i $keyGoogle$keyName ubuntu@${machine_google[j]} "ping -w $time ${machine_google[i]} > combined_latency_google_${name[i]}_${name[j]}.txt"
			sleep 10s
			j=$[$j+1]
		fi
	done
	ssh -i $keyGoogle$keyName ubuntu@${machine_google[i]} "pkill iperf"
echo $i
i=$[$i+1]
done



