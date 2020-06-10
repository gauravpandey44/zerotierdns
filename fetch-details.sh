#!/bin/sh

while [ 1 ] # infine loop with a sleep 
do

        #Script to fetch zerotier details using zerotier api

        API_KEY=`grep API_KEY ./.config  | cut -d "=" -f2`
        conf_file='/etc/dnsmasq.d/zero.conf'
        REFRESH=`grep REFRESH ./.config  | cut -d "=" -f2`
$REFRESH
        echo "log-queries" > $conf_file
        echo "no-resolv" >> $conf_file


        for nid in `grep NETWORK_IDs ./.config  | cut -d "=" -f2`  #this loop will feth the details for all network ids defined
        do
            echo  "Running for $nid------------------------------------- \n\n"
            curl -X GET -H "Content-Type: application/json" -H "Authorization: bearer ${API_KEY}" "https://my.zerotier.com/api/network/${nid}/member" > /tmp/fetch-details.tmp

            cat /tmp/fetch-details.tmp | grep -oE 'name":"[^,]*"' | cut -d '"' -f3 >/tmp/fetch-details1.tmp

        cat /tmp/fetch-details.tmp | grep -oE 'ipAssignments":\["[0-9.",]+]' | cut -d '[' -f2 | cut -d ']' -f1 | sed 's/\"//g' > /tmp/fetch-details2.tmp

            paste -d "/" /tmp/fetch-details1.tmp /tmp/fetch-details2.tmp > /tmp/fetch-details3.tmp

            for each in `cat  /tmp/fetch-details3.tmp`
            do 

                name=`echo $each | cut -d "/" -f1`

                ips=`echo $each | cut -d "/" -f2`


                for ip in `echo $ips | sed 's/,/ /g'`
                do

                   echo  address=/$name.zt/$ip  | tee -a  $conf_file

                done 



            done


        done
        
         echo "server=213.136.95.10" >> $conf_file
         echo "server=213.136.95.11" >> $conf_file
        if [ `ps eux | grep dnsmasq | grep -v grep |wc -l` -lt 1 ]
        then
            dnsmasq
        fi
        sleep $REFRESH
        
       
done