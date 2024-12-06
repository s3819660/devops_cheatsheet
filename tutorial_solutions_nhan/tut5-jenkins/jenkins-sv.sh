# ======== Allocate more disk space ============
echo 'tmpfs   /tmp    tmpfs   defaults,size=3G   0   0' >> /etc/fstab
mount -o remount /tmp
# ==============================================


# ============ Install Jenkins =================
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# install java
yum install fontconfig java-17-amazon-corretto -y
# install jenkins
yum install jenkins -y
service jenkins start

# ==============================================


# ============== Install Maven =================
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
tar -xvzf apache-maven-3.9.9-bin.tar.gz
mv apache-maven-3.9.9 maven

# setup env var for maven
cd ~
echo 'M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64
PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
export PATH' >>  .bash_profile
source .bash_profile
echo $PATH
mvn -v

# ===============================================