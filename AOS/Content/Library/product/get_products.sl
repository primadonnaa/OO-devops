namespace: product
flow:
  name: get_products
  inputs:
    - aos_url: 'http://oo-vm02.itomlabs.com:8082/'
    - file_path: "c:\\temp\\products.xlsx"
  workflow:
    - http_client_get:
        do:
          io.cloudslang.base.http.http_client_get:
            - url: 'http://oo-vm02.itomlabs.com:8082//catalog/api/v1/categories/all_data'
        publish:
          - json: '${return_result}'
        navigate:
          - SUCCESS: is_excel
          - FAILURE: on_failure
    - write_header:
        do:
          io.cloudslang.base.filesystem.write_to_file:
            - file_path: '${file_path}'
            - text: "${'+'+'+'.join([''.center(13,'-'),''.center(15,'-'),''.center(12,'-'),''.center(51,'-'),''.center(15,'-'),''.center(60,'-')])+'+\\n'+\\\n'|'+'|'.join(['Category ID'.center(13),'Category Name'.center(15),'Product ID'.center(12),'Product Name'.center(51),'Product Price'.center(15),'Color Codes'.center(60)])+'|\\n'+\\\n'+'+'+'.join([''.center(13,'-'),''.center(15,'-'),''.center(12,'-'),''.center(51,'-'),''.center(15,'-'),''.center(60,'-')])+'+\\n'}"
        navigate:
          - SUCCESS: get_categories
          - FAILURE: on_failure
    - get_categories:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: '$.*.categoryId'
        publish:
          - category_id_list: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: iterate_categories
          - FAILURE: on_failure
    - iterate_categories:
        loop:
          for: category_id in category_id_list
          do:
            product.iterate_categories:
              - json: '${json}'
              - category_id: '${category_id}'
              - file_path: '${file_path}'
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - is_excel:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '${str(file_path.endswith("xls") or file_path.endswith("xlsx"))}'
        navigate:
          - 'TRUE': delete
          - 'FALSE': write_header
    - delete:
        do:
          io.cloudslang.base.filesystem.delete:
            - source: '${file_path}'
        navigate:
          - SUCCESS: create_excel_file
          - FAILURE: create_excel_file
    - create_excel_file:
        do:
          io.cloudslang.base.excel.create_excel_file:
            - excel_file_name: '${file_path}'
            - worksheet_names: products
        navigate:
          - SUCCESS: get_categories
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_get:
        x: 120
        'y': 280
      write_header:
        x: 360
        'y': 280
      get_categories:
        x: 560
        'y': 280
      iterate_categories:
        x: 760
        'y': 280
        navigate:
          67c57568-24ec-fe9c-ddda-328a509e240d:
            targetId: 42139cb9-6144-b82c-a964-2865cca88932
            port: SUCCESS
      is_excel:
        x: 240
        'y': 280
      delete:
        x: 240
        'y': 80
      create_excel_file:
        x: 440
        'y': 80
    results:
      SUCCESS:
        42139cb9-6144-b82c-a964-2865cca88932:
          x: 920
          'y': 280
