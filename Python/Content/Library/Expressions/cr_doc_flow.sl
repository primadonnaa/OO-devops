namespace: Expressions
flow:
  name: cr_doc_flow
  workflow:
    - create_excel_doc:
        do:
          Expressions.create_excel_doc:
            - sheet_name: Sheet1
            - header_data: '["column1","column2"]'
            - file_name: "C:\\temp\\file.xlsx"
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      create_excel_doc:
        x: 160
        'y': 280
        navigate:
          bb949351-2468-58d8-4349-f6967b50d2f5:
            targetId: 350d3467-c77c-dd0e-c043-9c0af1d1e0bf
            port: SUCCESS
    results:
      SUCCESS:
        350d3467-c77c-dd0e-c043-9c0af1d1e0bf:
          x: 440
          'y': 280
