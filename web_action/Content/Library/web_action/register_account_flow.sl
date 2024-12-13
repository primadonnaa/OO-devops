namespace: web_action
flow:
  name: register_account_flow
  inputs:
    - url: 'http://oo-vm02.itomlabs.com:8082/'
    - username: helenk
    - password: Helenk01
    - first_name: Helen
    - last_name: Keller
    - email: hk@merant.com
  workflow:
    - register_account:
        do:
          web_action.register_account:
            - url: '${url}'
            - username: '${username}'
            - password: '${password}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: '${email}'
        publish:
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result
    - error_message
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      register_account:
        x: 100
        'y': 150
        navigate:
          c1f869a7-ce67-83df-2a55-25e5a6e122c1:
            targetId: 1ff27040-7471-2ea7-dea6-87d8ee0c451f
            port: SUCCESS
          2a81b0b1-de47-3886-2fcc-3def9ece89f9:
            targetId: 1ff27040-7471-2ea7-dea6-87d8ee0c451f
            port: WARNING
    results:
      SUCCESS:
        1ff27040-7471-2ea7-dea6-87d8ee0c451f:
          x: 400
          'y': 150
