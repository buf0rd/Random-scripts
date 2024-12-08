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

# Prompt the user to decide whether audio should be included
echo "Do you want to include audio in the stream? (yes/no)"
read -r INCLUDE_AUDIO

# Build the audio options based on the user's choice
if [[ "$INCLUDE_AUDIO" == "yes" || "$INCLUDE_AUDIO" == "y" ]]; then
    AUDIO_OPTIONS="-c:a aac -b:a $AUDIO_BITRATE" # Include audio encoding options
    echo "Audio will be included in the stream."
else
    AUDIO_OPTIONS="-an" # Disable audio
    echo "Audio will NOT be included in the stream."
fi

# Run FFmpeg command with RTSP optimizations
ffmpeg \
    -rtsp_transport tcp -buffer_size 10000000 -fflags +genpts+discardcorrupt -max_delay 5000000 -rw_timeout 15000000 -fflags nobuffer \
    -i "$RTSP_URL" \
    -s "$RESOLUTION" -r "$FRAMERATE" \
    -c:v libx264 -preset veryfast -maxrate "$VIDEO_BITRATE" -bufsize "$BUF_SIZE" \
    -pix_fmt yuv420p -g 60 \
    $AUDIO_OPTIONS \
    -f flv "$YOUTUBE_URL/$STREAM_KEY"
