#
#wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
#sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
#sudo apt-get update
#sudo apt-get install -y default-jdk
#cd /user/lib/jvm/java-8-openjdk-amd64
#JAVA_HOME=/user/lib/jvm/java-8-openjdk-amd64

#sudo add-apt-repository ppa:webupd8team/java
#sudo apt-get update
#sudo apt-get install -y oracle-java7-installer

#sudo apt-get install -y jenkins

#!/bin/bash

# if [ ! -f /usr/bin/git ]; 
# then
# 	echo "-------- PROVISIONING Git ------------"
# 	echo "---------------------------------------------"

# 	## Install subverison
# 	apt-get update
# 	apt-get -y install git
# else
# 	echo "CHECK - Git already installed"
# fi


if [ ! -f /usr/lib/jvm/java-7-oracle/bin/java ]; 
then
    echo "-------- PROVISIONING JAVA ------------"
	echo "---------------------------------------"

	## Make java install non-interactive
	## See http://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
	echo debconf shared/accepted-oracle-license-v1-1 select true | \
	  debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | \
	  debconf-set-selections

	## Install java 1.7
	## See http://www.webupd8.org/2012/06/how-to-install-oracle-java-7-in-debian.html
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
	apt-get update
	apt-get -y install oracle-java7-installer
else
	echo "CHECK - Java already installed"
fi

if [ ! -f /etc/init.d/jenkins ]; 
then
	echo "-------- PROVISIONING JENKINS ------------"
	echo "------------------------------------------"


	## Install Jenkins
	#
	# URL: http://localhost:6060
	# Home: /var/lib/jenkins
	# Start/Stop: /etc/init.d/jenkins
	# Config: /etc/default/jenkins
	# Jenkins log: /var/log/jenkins/jenkins.log
	wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
	apt-get update
	apt-get -y install jenkins

	# Move Jenkins to port 6060
	sed -i 's/8080/6060/g' /etc/default/jenkins
	sudo /etc/init.d/jenkins restart
else
	echo "CHECK - Jenkins already installed"
fi


### Everything below this point is not stricly needed for Jenkins to work
###

# if [ ! -f /etc/init.d/tomcat7 ]; 
# then
# 	echo "-------- PROVISIONING TOMCAT ------------"
# 	echo "-----------------------------------------"


# 	## Install Tomcat (port 8080) 
# 	# This gives us something to deploy builds into
# 	# CATALINA_BASE=/var/lib/tomcat7
# 	# CATALINE_HOME=/usr/share/tomcat7
# 	export JAVA_HOME="/usr/lib/jvm/java-7-oracle"
# 	apt-get -y install tomcat7

# 	# Work around a bug in the default tomcat start script
# 	sed -i 's/export JAVA_HOME/export JAVA_HOME=\"\/usr\/lib\/jvm\/java-7-oracle\"/g' /etc/init.d/tomcat7
# 	/etc/init.d/tomcat7 stop
# 	sudo /etc/init.d/tomcat7 start
# else
# 	echo "CHECK - Tomcat already installed"
# fi

# if [ ! -f /usr/local/lib/ant/apache-ant-1.9.4/bin/ant ]; 
# then
# 	echo "-------- PROVISIONING ANT ---------------"
# 	echo "-----------------------------------------"

# 	mkdir -p /usr/local/lib/ant
# 	cd /usr/local/lib/ant
# 	wget -q http://ftp.halifax.rwth-aachen.de/apache//ant/binaries/apache-ant-1.9.4-bin.tar.gz
# 	tar xzf apache-ant-1.9.4-bin.tar.gz
# 	rm apache-ant-1.9.4-bin.tar.gz
# 	ln -s /usr/local/lib/ant/apache-ant-1.9.4/bin/ant /usr/local/bin/ant

# 	echo "Ant installed"
# else
# 	echo "CHECK - Ant already installed"
# fi


echo "-------- PROVISIONING DONE ------------"
echo "-- Jenkins: http://localhost:6060      "
echo "-- Tomcat7: http://localhost:7070      "
echo "---------------------------------------"



