#/bin/bash
#日期格式当前日期-1天
yesterday=`date -d "$v_date -1 day" +%Y%m%d`
#日志压缩后保存的位置
savepath_log='./opt/data/nginx/backup'
#日志来源目录
nglogs='./opt/data/logs'
if [ ! -d ${savepath_log}/${yesterday} ]
then
    mkdir -p ${savepath_log}/${yesterday}
fi
for line in `ls $nglogs`
do
    mv ${nglogs}/${line} ${savepath_log}/${yesterday}/${line}_${yesterday}
    if test -d ${savepath_log}/${yesterday}/${line}_${yesterday};then
        zip -rmj ${savepath_log}/${yesterday}/${line}_${yesterday}.zip ${savepath_log}/${yesterday}/${line}_${yesterday}
        rm -rf ${savepath_log}/${yesterday}/${line}_${yesterday}
    else
        zip -rmj ${savepath_log}/${yesterday}/${line}_${yesterday}.zip ${savepath_log}/${yesterday}/${line}_${yesterday}
    fi
done
#通知nginx重启
kill -USR1 $(cat /var/run/nginx.pid)
