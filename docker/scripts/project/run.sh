docker run -p 10020:10020 -p 10021:6556 --name project -h project -v /vshare/docker/config/services:/home/devops/config/services -v /vshare/Build/project/:/usr/share/ project