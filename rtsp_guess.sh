#!/bin/bash
base=`curl -s http://127.0.0.1:18810/jobs | jq -r ".[]|.stream_url"|sed "s%rtsp://%%"|cut -d ":" -f1,2|cut -d "." -f1,2,3,4|cut -d "/" -f1`
echo $base
ffmpeg -y -i "rtsp://$base" -vframes 1 -q:v 2 sample_frame1.jpg
ffmpeg -y -i "rtsp://$base/live/main" -vframes 1 -q:v 2 sample_frame2.jpg
ffmpeg -y -i "rtsp://$base/h264" -vframes 1 -q:v 2 sample_frame3.jpg
ffmpeg -y -i "rtsp://$base/H264?ch=1&subtype=0" -vframes 1 -q:v 2 sample_frame4.jpg
ffmpeg -y -i "rtsp://$base/ISAPI/Streaming/Channels/101" -vframes 1 -q:v 2 sample_frame5.jpg
ffmpeg -y -i "rtsp://$base/cam/realmonitor?channel=1&subtype=0" -vframes 1 -q:v 2 sample_frame6.jpg
ffmpeg -y -i "rtsp://$base/ch01/0" -vframes 1 -q:v 2 sample_frame7.jpg
ffmpeg -y -i "rtsp://$base/stream1" -vframes 1 -q:v 2 sample_frame8.jpg
ffmpeg -y -i "rtsp://$base/Streaming/Channels/1" -vframes 1 -q:v 2 sample_frame9.jpg
ffmpeg -y -i "rtsp://$base/h264Preview_01_main" -vframes 1 -q:v 2 sample_frame10.jpg
ffmpeg -y -i "rtsp://$base/av0_0" -vframes 1 -q:v 2 sample_frame11.jpg

(rtsp=`ls -1|grep sample_frame|tail -n1`
case "$rtsp" in
    sample_frame1.jpg ) echo "rtsp://$base";;
    sample_frame2.jpg ) echo "rtsp://$base/live/main";;
    sample_frame3.jpg ) echo "rtsp://$base/h264";;
    sample_frame4.jpg ) echo "rtsp://$base/H264?ch=1&subtype=0";;
    sample_frame5.jpg ) echo "rtsp://$base/ISAPI/Streaming/Channels/101";;
    sample_frame6.jpg ) echo "rtsp://$base/cam/realmonitor?channel=1&subtype=/H264?ch=1&subtype=0";;
    sample_frame7.jpg ) echo "rtsp://$base/ch01/0";;
    sample_frame8.jpg ) echo "rtsp://$base/stream1";;
    sample_frame9.jpg ) echo "rtsp://$base/Streaming/Channels/1";;
    sample_frame10.jpg ) echo "rtsp://$base/h264Preview_01_main";;
    sample_frame11.jpg ) echo "rtsp://$base/av0_0";;
esac)
