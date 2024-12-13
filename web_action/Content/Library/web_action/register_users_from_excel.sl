namespace: web_action
flow:
  name: register_users_from_excel
  inputs:
    - excel_path: "C:\\Users\\Admin\\Desktop\\users.xls"
    - sheet: Sheet1
    - login_header: Username
    - password_header: Password
    - name_header: Full Name
    - email_header: Email
  workflow:
    - get_cell:
        do:
          io.cloudslang.base.excel.get_cell:
            - excel_file_name: '${excel_path}'
            - worksheet_name: '${sheet}'
            - has_header: 'Yes'
            - first_row_index: '0'
            - row_index: '0:1000'
            - column_index: '0:100'
            - row_delimiter: '|'
            - column_delimiter: ','
            - password_header: '${password_header}'
            - email_header: '${email_header}'
            - name_header: '${name_header}'
            - login_header: '${login_header}'
        publish:
          - data: '${return_result}'
          - header
          - login_index: "${str(header.split(',').index(login_header))}"
          - password_index: "${str(header.split(',').index(password_header))}"
          - email_index: "${str(header.split(',').index(email_header))}"
          - name_index: "${str(header.split(',').index(name_header))}"
        navigate:
          - SUCCESS: register_account_flow
          - FAILURE: on_failure
    - register_account_flow:
        loop:
          for: 'row in data.split("|")'
          do:
            web_action.register_account_flow:
              - username: '${row.split(",")[int(login_index)]}'
              - password: '${row.split(",")[int(password_index)]}'
              - first_name: '${row.split(",")[int(name_index)].split()[0]}'
              - last_name: '${row.split(",")[int(name_index)].split()[-1]}'
              - email: '${row.split(",")[int(email_index)]}'
          break:
            - FAILURE
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      register_account_flow:
        x: 240
        'y': 200
        navigate:
          55efe908-fcd0-c5a3-a62d-73ab4c99bd0f:
            targetId: e20b8f8d-7f93-c810-b455-7af5fc183c46
            port: SUCCESS
      get_cell:
        x: 80
        'y': 200
    results:
      SUCCESS:
        e20b8f8d-7f93-c810-b455-7af5fc183c46:
          x: 400
          'y': 200
