#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
# Creates a Docker DB container.
#
# Inputs:
#   - host - Docker machine host
#   - username - Docker machine username
#   - password - Docker machine password
#   - port - optional - SSH port
# Outputs:
#   - db_IP - IP of newly created container
#   - error_message - error message of failed operation
####################################################
namespace: io.cloudslang.docker.containers

imports:
 docker_images: io.cloudslang.docker.images
 docker_containers: io.cloudslang.docker.containers
flow:
  name: create_db_container
  inputs:
    - host
    - port:
        required: false
    - username
    - password
  workflow:
    - pull_mysql_image:
        do:
          docker_images.pull_image:
            - image_name: "'mysql'"
            - host
            - port:
                required: false
            - username
            - password
            - port:
                required: false
        publish:
          - error_message

    - create_mysql_container:
        do:
          docker_containers.run_container:
            - image_name: "'mysql'"
            - container_name: "'mysqldb'"
            - container_params: "'-e MYSQL_ROOT_PASSWORD=pass -e MYSQL_DATABASE=boot -e MYSQL_USER=user -e MYSQL_PASSWORD=pass'"
            - host
            - port:
                required: false
            - username
            - password
        publish:
          - error_message

    - get_db_ip:
        do:
          docker_containers.get_container_ip:
            - container_name: "'mysqldb'"
            - host
            - port:
                required: false
            - username
            - password
        publish:
          - container_ip
          - error_message

  outputs:
    - db_IP: "'' if 'container_ip' not in locals() else container_ip"
    - error_message
