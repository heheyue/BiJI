#!/bin/bash
for line in `cat ./test.txt`
do
    router=''
    msg=''
    router=`echo "$line" | awk -F@ '{print $1}'` 
    msg=`echo "$line" | awk -F@ '{print $2}'` 
    num=`echo "$line" | awk -F@ '{print $3}'` 
    echo "$router"
    echo "$msg"
    cmd="curl \"http://gw.op.igetcool.com/apisix/admin/routes\" -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X POST -d'{\"hosts\": [\"igetcool-gateway.igetcool.com\"],\"uris\": [ \"$router\" ],\"plugins\":{\"prometheus\": {},\"limit-count\":{\"time_window\":1,\"count\":$num,\"rejected_code\":429,\"key\":\"server_addr\",\"policy\":\"local\"}},\"desc\":\"$msg\",\"upstream_id\":\"00000000000000000024\"}'"
    echo $cmd
    eval $cmd
done
