#!/bin/bash
#software version:jdk1.8.0_202, Anaconda3-2022.09-0-Linux-aarch64.sh, hadoop-2.10.2.tar
#install java
tar zxvf ~/Downloads/jdk-8u202-linux-arm64-vfp-hflt.tar.gz
mkdir ~/env
mv ~/Downloads/jdk1.8.0_202/ ~/env
echo export JAVA_HOME=/home/et/env/jdk1.8.0_202 export PATH='$JAVA_HOME'/bin:'$PATH' >> ~/.bashrc
source ~/.bashrc

#install Anaconda
cd ~/Downloads
chmod +x Anaconda3-2022.09-0-Linux-aarch64.sh
./Anaconda3-2022.09-0-Linux-aarch64.sh
echo export ANACONDA_HOME=/home/et/env/anaconda3 $'\n'export PATH='$ANACONDA_HOME'/bin:'$PATH' >> ~/.bashrc
source ~/.bashrc

#install Hadoop
tar xvf ~/Downloads/hadoop-2.10.2.tar
mv ~/Downloads/hadoop-2.10.2 ~/env
#cd ~/env/hadoop-2.10.2/etc/hadoop/
echo -e '<configuration>\n<property>\n<name>fs.defaultFS</name>\n<value>hdfs://devenv</value>\n</property>\n<property>\n<name>hadoop.http.staticuser.user</name>\n<value>spark</value>\n</property>\n</configuration>' >> ~/env/hadoop-2.10.2/etc/hadoop/core-site.xml
echo -e '<configuration>\n<property>\n<name>dfs.namenode.name.dir</name>\n<value>/home/et/env/hdfs/namenode/</value>\n</property>\n<property>\n<name>dfs.datanode.data.dir</name>\n<value>/home/et/env/hdfs/datanode/</value>\n</property>\n</configuration>' >> ~/env/hadoop-2.10.2/etc/hadoop/hdfs-site.xml
echo export JAVA_HOME=/home/et/env/jdk1.8.0_202 $'\n'export PATH='$JAVA_HOME'/bin:'$PATH' $'\n'export HADOOP_HOME=/home/et/env/hadoop-2.10.2 $'\n'export PATH='$HADOOP_HOME'/bin:'$PATH' $'\n'export HADOOP_CONF_DIR='$HADOOP_HOME'/etc/hadoop >> ~/env/hadoop-2.10.2/etc/hadoop/hadoop-env.sh
echo devenv >> ~/env/hadoop-2.10.2/etc/hadoop/slaves
echo export HADOOP_HOME=/home/et/env/hadoop-2.10.2 $'\n'export PATH='$HADOOP_HOME'/bin:'$PATH' $'\n'export HADOOP_CONF_DIR='$HADOOP_HOME'/etc/hadoop >> ~/.bashrc
source ~/.bashrc
rm -rf /home/et/env/hdfs
mkdir /home/et/env/hdfs
mkdir /home/et/env/hdfs/namenode
mkdir /home/et/env/hdfs/datanode
cd /home/et/env/hdfs
hadoop namenode -format
sudo apt-get install ssh
sudo hostnamectl set-hostname devenv
#cd /home/et/env/hadoop-2.10.2/sbin
#./start-dfs.sh
/home/et/env/hadoop-2.10.2/sbin/start-dfs.sh

#install SPARK
sudo apt-get install jupyter-notebook
tar zxvf ~/Downloads/spark-3.2.0-bin-hadoop2.7.tgz
mv ~/Downloads/spark-3.2.0-bin-hadoop2.7 ~/env
#cd ~/env/spark-3.2.0-bin-hadoop2.7/conf/
cp ~/env/spark-3.2.0-bin-hadoop2.7/conf/spark-env.sh.template ~/env/spark-3.2.0-bin-hadoop2.7/conf/spark-env.sh
echo export JAVA_HOME=/home/et/env/jdk1.8.0_202 $'\n'export PATH='$JAVA_HOME'/bin:'$PATH' $'\n'export HADOOP_HOME=/home/et/env/hadoop-2.10.2 $'\n'export PATH='$HADOOP_HOME'/bin:'$PATH' $'\n'export HADOOP_CONF_DIR='$HADOOP_HOME'/etc/hadoop $'\n'export ANACONDA_HOME=/home/et/env/anaconda3 $'\n'export PATH='$ANACONDA_HOME'/bin:'$PATH' $'\n'export SPARK_HOME=/home/et/env/spark-3.2.2-bin-hadoop2 $'\n'export PATH='$SPARK_HOME'/bin:'$PATH' >> ~/env/spark-3.2.0-bin-hadoop2.7/conf/spark-env.sh
cp ~/env/spark-3.2.0-bin-hadoop2.7/conf/slaves.template ~/env/spark-3.2.0-bin-hadoop2.7/conf/slaves
#cd ~/env/spark-3.2.0-bin-hadoop2.7/sbin
#./start-all.sh
/home/et/env/spark-3.2.0-bin-hadoop2.7/sbin/start-all.sh




echo 'Done'

