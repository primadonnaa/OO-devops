namespace: flowAuthoring
flow:
  name: Network
  workflow:
    - run_command:
        do:
          io.cloudslang.base.cmd.run_command:
            - command: ipconfig
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      run_command:
        x: 280
        'y': 360
        navigate:
          7314e168-615f-fb9a-91b7-85e3454b3d00:
            targetId: f6f9f789-2a0c-c760-b054-6d8549cd7e85
            port: SUCCESS
    results:
      SUCCESS:
        f6f9f789-2a0c-c760-b054-6d8549cd7e85:
          x: 560
          'y': 360
