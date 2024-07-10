#!/bin/bash
set -ex

#variables
REPO_NAME=counter
DEB_DIR=/home/$USER/deb
APT_DIR=/var/local/$REPO_NAME
APT_PACKS=("postgresql-14" "redis-server" "pgbouncer")

echo "(1) pre-requirements"
sudo apt update
sudo apt install dpkg-dev -y

echo "(2) download .deb packages"

if [ ! -d "$DEB_DIR" ]
then
	mkdir $DEB_DIR
	cd $DEB_DIR

	for item in ${APT_PACKS[@]}
	do
		apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances --no-pre-depends $item | grep "^\w" | sort -u)
	done
fi

#check_1
debs=$(ls $DEB_DIR | grep deb | wc -l)
echo $debs

echo "(3) create local apt repo "

if [ ! -d "$APT_DIR" ]
then
	sudo mkdir -p $APT_DIR && cd $APT_DIR
	sudo cp $DEB_DIR/* $APT_DIR/
fi

#check_2
debs_repo=$(ls $APT_DIR | wc -l)
echo $debs_repo


sudo chown -R $USER:$USER $APT_DIR
cd $APT_DIR && sudo dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
if [ ! -e "/etc/apt/sources.list.d/$REPO_NAME.list" ]
then
	sudo touch /etc/apt/sources.list.d/$REPO_NAME.list
	echo "deb [trusted=yes] file:$APT_DIR/ ./" | sudo tee -a /etc/apt/sources.list.d/$REPO_NAME.list
fi

#clear deb dir	
sudo rm -r $DEB_DIR

#final check
sudo apt update
