docker run -p 10020:10020 -p 10021:6556 --name project -h project -v /mnt/gluster/repo/config/services:/home/devops/config/services -v /mnt/gluster/repo/Build/project/:/usr/share/ project