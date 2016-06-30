# compliments of http://osxdaily.com/2013/07/31/speed-test-command-line/

while true
do
  curl -o /dev/null -s -w ',%{speed_download}' http://speedtest.wdc01.softlayer.com/downloads/test10.zip | ts >> speedtest.csv
  # add \n at end of line
  sed -i -e '$a\' speedtest.csv
  sleep 60
done


