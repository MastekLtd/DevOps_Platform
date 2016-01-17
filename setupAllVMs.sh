#/bin/bash
if [ -z "$1" ]
  then
	echo "No argument supplied"
    echo "Please pass the environment type i.e. local,dev etc."
	exit
fi
envfilename=env_inventory/$1/host_address.txt
envname=$1
networkScriptFileName="enp4s0"
echo "Start building  environment of .....$envname"
startCleanVirtualBox() {	
local VAGARANTFILE_PATH=$1
local serverip=$2
cd $VAGARANTFILE_PATH;
echo "destroying the VM if already exists from location - "$VAGARANTFILE_PATH
vagrant destroy -f;
echo "Starting the VM at this location - "$VAGARANTFILE_PATH
#vagrant up;
SYS_IP=$serverip  ENV_TYPE=$envname NET_CONFIG_FILE=$networkScriptFileName  vagrant up
exitingFromThePassedFolder $VAGARANTFILE_PATH 
}
exitingFromThePassedFolder()
{
local path=$1
count=$(echo $path | grep -ao '/' | wc -l)
EXIT_STRING="cd ";
for (( c=1; c <= $count; c++ ))
do
   EXIT_STRING=$EXIT_STRING"../"
done
$EXIT_STRING
}

declare -A IPMAP 
while read -r line 
do
    name=$line
	var=$(echo $name | awk -F"=" '{print $1,$2}')   
	set -- $var
	IPMAP[$1]=$2	 
done < $envfilename
echo "JENKINS SERVER :-  ${IPMAP["JENKINS_HOST_IP"]}"
echo "ELK SERVER :- ${IPMAP["ELK_HOST_IP"]}"
echo "POSTGRES SERVER :- ${IPMAP["POSTGRES_HOST_IP"]}"
echo "OMD SERVER :- ${IPMAP["OMD_HOST_IP"]}"
echo "DOCKER SERVER :- ${IPMAP["DOCKER_HOST_IP"]}"

#grep -r '&&JENKINS_HOST_IP&&' -l --null ./ | xargs -0 sed -i 's#&&JENKINS_HOST_IP&&#'${IPMAP["JENKINS_HOST_IP"]}'#g'
#grep -r '&&ELK_HOST_IP&&' -l --null ./ | xargs -0 sed -i 's#&&ELK_HOST_IP&&#'${IPMAP["ELK_HOST_IP"]}'#g'
#grep -r '&&POSTGRES_HOST_IP&&' -l --null ./ | xargs -0 sed -i 's#&&POSTGRES_HOST_IP&&#'${IPMAP["POSTGRES_HOST_IP"]}'#g'
#grep -r '&&OMD_HOST_IP&&' -l --null ./ | xargs -0 sed -i 's#&&OMD_HOST_IP&&#'${IPMAP["OMD_HOST_IP"]}'#g'
#grep -r '&&DOCKER_HOST_IP&&' -l --null ./ | xargs -0 sed -i 's#&&DOCKER_HOST_IP&&#'${IPMAP["DOCKER_HOST_IP"]}'#g'

#find . -name "*.sh" -exec chmod +x {} \;
startCleanVirtualBox vagrant/jenkins_sonar/ ${IPMAP["JENKINS_HOST_IP"]}
startCleanVirtualBox vagrant/elk/  ${IPMAP["ELK_HOST_IP"]}
startCleanVirtualBox vagrant/postgres/ ${IPMAP["POSTGRES_HOST_IP"]}
startCleanVirtualBox vagrant/omd/  ${IPMAP["OMD_HOST_IP"]}
startCleanVirtualBox vagrant/docker/ ${IPMAP["DOCKER_HOST_IP"]}
#git reset --hard
#git clean -f
