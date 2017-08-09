
## Install Repo
```
sudo su

echo "deb https://dl.bintray.com/kireevco/deb /" > /etc/apt/sources.list.d/bintray-kireevco.list
apt update
gpg --recv-keys 379CE192D401AB61
gpg --export 379CE192D401AB61 | apt-key add -
apt-key update
apt update


apt install -y opencv python3-numpy libgtk2.0 libavcodec-extra-56 libavformat56
```