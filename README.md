# Hadoop Single Node  on Docker.

Following this steps you can build and use the image to create a Hadoop Single Node Cluster containers.
## Build the image from the current Docker file
To run and create an from the docker file  execute the next command:
      $ docker build -t **ImageName** . 
## Create the container

To run and create a container execute the next command:

     $ docker run -it --name <container-name> -p 9864:9864 -p 9870:9870 -p 8088:8088 --hostname <your-hostname> hadoop

Change **container-name** by your favorite name and set **your-hostname** with by your ip or name machine.

You should get the following prompt:  

       hduser@localhost:~$ 
Start the ssh server:  

     hduser@localhost:~$ service ssh start 
     
Format the name nodenode:  

     hduser@localhost:~$ hdfs namenode -format 

Start the hadoop services (yarn and HDFS):  

     hduser@localhost:~$ start-all.sh 

Check if all services are started :  

    hduser@localhost:~$ jps 
