# docker-sonar
[![CircleCI Build Status](https://img.shields.io/circleci/project/million12/docker-sonar/master.svg)](https://circleci.com/gh/millio12/docker-sonar)
[![GitHub Open Issues](https://img.shields.io/github/issues/million12/docker-sonar.svg)](https://github.com/million12/docker-sonar)
[![GitHub Stars](https://img.shields.io/github/stars/million12/docker-sonar.svg)](https://github.com/million12/docker-sonar)
[![GitHub Forks](https://img.shields.io/github/forks/million12/docker-sonar.svg)](https://github.com/million12/docker-sonar)  
[![Stars on Docker Hub](https://img.shields.io/docker/stars/million12/sonar.svg)](https://hub.docker.com/r/million12/sonar)
[![Pulls on Docker Hub](https://img.shields.io/docker/pulls/million12/sonar.svg)](https://hub.docker.com/r/million12/sonar)  
[![Docker Layers](https://badge.imagelayers.io/million12/sonar:latest.svg)](https://hub.docker.com/r/million12/sonar)


[Dockr Image](https://hub.docker.com/r/million12/sonar) with [SonarQube](http://www.sonarqube.org/) build on top of official [CentOS-7](https://hub.docker.com/_/centos/) image.

### Build
Too build just type:  

    docker build -t million12/sonar .

### Run
Sonar needs PostgreSQL database to be able to connect to and creade default database.    

*PostgreSQL*

    docker run -d \
      --name sonar-db \
      -e POSTGRES_USER=sonar \
      -e POSTGRES_PASSWORD=sonar \
      postgres  

*Sonar*

    docker run -d \
      --name sonar \
      --link sonar-db:sonar.db \
      -p 9000:9000 \
      -e SONARQUBE_JDBC_URL=jdbc:postgresql://sonar.db:5432/sonar \
      -e SONARQUBE_JDBC_USERNAME=sonar \
      -e SONARQUBE_JDBC_PASSWORD=sonar \
      million12/sonar

### Access web-interface


|*Tool* | *Link* | *Credentials* |
| ------------- | ------------- | ------------- |
| SonarQube | http://docker.ip}:9000 | admin/admin |

### Plugins
List of installed plugins:  
`sonar-java-plugin`  
`sonar-web-plugin`  
`sonar-scm-git-plugin`  
`sonar-github-plugin`  
**Please see [`Dockerfile`](https://github.com/million12/docker-sonar/blob/master/Dockerfile) for specific plugin version**

### Docker troubleshooting

Use docker command to see if all required containers are up and running:

    $ docker ps -a

Check online logs of sonar container:

    $ docker logs sonar

Attach to running sonar container (to detach the tty without exiting the shell,
use the escape sequence Ctrl+p + Ctrl+q):

    $ docker attach sonar

Sometimes you might just want to review how things are deployed inside a running container, you can do this by executing a _bash shell_ through _docker's exec_ command:

    docker exec -i -t sonar /bin/bash

History of an image and size of layers:

    docker history --no-trunc=true million12/sonar | tr -s ' ' | tail -n+2 | awk -F " ago " '{print $2}'

---
## Author

Author: Przemyslaw Ozgo [linux@ozgo.info](mailto:linux@ozgo.info)

Licensed under: The MIT License (MIT)

**Sponsored by** [PrototypeBrewery.io - the new prototyping tool](http://prototypebrewery.io/)
for building fully interactive prototypes of your website or web app. Built on top of
Neos CMS and Zurb Foundation framework.
