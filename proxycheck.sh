#token
token=`grep -a unlift_token /etc/unlift.ini|sed 's/ //g' |cut -d "=" -f2`
#updater_token
u_token=`grep -a unlifttoken /etc/unlift-updater.ini|sed 's/ //g' |cut -d "=" -f2`
#shard
shard=`sudo grep -a master /etc/findface-sf-api.ini |head -n1|cut -d ":" -f3,4|cut -d "/" -f3`
ip_s=`echo $shard|cut -d ":" -f1`
port_s=`echo $shard|cut -d ":" -f2`
shard_check=`nc -z -w1 $ip_s $port_s&&echo true||echo false`
#sound_count
sound_count=`sudo grep -a -c SOUND /var/log/syslog`
sound_count_executed=`sudo grep -a -c 'SOUND PLAYING: EXECUTED' /var/log/syslog`
sound_count_started=`sudo grep -a -c 'SOUND PLAYING: STARTED' /var/log/syslog`
sound_count_skipped=`sudo grep -a -c 'SOUND PLAYING: SKIPPED' /var/log/syslog`
sound_count_disabled=`sudo grep -a -c 'SOUND PLAYING: DISABLED' /var/log/syslog`
sound_count_sent=`sudo grep -a -c 'SOUND PLAYING: SENT' /var/log/syslog`
SOUND_PLAYING_UTC_TIME_LAST=`zgrep -a -o "SOUND PLAYING: utcnow=.*" /var/log/syslog*|cut -d "=" -f2|sort|tail -n1`
sound_master=`sudo amixer sget Master|grep -a "\%"|cut -d "[" -f4|sed 's/\]//'|head -n1`
sound_headphone=`sudo amixer sget Headphone|grep -a "\%"|cut -d "[" -f4|sed 's/\]//'|head -n1`
sound_level_headphone=`sudo amixer sget Headphone|grep -a "\%"|cut -d "[" -f2|sed 's/\]//'|head -n1`
sound_line=`sudo amixer sget Line|grep -a "\%"|cut -d "[" -f4|sed 's/\]//'|head -n1`
sound_level_line=`sudo amixer sget Line|grep -a "\%"|cut -d "[" -f2|sed 's/\]//'|head -n1`
sound_error_counter=`sudo grep -a -c 'Playing sound error: HTTP 599: Timeout while connecting' /var/log/syslog`

#error_count
error_count=`sudo grep -a -c ERROR /var/log/syslog`
#service_status
#service_status_old=`systemctl --no-pager status findface-*>/dev/null && systemctl --no-pager status unlift*>/dev/null && systemctl --no-pager status etcd>/dev/null&&echo true||echo false`
service_status=`systemctl is-active --quiet findface-extraction-api.service && systemctl is-active --quiet findface-video-manager.service && systemctl is-active --quiet findface-sf-api.service && systemctl is-active --quiet findface-facerouter.service && systemctl is-active --quiet unlift && systemctl is-active --quiet unlift-updater && systemctl is-active --quiet etcd && systemctl is-active --quiet memcached &&echo true||echo false`
service_status_findface_extraction_api=`systemctl is-active --quiet findface-extraction-api.service && echo true||echo false`
service_status_findface_video_worker_cpu=`systemctl is-active --quiet findface-video-worker-cpu.service && echo true||echo false`
service_status_findface_video_worker_gpu=`systemctl is-active --quiet findface-video-worker-gpu.service && echo true||echo false`
service_status_findface_video_manager=`systemctl is-active --quiet findface-video-manager.service && echo true||echo false`
service_status_findface_sf_api=`systemctl is-active --quiet findface-sf-api.service && echo true||echo false`
service_status_findface_facerouter=`systemctl is-active --quiet findface-facerouter.service && echo true||echo false`
service_status_unlift=`systemctl is-active --quiet unlift.service && echo true||echo false`
service_status_unlift_updater=`systemctl is-active --quiet unlift-updater.service && echo true||echo false`
service_status_etcd=`systemctl is-active --quiet etcd.service && echo true||echo false`
service_status_memcached=`systemctl is-active --quiet memcached.service && echo true||echo false`




#counter_status
counter_status=`systemctl --no-pager status findface-counter>/dev/null && systemctl --no-pager status postgre*>/dev/null &&echo true||echo false`
#ssh status
ssh_status=`systemctl is-active --quiet ssh &&echo true||echo false`
#bit-radio
bit_alert_status=`systemctl is-active --quiet bit-alert &&echo true||echo false`
bit_radio_status=`systemctl is-active --quiet bit-radio &&echo true||echo false`

