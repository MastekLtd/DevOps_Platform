docker run -p 8088:8088 -p 9088:6556 --name project -h project -v /vshare/docker/config:/home/devops/config -v /vshare/Build/project/:/usr/share/ project