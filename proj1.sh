#!/bin/bash

#functions

run () {
	i=1
	while [ $i -lt 7 ]
	do
		chmod 755 APM$i
		./APM$i $1 &
		((i++))
	done
	ifstat -d 1
}

cpumem () {
	i=1
	while [ $i -lt 7 ]
	do
		ps -C APM$i -o %cpu,%mem | sed 's/  /,/g' | tail -1 | echo $SECONDS,$(cut -f 1,2 -d ',') >> "APM$i"_metric.csv
		((i++))
	done
}

net () {
	ifstat ens33  | tail -n -2 | head -1 | tr -s ' ' | cut -f 7,9 -d ' ' | sed 's/K//g' | echo $SECONDS,$(sed 's/ /,/g') >> network_stats.txt
}

hdd () {
	iostat sda | tail -n -2 | head -1 | tr -s ' ' | cut -f 5 -d ' ' >> temp.txt
	df -h -m / | tail -n -1 | tr -s ' ' | cut -f 4 -d ' ' >> temp.txt
}

cleanup () {
	i=1
	while [ $i -lt 7 ]
	do
		killall APM$i
		((i++))
	done
	killall ifstat
}
trap cleanup EXIT

run $1

while [ true ]
do
		
	sleep 5
done

