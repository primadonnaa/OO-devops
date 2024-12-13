namespace: flowAuthoring
flow:
  name: DisplayMessage
  workflow:
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message:
                prompt:
                  type: text
        navigate:
          - success: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      Display_Message:
        x: 160
        'y': 200
        navigate:
          d1925c9f-d559-5afc-635b-8a1e3b445466:
            targetId: e298041f-a6cd-055f-8c15-6682c5c3f8fa
            port: success
    results:
      SUCCESS:
        e298041f-a6cd-055f-8c15-6682c5c3f8fa:
          x: 360
          'y': 200
