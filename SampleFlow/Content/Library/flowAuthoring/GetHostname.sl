namespace: flowAuthoring
flow:
  name: GetHostname
  workflow:
    - run_command:
        worker_group: worker_group1
        do:
          io.cloudslang.base.cmd.run_command:
            - command: hostname
        publish:
          - server_name: '${return_result}'
        navigate:
          - SUCCESS: Display_Message
          - FAILURE: on_failure
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message: '${"The hostname is: " + server_name}'
        navigate:
          - success: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      run_command:
        x: 120
        'y': 200
      Display_Message:
        x: 240
        'y': 200
        navigate:
          d48799ef-63fd-ddf0-9b73-2f5a2544c8d0:
            targetId: 134a66fd-4fef-d98f-b98f-003f3aa03650
            port: success
    results:
      SUCCESS:
        134a66fd-4fef-d98f-b98f-003f3aa03650:
          x: 360
          'y': 200
