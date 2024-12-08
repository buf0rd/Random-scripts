#!/bin/bash

# Configuration Variables
RTSP_URL="rtsp://<username>:<password>@<camera_ip>:<port>/path" # Replace with your RTSP stream URL
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
STREAM_KEY="<your_stream_key>" # Replace with your YouTube Live Stream Key
RESOLUTION="2560x1440" # Set the resolution
FRAMERATE=30 # Set the frame rate
VIDEO_BITRATE="6000k" # Set the video bitrate
AUDIO_BITRATE="128k" # Set the audio bitrate
BUF_SIZE="12000k" # Set the buffer size

# Run FFmpeg command
ffmpeg -i "$RTSP_URL" \
    -s "$RESOLUTION" -r "$FRAMERATE" \
    -c:v libx264 -preset veryfast -maxrate "$VIDEO_BITRATE" -bufsize "$BUF_SIZE" \
    -pix_fmt yuv420p -g 60 \
    -c:a aac -b:a "$AUDIO_BITRATE" \
    -f flv "$YOUTUBE_URL/$STREAM_KEY"
