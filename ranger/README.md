# Run the script install.sh

# To enable video review

Uncomment the video rules you want to use in scope.sh, inside the handle_image function (search for ffmpeg if you can't find it).

Get an rc.conf (ranger --copy-config=rc) and change the line with set preview_script to point to your custom scope.sh.
