#!/usr/bin/env bash
#
# googl.sh
# a url shortener using goo.gl service
# return short url
# ./googl.sh http://mweldan.com
####################################

url="$1"
api="https://www.googleapis.com/urlshortener/v1/url"
curl=$(which curl)

printhelp() {
	# print help text
	echo "===========================================";
	echo "googl.sh - A googl url shortener cli script";  
	echo "[ Weldan Jamili <mweldan@gmail.com> ]";
	echo "-------------------------------------------";
	echo "Usage: ./googl.sh http://mweldan.com";
	echo "===========================================";
	exit
}

process() {
	result=`$curl -s $api \
	-H 'Content-Type: application/json' \
	-d '{"longUrl": "'$url'"}'`
	echo "===========================================";
	echo "Short URL:";
	echo cat $result \
	|grep -Po '"id":.*?[^\\]",' \
	|sed 's/"id"://' \
	|sed 's|[\",]||g'
	echo "===========================================";
	exit
}

check_curl_installed() {
	# check if curl is not installed
	if [ ! -f $curl ];
	then
		echo "curl is required!"
		exit
	fi
}

if [ $# -eq 0 ];
then
	printhelp
else
	check_curl_installed
	process
fi
