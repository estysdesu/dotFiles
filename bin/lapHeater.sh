#!/usr/bin/env sh

warning=90
bad=120

nc='\033[0m' # no color
red='\033[0;31m'
yellow='\033[0;33m'
green='\033[0;32m'
blue='\033[0;34m'


while true
do
	# call powermetrics; grep keys; grep digits only
	out=$(sudo powermetrics -n 1 -i 1000 | grep -e 'CPU die temperature:.*' -e 'Fan:.*' | grep -o '[0-9\.]\+')

	# read -a == readarry w/ delim as space; <<< redirect sends string
	read -d' ' -a outArr <<< "$out"

	# use bash built in basic calculator for comparison of floats
	if (( $(echo "${outArr[1]} > ${bad}" | bc -l) )) ; then
		color=${red}
	elif (( $(echo "${outArr[1]} > ${warning}" | bc -l) )); then
		color=${yellow}
	else
		color=${blue}
	fi

	printf "${color}CPU temp: ${outArr[1]}*C${nc}\t\t\t${color}Fan: ${outArr[0]}rpm${nc}\r"
done