#md5
md5_extraction_api=`sudo md5sum /etc/findface-extraction-api.ini|cut -f 1 -d " "`
md5_findface_facerouter=`sudo md5sum /etc/findface-facerouter.py|cut -f 1 -d " "`
md5_findface_ntls=`sudo md5sum /etc/findface-ntls.cfg|cut -f 1 -d " "`
md5_findface_sf_api=`sudo md5sum /etc/findface-sf-api.ini|cut -f 1 -d " "`
md5_findface_video_manager=`sudo md5sum /etc/findface-video-manager.conf|cut -f 1 -d " "`
md5_findface_video_worker_cpu=`sudo md5sum /etc/findface-video-worker-cpu.ini|cut -f 1 -d " "`
md5_findface_video_worker_gpu=`sudo md5sum /etc/findface-video-worker-gpu.ini|cut -f 1 -d " "`
md5_cron=`sudo md5sum /var/spool/cron/crontabs/root|cut -f 1 -d " "`
md5_warningm=`sudo md5sum /opt/unlift/unlift_proxy/warning.mp3|cut -f 1 -d " "`
md5_warningf=`sudo md5sum /opt/unlift/unlift_proxy/warningf.mp3|cut -f 1 -d " "`
md5_notice=`sudo md5sum /opt/unlift/unlift_proxy/notice.mp3|cut -f 1 -d " "`
md5_hosts=`sudo md5sum /etc/hosts|cut -f 1 -d " "`

#mac
mac=`ip a|grep -a -o "link/ether.*"|cut -d " " -f2|head -n1`
#local_ip_address
local_ip_address_full=`ip -br a show|grep UP|head -n1|column -t| sed "s/  / /g"|cut -d " " -f3`
local_ip_address=`echo $local_ip_address_full|cut -d "/" -f1`
local_network_mask=`echo $local_ip_address_full|cut -d "/" -f2`
local_gateway=`ip r|grep default|cut -d " " -f3
`
#unlift
dead_unlift=`grep -a "unlift is dead" /var/log/syslog|grep -a -v CRON|grep -a -c .`
stuck_unlift=`grep -a "unlift is stuck" /var/log/syslog|grep -a -v CRON|grep -a -c .`
storage_error=`grep -a -c "STORAGE_ERROR: ERROR_COMMUNICATION" /var/log/syslog`
sqlite_error=`grep -a -c "sqlite3.OperationalError: database is locked" /var/log/syslog`
extraction_error=`grep -a -c "EXTRACTION_ERROR" /var/log/syslog`
license_cache_error=`grep -a -c "LICENSE_ERROR: license error: Cached license expired" /var/log/syslog`
failed_job_already_exists_count=`grep -a -c "failed: job with id.*already exists" /var/log/syslog`
dmesg_error_count=`dmesg |grep -c error`
if [ "$dmesg_error_count" == "1" ]; then
  dmesg_error_count=0
fi
dmesg_acpi_error_count=`dmesg |grep -c "ACPI Error"`
dmesg_out_of_memory_error_count=`dmesg |grep -c "Out of memory"`
face_upload_error_counter=`grep -a -c "FACE UPLOAD ERROR" /var/log/syslog`


#timestamp
utime=`date +%s`
#unlift_timezone
unlift_timezone=`date +%:::z|sed -e 's/+0//' -e 's/+//'`
#dns_status
dns_status=`nslookup ya.ru>/dev/null&&echo true||echo false`
dns_query_time=`dig ya.ru|grep -ao "Query time: .*"|cut -d " " -f3`
h502=`grep -a -c "HTTPError: HTTP 502: Bad Gateway" /var/log/syslog`
cputt=`grep -a -c "Package temperature above threshold" /var/log/syslog`
#kernel
kernel=`uname -r`
#findface_version
findface_version=`dpkg -l|grep -a findface-video-worker|head -n1|column -t|cut -d " " -f5`
#network speed
link_speed=`cat /sys/class/net/*e*/speed|head -n1`
link_down_counter=`zgrep -a "Link is Down" /var/log/kern.log*|grep -c .`
local_time=`echo $(date +%c)`
local_time_unix=`echo $(date +%s)`

