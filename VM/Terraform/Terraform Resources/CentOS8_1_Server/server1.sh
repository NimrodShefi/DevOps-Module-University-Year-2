
	echo "whoami..."
	whoami

	echo "pwd..."
	pwd

	# echo "upgrading..."
	# sudo dnf upgrade -y

	echo "INSTALLING GIT..."
	sudo dnf install git -y
	echo "FINISH INSTALLING GIT"

	echo "INSTALLING JAVA..."
	sudo dnf install java-11-openjdk-devel -y
	export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
	echo "FINISH INSTALLING JAVA"

	echo "INSTALLING MARIADB..."
	sudo dnf install mariadb-server -y
	sudo systemctl start mariadb
	sudo systemctl status mariadb
	sudo systemctl enable mariadb
	echo "FINISH INSTALLING MARIADB"

	echo "INSTALLING GRADLE..."
	echo "making /opt/gradle directory..."
	sudo mkdir /opt/gradle

	echo "installing gradle 6.8.2..."
	sudo dnf install unzip -y
	cd /opt/gradle
	sudo curl -sLo \
	gradle-6.8.2-bin.zip \
	https://services.gradle.org/distributions/gradle-6.8.2-bin.zip
	sudo unzip gradle-6.8.2-bin.zip
	sudo rm gradle-6.8.2-bin.zip
	export GRADLE_HOME=/opt/gradle/gradle-6.8.2
	export PATH=$GRADLE_HOME/bin:$PATH

	# Profile.d

	echo "creating /etc/profile.d/gradle.sh..."
	sudo touch /etc/profile.d/gradle.sh
	sudo chown vagrant.vagrant /etc/profile.d/gradle.sh
sudo cat << `EOF` >> /etc/profile.d/gradle.sh
export GRADLE_HOME=/opt/gradle/gradle-6.8.2
export PATH=$GRADLE_HOME/bin:$PATH
`EOF`
	sudo chown root.root /etc/profile.d/gradle.sh
	sudo chmod 644 /etc/profile.d/gradle.sh
	echo "FINISH INSTALLING GRADLE"

	echo "INSTALLING GITLAB SERVER KEY..."
	echo "making git.cardiff.ac.uk a known and trusted host"
	cd /home/vagrant # going to the defualt directory (~)
	touch .ssh/known_hosts
	ssh-keyscan git.cardiff.ac.uk >> .ssh/known_hosts
	chmod 644 .ssh/known_hosts
	ECHO "FINISH INSTALLING GITLAB SERVER KEY"

	echo "INSTALLING GITLAB DEPLOYMENT KEY..."
	touch project.key
	echo "Writing project key"
sudo cat << `EOF` >> project.key
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAsX22kvfRu8UzawyuL1+QoZA4IDNrslc8ruHBHMx/SVZoUS8E
GzlaeyrOky/XkVmS+JuJC1Tx4pJ6RIEprIufhKxUp/NiyiIu4Onc1DbUSjZ272ST
Wc0N+o1rt2qgvBqGOImr4xEXHvVOg45pl5J92Q4K61nwDUMjr9NEeBa9qDFdhPN5
Ajwf8yuDgd61Y6w70rs4AzxwCphP/x8pudvO2bjwLmPLp2v07qwvcyOZsjDcuSQs
4QWAQlPcSkqJx/Npu88j7voEcuNihRlFT9UzdTerqoqG0z35IGxYxt2WzasSW0R9
SLvMDl8zv/0DJPla0bbQ7J9syk5lsXY8OqwkOQIDAQABAoIBAGJBbai+d+Syrlw8
kNC43qAR7oAk9yGrGXTWlMkUjAJVSzpmBKftgCFe+SyR94wHQk1ODPew9pau7/Cs
cB2MzansnJC9M5sigUERNaZlE/BhZkXwL4Iu+eYSE+ddp816AYOa8wSomVwSAHzj
gaDe/7wBAhp3l2RAHqlfEzBHpoZMoGx0nweu6J1Yv2GKqn2ZO9N7VVETDtq2f66F
lihlvVhb2HmUHtyfws+1uOeTB6cdwCU1GiTV03mLeyDMkpNtDILh3mtgUr+xDGbM
EZocBeQO+3MmJ3PrLb2+1RnRquDIm7eXyFWFDBbGkXpQVxiCsCgbgul7KBaf2W+y
1/LRwAECgYEA7FoVPnLn16rGGOMbyCm4dCK1v3+4x4pqgOGA44rs7J3cqa/y2Gcq
VOO8nS2jnC64vNkdfZx8HQGJuREA4Da5QXf4JsKaIttdTUUoGXGsCdkop/NtJ8E2
C8zhTvekGJZY7kR8m3t577pbVsmXUE0T8JiLQxTCygmJA2k1xTO1qwECgYEAwD78
LdQLEJfeL463GaaJFG0T6pFXg9Lz/M38oBDRYFsuhFMcnG0H4Yc8DnruIR5F462/
rOIWn31Pqji5sQTIWtgzjrhveX+P7s77jijqyRRuh/ZTxUlVTt15Z+ggraxRF9aE
JItmFxDDu/1T6C60ErTTaiG2PSF4VFeh5lzeETkCgYEAk2O13cTASaDIelqeR5uk
2F+Q4YPfkigCNK7rtno7N29WXUdI9KSZJGkEhSwh3FLSh4oJtvxv9ZKw9QTie/AE
ZQxQZrNydYxAyd/3mq5lb5rJnLrT9jep4X/5fUo3PdH8UVHKNxewOcwIC74ZK011
wtMN/V4j/uQlWkgw7PJLNwECgYEAty3MwCYhfOgYL5x+3xQN3capiYJ/rv4cua/U
nPgpaPS4+CDxTCOftMdU9D8yE6By26S81JCBGesfM4TlesSh293SEpWuskhX7yaO
D0DxpjOvtiGCZKOhg4oImndWW+WrR1mBhAjHeAbjWobhooSN1J00LRZ+PPVdYJA3
lfa7KhECgYA3AO0p0+uaxJrA2JMr7jQ7rrdXF58dXSDV8onSS/C5WuUjhr7tsAxr
K6jt5bX+7d/CtjOlOy6Eb1YprtQ0gocCdST4/8Gy4RF3J/W5JEvCaV5yvY0/W//C
/Jyt8SuELpq1LocwdQCnG0f93I1fhkJU4W2/lEa2FRjcSzOvHQnWKw==
-----END RSA PRIVATE KEY-----
`EOF`
	echo "Project key written"
	sudo chmod 400 project.key

	echo "CLONING REPOSITORY..."
	ssh-agent bash -c 'ssh-add project.key; git clone git@git.cardiff.ac.uk:c1989618/ons-client-project-group-8.git'

	echo "PREPARING THE APPLICATION..."
	echo "building the DB and filling with dummy data"
	cd ons-client-project-group-8/src/main/resources/
	git checkout master
	mysql -u root < schema.sql ## by not having the -p (for password), mysql accepts the password as blank (which it is)
	mysql -u root < data.sql

	echo "RUNNING GRADLE BUILD..."
	cd /home/vagrant/ons-client-project-group-8/
	chmod +x ./gradlew
	./gradlew clean build
	echo "FINISH BUILDING THE PROJECT"

	echo "RUNNING THE JAR FILE"
	java -jar build/libs/group8-0.0.1-SNAPSHOT.jar&
	echo "FINISH RUNNING THE JAR FILE"

	echo "FINISH PREPARING VM"
