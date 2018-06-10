# Input Janus roomId (unsigned int64)
# Convert all recoreded stream in that room to video (support .webm now)

echo 'PROCESSING RECORDED JANUS VIDEO-ROOM'
if [ "$#" -le 0 ]; then
	echo 'Need input Janus roomId'
	exit 1
fi
roomId=$1
echo 'RoomId = ' $roomId

outputDir='./'
if [ "$#" -ge 2 ]; then
	outputDir=$2
fi

recordingPath='/opt/janus/share/janus/recordings' #Vultr CentOS server
janusProcessor='/opt/janus/bin/janus-pp-rec'

prefix=videoroom-$roomId-user-
postfix=.mjr
postfixAudio=-audio$postfix
postfixVideo=-video$postfix

cd $recordingPath
files=($(ls $prefix*$postfix)) #Note about the syntax ($()), I had a hard time to figure out it

numFile=${#files[@]}
echo 'Num all files: ' $numFile

audioFiles=($(ls $prefix*$postfixAudio))
videoFiles=($(ls $prefix*$postfixVideo))
numAudio=${#audioFiles[@]}
numVideo=${#videoFiles[@]}
echo 'Num Audios: ' $numAudio
echo 'Num Videos: ' $numVideo

for ((i = 0; i < $numAudio; i++))
do
	audioFileMJR=${audioFiles[i]}
	videoFileMJR=${videoFiles[i]}
	audioFileOPUS=$audioFileMJR.opus
	videoFileWEBM=$videoFileMJR.webm
	finalVideo=${outputDir}${roomId}_${i}.webm

	echo 'i = ' $i
	echo $audioFileMJR ' -> ' $audioFileOPUS
	echo $videoFileMJR ' -> ' $videoFileWEBM
	echo $audioFileOPUS ' + ' $videoFileWEBM ' -> ' $finalVideo

	$janusProcessor $audioFileMJR $audioFileOPUS
	$janusProcessor $videoFileMJR $videoFileWEBM
	ffmpeg -i $audioFileOPUS -i $videoFileWEBM -c:v copy -c:a copy $finalVideo -y
done
echo "PROCESSING VIDEO COMPLETED"