#visit
visit=`grep "sending register visitFace finished" /var/log/syslog|grep -o "python3.*"|sed 's/ /;/g'|tail -n1|sed 's/:;/;/g'`
last_visit_send_time=`echo $visit|cut -d ";" -f2,3|sed 's/;/ /'`
last_visit_face_id=`echo $visit|cut -d ";" -f11|cut -d '=' -f2`
last_visit_confidence=`echo $visit|cut -d ";" -f12|cut -d '=' -f2`
last_visit_processing_time=`echo $visit|cut -d ";" -f10`

#readonly
time_r=`echo $(date +%s)`
>/tmp/$time_r
readonly_file_system_status=`ls /tmp/$time_r|grep -q $time_r&&echo false||echo true`
rm /tmp/$time_r

#params
hostname=`cat /etc/hostname`
config_param_extraction_quality=`sudo grep -ao "quality:.*" /etc/findface-extraction-api.ini|grep face|tr -s '\n\r' ' '`
config_param_video_worker_cpu_batch_size=`grep -a batch_size /etc/findface-video-worker-cpu.ini|tr -s '\n\r' ' '`
config_param_video_worker_cpu_skip_count=`grep -a skip_count /etc/findface-video-worker-cpu.ini|tr -s '\n\r' ' '|sed 's/ //g' `
config_param_video_worker_cpu_overlap_threshold=`grep -a overlap_threshold /etc/findface-video-worker-cpu.ini|tr -s '\n\r' ' '`
config_param_video_worker_gpu_batch_size=`grep -a batch_size /etc/findface-video-worker-gpu.ini|tr -s '\n\r' ' '`
config_param_video_worker_gpu_skip_count=`grep -a skip_count /etc/findface-video-worker-gpu.ini|tr -s '\n\r' ' '`
config_param_video_worker_gpu_overlap_threshold=`grep -a overlap_threshold /etc/findface-video-worker-gpu.ini|tr -s '\n\r' ' '`
service_unlift_installer_active_timeout=`systemctl is-active --quiet unlift-installer.service && grep "while not stopped.wait" /opt/unlift/unlift_install/installer.py |cut -d "(" -f2|cut -d ")" -f1||echo 0`
findface_facen_version=`grep -oE "face: face.*|face_emben:.*" /etc/findface-extraction-api.ini|tr -s '\n\r' ' '`


#hardware
hardware_disk=`udisksctl  status|grep -v MODEL|grep -v "\-\-"|column -t|awk '{print $1,$2}'|head -n1`
hardware_cpu=`cat /proc/cpuinfo |grep "model name"|tail -n1|cut -d ":" -f2`
hardware_memory=`sudo lshw -c memory| grep -A 8 "bank:" | grep -o "product.*"|cut -d ":" -f2|tr -s "\n" ","|sed 's/,$//'`
hardware_mb=`sudo lshw|grep -A2 Mother|grep -o "product.*"|cut -d ":" -f2`
hardware_summ=`echo "\"$hardware_mb,$hardware_cpu,$hardware_disk,$hardware_memory\""`
turbo_boost=`grep flags /proc/cpuinfo | grep -q " ida " && echo true || echo false`

#gpu
gpu_error_current=`grep -ac "nvidia-modeset: ERROR: GPU" /var/log/kern.log`
gpu_error_all=`zgrep -a "nvidia-modeset: ERROR: GPU" /var/log/kern.log*|grep -c .`
gpu_model=`nvidia-smi -q|grep -o "Product Name.*"|cut -d ":" -f2|sed 's/^ //'`
gpu_arr=($(nvidia-smi -q|grep -E "FB Memory Usage|Utilization|Temperature$|Power Readings" -A3|grep :|cut -d ":" -f2|sed 's/ //g'))
gpu_memory=`echo ${gpu_arr[0]}`
gpu_memory_used=`echo ${gpu_arr[2]}`
gpu_load=`echo ${gpu_arr[3]}`
gpu_temp=`echo ${gpu_arr[6]}`
gpu_temp_max=`echo ${gpu_arr[7]}`
gpu_power=`echo ${gpu_arr[10]}`
gpu_power_max=`echo ${gpu_arr[11]}`


#dns
local_dns_server1=`systemd-resolve --status --no-pager | grep "DNS Servers" -A 1|sed 's/DNS Servers://'|column -t|grep -v Domain|head -n1`
local_dns_server2=`systemd-resolve --status --no-pager | grep "DNS Servers" -A 1|sed 's/DNS Servers://'|column -t|grep -v Domain|tail -n1`

#reboot counter
reboot_counter=`last|grep -c reboot`

