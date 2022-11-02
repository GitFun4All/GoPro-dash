# GoPro-dash
Docker resources for the excellent GoPro-overlay-dashboard.py


Prerequsites: 
-------------------------------------------------------------------------------
All filenames in the videos directory must be uppercase (including extensions!)
-------------------------------------------------------------------------------


To use these files, clone the repository copy a GoPro MP4 video
to the videos directory and then run the following:

docker compose build 

docker compose run --rm goprovo auto

Make some tea, wait for gopro-overlay to do the magic. When complete
you should find a new file alongside your original with {filename}-OV.MP4.

other things to try:

docker compose run --rm help (Provide details of included apps)

to see why something went wrong:

docker compose run --rm bash

WARNING: Provided as is, no liability implied, use at your own risk!

