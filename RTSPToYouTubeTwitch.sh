#! /bin/bash
#
# Script to push RTSP stream to Youtube. Works well on 8/29/18 - wcbutler@gmail.com
# V1.0 - Need to fix the testing statement. Right now this only works to YouTube as it sits

#CHANGE THESE
FPS="20"                                                       # Frames per second (up to 60)
INPUTCOUNT=1                                                   # Number of RTSP streams to generate (future)
INPUT1="rtsp://root:pass@10.0.0.50/axis-media/media.amp"       # RTSP input
METHOD="YouTube"					                                     # YouTube or Twitch
YTKEY1="000-0000-0000-0000"                                    # YouTube streaming key
TWITCHKEY1="live_000000000_000000000000000000000000000000"     # Twitch streaming key
YTSERVER="a"						                                       # YouTube ingestion server, use b for backup
TWITCHSERVER="live.jfk"                                        # Twitch ingestion server, change as needed

#GENERALLY LEAVE THESE
YOUTUBE="rtmp://$YTSERVER.rtmp.youtube.com/live2/$YTKEY1"       # calculates your YT output
TWITCH="rtmp://$TWITCHSERVER.twitch.tv/app/$TWITCHKEY1"         # calculates your Twitch output
OUTPUT="$([[ $METHOD -eq "YouTube" ]] && echo $YOUTUBE)"        # fix this
#OUTPUT="$([[ $METHOD -eq "Twitch " ]] && echo $TWITCH)"        # definitely fix this

ffmpeg -f lavfi -i anullsrc -rtsp_transport tcp -i $INPUT1 \
-vf fps=fps=$FPS -vcodec libx264 -x264-params keyint=3 -f flv $OUTPUT