#result
echo "unlift_token;varchar;$token">resultcheck
echo "unlift_token_updater;varchar;$u_token">>resultcheck

echo "shardcheck_status;boolean;$shard_check">>resultcheck
echo "sound_counter;NUMBER;$sound_count">>resultcheck
echo "sound_counter_started;NUMBER;$sound_count_started">>resultcheck
echo "sound_counter_executed;NUMBER;$sound_count_executed">>resultcheck
echo "sound_counter_skipped;NUMBER;$sound_count_skipped">>resultcheck
echo "sound_counter_disabled;NUMBER;$sound_count_disabled">>resultcheck
echo "sound_counter_sent;NUMBER;$sound_count_sent">>resultcheck
echo "SOUND_PLAYING_UTC_TIME_LAST;varchar;$SOUND_PLAYING_UTC_TIME_LAST">>resultcheck
echo "sound_master;varchar;$sound_master">>resultcheck
echo "sound_headphone;varchar;$sound_headphone">>resultcheck
echo "sound_level_headphone;varchar;$sound_level_headphone">>resultcheck
echo "sound_line;varchar;$sound_line">>resultcheck
echo "sound_level_line;varchar;$sound_level_line">>resultcheck
echo "hostname;varchar;$hostname">>resultcheck
echo "sound_error_counter;NUMBER;$sound_error_counter">>resultcheck


echo "config_param_extraction_quality;varchar;$config_param_extraction_quality">>resultcheck
echo "config_param_video_worker_cpu_batch_size;varchar;$config_param_video_worker_cpu_batch_size">>resultcheck
echo "config_param_video_worker_cpu_skip_count;varchar;$config_param_video_worker_cpu_skip_count">>resultcheck
echo "config_param_video_worker_cpu_overlap_threshold;varchar;$config_param_video_worker_cpu_overlap_threshold">>resultcheck
echo "config_param_video_worker_gpu_batch_size;varchar;$config_param_video_worker_gpu_batch_size">>resultcheck
echo "config_param_video_worker_gpu_skip_count;varchar;$config_param_video_worker_gpu_skip_count">>resultcheck
echo "config_param_video_worker_gpu_overlap_threshold;varchar;$config_param_video_worker_gpu_overlap_threshold">>resultcheck
echo "service_unlift_installer_active_timeout;NUMBER;$service_unlift_installer_active_timeout">>resultcheck
echo "findface_facen_version;varchar;$findface_facen_version">>resultcheck


echo "error_counter;NUMBER;$error_count">>resultcheck
echo "service_status;boolean;$service_status">>resultcheck
echo "service_status_etcd;boolean;$service_status_etcd">>resultcheck
echo "service_status_findface-extraction-api;boolean;$service_status_findface_extraction_api">>resultcheck
echo "service_status_findface-facerouter;boolean;$service_status_findface_facerouter">>resultcheck
echo "service_status_findface-sf-api;boolean;$service_status_findface_sf_api">>resultcheck
echo "service_status_findface-video-manager;boolean;$service_status_findface_video_manager">>resultcheck
echo "service_status_findface-video-worker-cpu;boolean;$service_status_findface_video_worker_cpu">>resultcheck
echo "service_status_findface-video-worker-gpu;boolean;$service_status_findface_video_worker_gpu">>resultcheck
echo "service_status_memcached;boolean;$service_status_memcached">>resultcheck
echo "service_status_unlift;boolean;$service_status_unlift">>resultcheck
echo "service_status_unlift-updater;boolean;$service_status_unlift_updater">>resultcheck
echo "readonly_file_system_status;boolean;$readonly_file_system_status">>resultcheck
echo "dmesg_error_count;NUMBER;$dmesg_error_count">>resultcheck
echo "dmesg_acpi_error_count;NUMBER;$dmesg_acpi_error_count">>resultcheck
echo "dmesg_out_of_memory_error_count;NUMBER;$dmesg_out_of_memory_error_count">>resultcheck
echo "face_upload_error_counter;NUMBER;$face_upload_error_counter">>resultcheck


