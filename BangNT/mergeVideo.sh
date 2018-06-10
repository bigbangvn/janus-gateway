#https://unix.stackexchange.com/questions/233832/merge-two-video-clips-into-one-placing-them-next-to-each-other

if [ "$#" -le 2 ]; then
	echo 'Need input 2 videos and output'
	exit 1
fi
leftVideo=$1
rightVideo=$2
output=$3

temp=temp_$output

echo 'Merge videos to 1 file'
ffmpeg -i $leftVideo -i $rightVideo -filter_complex \
"[0:v][1:v]hstack=inputs=2[v]; \
 [0:a][1:a]amerge[a]" \
-map "[v]" -map "[a]" -ac 2 $temp

echo 'Rotate video 90 clockwise'
ffmpeg -i $temp -vf "transpose=1" $output