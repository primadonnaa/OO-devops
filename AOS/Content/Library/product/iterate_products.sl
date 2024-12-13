namespace: product
flow:
  name: iterate_products
  inputs:
    - json
    - category_name
    - category_id
    - product_id
    - file_path
  workflow:
    - get_product_name:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: "${'$.*.products[?(@.productId == '+product_id+')].productName'}"
        publish:
          - product_name: '${return_result[2:-2]}'
        navigate:
          - SUCCESS: get_product_price
          - FAILURE: on_failure
    - get_product_price:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: "${'$.*.products[?(@.productId == '+product_id+')].price'}"
        publish:
          - product_price: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: get_color_codes
          - FAILURE: on_failure
    - get_color_codes:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: "${'$.*.products[?(@.productId == '+product_id+')].colors.*.code'}"
        publish:
          - color_codes: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: is_excel
          - FAILURE: on_failure
    - add_product:
        do:
          io.cloudslang.base.filesystem.add_text_to_file:
            - file_path: '${file_path}'
            - text: "${\"|\"+\"|\".join([category_id.rjust(13),category_name.ljust(15),product_id.rjust(12),product_name.ljust(51),product_price.rjust(15),color_codes.ljust(60)])+\"|\\n\"}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - is_excel:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '${str(file_path.endswith("xls") or file_path.endswith("xlsx"))}'
        navigate:
          - 'TRUE': add_cell
          - 'FALSE': add_product
    - add_cell:
        do:
          io.cloudslang.base.excel.add_cell:
            - excel_file_name: '${file_path}'
            - worksheet_name: products
            - header_data: "${'Category ID,Category Name,Product ID,Product Name,Product Price,'+','.join(['Color Code'] * 8)}"
            - row_data: "${category_id+','+category_name+','+product_id+','+product_name+','+product_price+','+color_codes}"
            - row_delimiter: '|'
            - column_delimiter: ','
            - overwrite_data: 'false'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      get_product_price:
        x: 520
        'y': 320
      get_product_name:
        x: 320
        'y': 320
      get_color_codes:
        x: 800
        'y': 320
      add_product:
        x: 1000
        'y': 320
        navigate:
          7ea6e630-ca6b-e356-3cb3-a4e37a751f7d:
            targetId: ebdabbbc-841c-5e7d-6cec-c38098242b79
            port: SUCCESS
      is_excel:
        x: 1000
        'y': 120
      add_cell:
        x: 1240
        'y': 120
        navigate:
          55b21f32-f393-77ef-2ce7-77c6492dee60:
            targetId: ebdabbbc-841c-5e7d-6cec-c38098242b79
            port: SUCCESS
    results:
      SUCCESS:
        ebdabbbc-841c-5e7d-6cec-c38098242b79:
          x: 1440
          'y': 200
