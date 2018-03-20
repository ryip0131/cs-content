namespace: io.cloudslang.demo

flow:
    name: rydeploy_tomcat

    inputs:
      - hostname: "10.0.46.10"
      - username: "Capa1\\1290-capa1user"
      - password: "Automation123"
      - image:  :Ubuntu"
      - folder: "Partners"

    workflow:
      - uuid_generator:
          do:
            io.cloudslang.base.utils.uuid_generator: null
          publish:
            - uuid: '${new_uuid}'
          navigate:
            - SUCCESS: SUCCESS
    results:
      - SUCCESS
