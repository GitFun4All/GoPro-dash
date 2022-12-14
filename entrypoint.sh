#!/bin/sh
# ----------------------------------------------------------------------------
# Version 	:	0.3
# Author	:	hotpot_sculler0p@icloud.com
# ----------------------------------------------------------------------------

epfilecount()
{
	epVFCPattern=${1:-*[mM][pP]4}
	epVFC=`ls /videos/${epVFCPattern} 2> /dev/null |wc -l`
	if [ $epVFC = 0 ]; then
		echo "0"
	else 
		echo $epVFC
	fi
}

case "${1}" in
bash)
	echo "Starting shell (bash)"
	exec "$@";;

gopro-*py)
	echo "Executing GoPro cmd"
	exec "$@";;

auto)
	echo "Checking files"
	if [ `epfilecount` -gt 1 ]; then 
		echo "Multiple video files found, joining them"
		echo "Not implemented yet... (sorry)."
		exit 1
	fi

	if [ `epfilecount` -eq 0 ]; then
		echo "No files found in the videos folder?!"
		exit 1
	fi
	
	if [ `epfilecount` -ne `epfilecount '*.[gG][pP][xX]'` ]; then
		echo "Extracting GPX data from video"
		for vfile in `ls /videos/*.[mM][pP]4 2> /dev/null`
		do
			gopro-to-gpx.py "${vfile}" /videos/$(basename $vfile .MP4).GPX
			echo "Creating video overlay"
			gopro-dashboard.py --gpx $(basename $vfile .MP4).GPX $vfile $(basename $vfile .MP4)-OV.MP4
		done
	else
		echo "Creating overlay from GPX file"
		cd /videos
		for vfile in *.[mM][pP]4
		do
			gopro-dashboard.py --gpx $(basename $vfile .MP4).GPX $vfile $(basename $vfile .MP4)-OV.MP4
		done
	fi;;
*)
	echo "Usage:"
	echo ""
 	echo "This container provides all the utilities from the GoPro-dashboard-overlay project"
  	echo "at github: https://github.com/time4tea/gopro-dashboard-overlay"
  	echo "The command line tools included are:"
  	echo ""
  	echo "gopro-contrib-data-extract.py"
	echo "gopro-cut.py"
	echo "gopro-dashboard.py"
	echo "gopro-extract.py"
	echo "gopro-join.py"
	echo "gopro-rename.py"
	echo "gopro-to-csv.py"
	echo "gopro-to-gpx.py"
	echo ""
	echo "Place a video file in the video folder and run with"
	echo ""
	echo "docker run --rm gitfun4all/gorpo-dash auto"
  	echo ""
  	echo "This will run the example"
	echo "gopro-dashboard.py --gpx video.gpx (created if not found) video.MP4 video-dashboard.MP4"
	echo "" && sleep 3
  	exit 1;;
esac
echo "All done - thanks mainly to github: time4tea/gopro-dashboard-overlay!"

