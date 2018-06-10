
if [ "$#" -le 0 ]; then
	echo 'Need at least 1 argument'
	exit 1
fi

roomId=$1

outputDir='./'
if [ "$#" -ge 2 ]; then
	outputDir=$2
fi

echo 'roomId: ' $roomId
echo 'outputDir: ' $outputDir

a=($(ls *.mjr))
echo ${#a[@]}
echo ${a[1]}