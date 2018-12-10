#!/bin/bash
# compute bandwidth and latency between cloud providers at different locations

# location of keys
keyLocation[0]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Central/
keyLocation[1]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Frankfurt/
keyLocation[2]="/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Ireland/"
keyLocation[3]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/London/
keyLocation[4]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Mumbai/
keyLocation[5]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/NCalifornia/
keyLocation[6]="/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/NVirginia/"
keyLocation[7]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Ohio/
keyLocation[8]="/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Oregon/"
keyLocation[9]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Paris/
keyLocation[10]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/SaoPaulo/
keyLocation[11]="/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Seoul/"
keyLocation[12]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Singapore/
keyLocation[13]=/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Sydney/
keyLocation[14]="/Users/Dipesh/OneDrive/Research_Engineer/CloudServices/Amazon/AWS_tests/Tokyo/"

# ip addresses of the machines (will change)
machine[0]=35.183.204.145
machine[1]=3.121.42.114
machine[2]=34.246.171.142
machine[3]=3.8.16.233
machine[4]=13.126.84.221
machine[5]=13.52.103.221
machine[6]=52.71.254.205
machine[7]=3.16.162.61
machine[8]=52.37.24.9
machine[9]=52.47.137.100
machine[10]=18.231.71.223
machine[11]=52.79.233.162
machine[12]=13.229.232.61
machine[13]=13.239.32.126
machine[14]=52.69.75.23

time=100	#how long to run the experiments for
#time_between=118
keyName="AWStests.pem"


i=0
while [ $i -lt 15 ]; do
	ssh -i ${keyLocation[i]}$keyName ubuntu@${machine[i]} "pkill iperf"
	sleep 2s
	ssh -i ${keyLocation[i]}$keyName ubuntu@${machine[i]} "iperf3 -s"& # run concurrently
	#echo ${keyLocation[i]}$keyName ubuntu@${machine[i]}
	j=0
	while [ $j -lt 15 ]; do
		echo ${keyLocation[i]}$keyName ubuntu@${machine[i]}

		sleep 3s
		if [ $j -eq $i ]
		then
			j=$[$j+1]
		fi
		if [ $j -lt 15 ]
		then
			echo ${keyLocation[j]}$keyName ubuntu@${machine[j]}
			ssh -i ${keyLocation[j]}$keyName ubuntu@${machine[j]} "iperf3 -c ${machine[i]} -i 1 -t $time > bandwidth_$i$j.txt"&
			ssh -i ${keyLocation[j]}$keyName ubuntu@${machine[j]} "ping -w $time ${machine[i]} > latency_$i$j.txt"
			sleep 10s
			j=$[$j+1]
		fi
	done
	ssh -i ${keyLocation[i]}$keyName ubuntu@${machine[i]} "pkill iperf"
echo $i
i=$[$i+1]
done
