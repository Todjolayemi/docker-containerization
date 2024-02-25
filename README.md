#   Containerizing Applications
##  Description
-   This project involves the containerization of the following applications using Docker.
    -   a.  [Web application (frontend)](./web/): This is written using Golang and it is served on port 80 which proxy request to the backend application.
    -   b.  [Backend application](./words/): This contains the api written in java language which also queries the database and get the frontend display the words in the database
    -   c.  [Database](./db/): This directory contains the intialization set up for our backend application which is typically a postgressql db instance.


##  Process for dockering each of the applications
-   The [web application Dockerfile](./web/Dockerfile) contains the set of instruction in running the golang application. It cotains a a multi-stage process by reducing the docker image size for the image to be more effective and boot up at a rapid rate.
-   Building the docker image for this can be done with the commands

            #move to the web directory
            cd web

            #build the docker image and gives it a name of web
            docker build . -t web

            #Run the dockerimage (web) in the port 80 and give the container a name of golang_web
            docker run -d -p 80:80 --name golang_web web

    -   we can get if the image is created and also if the container is running by running the command

                #To get the docker image running
                docker images

                #To get the name of the running containers
                docker ps

        ![web_image](./images/web_docker.png)
    
    - Verify on the web browser if it wworks by going to **http://localhost:80**
        ![web_browser](./images/web_frontend.png)

        -   **NB:** It does not have access to the backend yet, this will be treated later.


-   The [backend Dockerfile](./words/Dockerfile) contains the set of instruction in running the api written in java. It also cotains a a multi-stage build process
-   Building the docker image for this can be done with the commands

            #move to the words directory
            cd words

            #build the docker image and gives it a name of api
            docker build . -t api

            #Run the dockerimage (api) and give the container a name of java_api and we will not be exposing this to the outside world since it is a backend api
            docker run -d --name java_api api

    -   we can get if the image is created and also if the container is running by running the command

                #To get the docker image running
                docker images

                #To get the name of the running containers
                docker ps
        ![java_api](./images/java_api_running.png)
    -   We have two containers and images runnng (i.e the frontend and backend)

-   Lastly for containerizing the [database Dockerfile](./db/Dockerfile), the initialization script is passed and also we set the POSTGRES_HOST_AUTH_METHOD to trust to allows all connections to the database without requiring authentication.
-   Building the docker image for this can be done with the commands

            #move to the db directory
            cd db

            #build the docker image and gives it a name of db
            docker build . -t db

            #Run the dockerimage (db) and give the container a name of nebo_db
            docker run -d --name nebo_db db

    -   we can get if the image is created and also if the container is running by running the command

                #To get the docker image running
                docker images

                #To get the name of the running containers
                docker ps
        ![db](./images/db.png)

-   Now we have all our images up and running, but they do not seems to communicate with each other because they are not in the same network, let's fix this by making them to communicate with each other using the [docker compose](./docker-compose.yml)

    -   We can simply bring all the docker containers built up at once so they can all communicate with each other on the same network by running

                docker-compose up -d
    -   This way, our applications gets to communicate with each other.

                #To get the images running using the docker-compose
                docker ps
    ![compose](./images/compose.png)
    -   Now we can verify in the browser by going to **http://localhost:80**. This then can query from backend because they are in the same network.

        ![query](./images/query.png)

    -   To bring down the docker-compose containers, we can do so by typing the command

                docker-compose down

##  Creation and pushing of image to hub.docker.com for all the applications
-   I have created account on docker hub with docker with the name **nebotodymu** 
-   I need to authenticate to our docker hub account through the Command Line Interface (CLI) with the commands

            docker login

-   I will tagging my docker images using my docker username to push to docker hub, i will be implementing this for all my applications.
-   For web application, we can tag and push to the docker hub following the commands below:

            #change working directory to web
            cd web

            #buid and tag the docker image 
            docker build . -t nebotodymu/webapp

            #push the docker image
            docker push nebotodymu/webapp

-   For backend api (words) application, we can tag and push to the docker hub following the commands below:

            #change working directory to words
            cd words

            #buid and tag the docker image 
            docker build . -t nebotodymu/words

            #push the docker image
            docker push nebotodymu/words

-   Lastly, for the database, we can tag and push to the docker hub following the commands below:

            #change working directory to words
            cd db

            #buid and tag the docker image 
            docker build . -t nebotodymu/db

            #push the docker image
            docker push nebotodymu/db            


-   Now we have all the three applications pushed to my docker registry
    ![docker-hub](./images/docker-hub.png)