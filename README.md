# Hadoop Single Node  on Docker.

Following this steps you can build and use the image to create a Hadoop Single Node Cluster containers.


## Creating the container

To run and create a container execute the next command:

     $ docker run -it --name <container-name> -p 9864:9864 -p 9870:9870 -p 8088:8088 --hostname <your-hostname> hadoop

Change **container-name** by your favorite name and set **your-hostname** with by your ip or name machine. You can use **localhost** as your-hostname

When you run the container, at the entrypoint you use the docker-entrypoint.sh shell that creates and starts the hadoop environment.

You should get the following prompt:

     hduser@localhost:~$ 

To check if hadoop container is working go to the url in your browser.

     http://localhost:9870
