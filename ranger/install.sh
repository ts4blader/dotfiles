apt update
apt install ranger caca-utils highlight atool w3m poppler-utils mediainfo w3m-img
apt install ffmpeg ffmpegthumbnailer

ranger --copy-config all

git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

git clone https://github.com/maximtrp/ranger-archives.git ~/.config/ranger/plugins/ranger-archives


echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
echo "set preview_images true" >>   $HOME/.config/ranger/rc.conf
