echo 'BangNT - convert recored RTP stream to video file'
if [ "$#" -ne 1 ]; then
	echo 'You need input base file name (not include the part "-video.mjr")'
	exit 1
fi

videoName=$1-video
audioName=$1-audio
inputVideo=$videoName.mjr
inputAudio=$audioName.mjr

echo 'input: ' $inputVideo ' ' $inputAudio
/opt/janus/bin/janus-pp-rec $inputVideo $videoName.webm
/opt/janus/bin/janus-pp-rec $inputAudio $audioName.opus

finalOutput=$videoName-merged.webm
ffmpeg -i $videoName.webm -i $audioName.opus -c:v copy -c:a copy $finalOutput -y
echo 'Convert successfully to: ' $finalOutput