# Version:
# Janus version: 30 (0.3.1)
# Janus commit: 6b0787c4e8551a5a7bfd78f694074f5d647f8395
# Compiled on:  Sat May 12 06:40:03 UTC 2018
# ffmpeg version 2.6.8 Copyright (c) 2000-2016 the FFmpeg developers
#  built with gcc 4.8.5 (GCC) 20150623 (Red Hat 4.8.5-4)

#Input: base file name (the common part of video and audio files)

echo 'BangNT - convert recored RTP stream to video file'
if [ "$#" -ne 1 ]; then
	echo 'You need input base file name (not include the part "-video.mjr")'
	exit 1
fi

janusProcessor='/opt/janus/bin/janus-pp-rec'
videoName=$1-video
audioName=$1-audio
inputVideo=$videoName.mjr
inputAudio=$audioName.mjr

echo 'input: ' $inputVideo ' ' $inputAudio
$janusProcessor $inputVideo $videoName.webm
$janusProcessor $inputAudio $audioName.opus

finalOutput=$videoName-merged.webm
ffmpeg -i $videoName.webm -i $audioName.opus -c:v copy -c:a copy $finalOutput -y
echo 'Convert successfully to: ' $finalOutput