echo "unlift_counter_status;boolean;$counter_status">>resultcheck
echo "md5_extraction_api;varchar;$md5_extraction_api">>resultcheck
echo "md5_findface_facerouter;varchar;$md5_findface_facerouter">>resultcheck
echo "md5_findface_ntls;varchar;$md5_findface_ntls">>resultcheck
echo "md5_findface_sf_api;varchar;$md5_findface_sf_api">>resultcheck
echo "md5_findface_video_manager;varchar;$md5_findface_video_manager">>resultcheck
echo "md5_findface_video_worker_cpu;varchar;$md5_findface_video_worker_cpu">>resultcheck
echo "md5_findface_video_worker_gpu;varchar;$md5_findface_video_worker_gpu">>resultcheck
echo "md5_cron;varchar;$md5_cron">>resultcheck
echo "md5_warningm;varchar;$md5_warningm">>resultcheck
echo "md5_warningf;varchar;$md5_warningf">>resultcheck
echo "md5_notice;varchar;$md5_notice">>resultcheck
echo "md5_hosts;varchar;$md5_hosts">>resultcheck

echo "ssh_status;boolean;$ssh_status">>resultcheck
echo "bit_alert_status;boolean;$bit_alert_status">>resultcheck
echo "bit_radio_status;boolean;$bit_radio_status">>resultcheck

echo "mac_address;varchar;$mac">>resultcheck
echo "local_ip_address;varchar;$local_ip_address">>resultcheck
echo "local_network_mask;varchar;$local_network_mask">>resultcheck
echo "local_gateway;varchar;$local_gateway">>resultcheck

echo "kernel;varchar;$kernel">>resultcheck
echo "findface_version;varchar;$findface_version">>resultcheck


echo "time;timestamp;$utime">>resultcheck
echo "unlift_reset_counter;NUMBER;$dead_unlift">>resultcheck
echo "unlift_restart_counter;NUMBER;$stuck_unlift">>resultcheck
echo "dns_status;boolean;$dns_status">>resultcheck
echo "dns_query_time;NUMBER;$dns_query_time">>resultcheck
echo "storage_error_counter;NUMBER;$storage_error">>resultcheck
echo "sqlite_error_counter;NUMBER;$sqlite_error">>resultcheck
echo "extraction_error_counter;NUMBER;$extraction_error">>resultcheck
echo "license_cache_error_counter;NUMBER;$license_cache_error">>resultcheck
echo "failed_job_already_exists_count;NUMBER;$failed_job_already_exists_count">>resultcheck


echo "http_502_counter;NUMBER;$h502">>resultcheck
echo "cpu_throttling_counter;NUMBER;$cputt">>resultcheck

echo "last_visit_send_time;varchar;$last_visit_send_time">>resultcheck
echo "last_visit_face_id;varchar;$last_visit_face_id">>resultcheck
echo "last_visit_confidence;varchar;$last_visit_confidence">>resultcheck
echo "last_visit_processing_time;NUMBER;$last_visit_processing_time">>resultcheck
echo "unlift_timezone;NUMBER;$unlift_timezone">>resultcheck
echo "hardware_summ;varchar;$hardware_summ">>resultcheck
echo "hardware_cpu;varchar;$hardware_cpu">>resultcheck
echo "hardware_disk;varchar;$hardware_disk">>resultcheck
echo "hardware_memory;varchar;$hardware_memory">>resultcheck
echo "hardware_mb;varchar;$hardware_mb">>resultcheck

echo "link_speed;varchar;$link_speed">>resultcheck
echo "link_down_error_counter;NUMBER;$link_down_counter">>resultcheck
echo "gpu_error_counter;NUMBER;$gpu_error_current">>resultcheck
echo "gpu_error_counter_all;NUMBER;$gpu_error_all">>resultcheck
echo "local_dns_server1;varchar;$local_dns_server1">>resultcheck
echo "local_dns_server2;varchar;$local_dns_server2">>resultcheck
echo "gpu_model;varchar;$gpu_model">>resultcheck
echo "gpu_memory;varchar;$gpu_memory">>resultcheck
echo "gpu_memory_used;varchar;$gpu_memory_used">>resultcheck
echo "gpu_load;varchar;$gpu_load">>resultcheck
echo "gpu_temp;varchar;$gpu_temp">>resultcheck
echo "gpu_temp_max;varchar;$gpu_temp_max">>resultcheck
echo "gpu_power;varchar;$gpu_power">>resultcheck
echo "gpu_power_max;varchar;$gpu_power_max">>resultcheck
echo "local_time;varchar;$local_time">>resultcheck
echo "local_time_unix;varchar;$local_time_unix">>resultcheck
echo "cpu_turbo_boost;boolean;$turbo_boost">>resultcheck
echo "reboot_counter;NUMBER;$reboot_counter">>resultcheck



#version 
version=1.58
echo "proxy_check_version;varchar;$version">>resultcheck
