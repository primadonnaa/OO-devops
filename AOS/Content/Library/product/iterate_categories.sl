namespace: product
flow:
  name: iterate_categories
  inputs:
    - json
    - category_id
    - file_path
  workflow:
    - get_category:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: '${"$[?(@.categoryId == "+category_id+")]"}'
        publish:
          - category_json: '${return_result}'
        navigate:
          - SUCCESS: get_category_name
          - FAILURE: on_failure
    - get_category_name:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${category_json}'
            - json_path: '$.*.categoryName'
        publish:
          - category_name: '${return_result[2:-2]}'
        navigate:
          - SUCCESS: get_product_ids
          - FAILURE: on_failure
    - get_product_ids:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${category_json}'
            - json_path: '$.*.products.*.productId'
        publish:
          - product_ids: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: iterate_products
          - FAILURE: on_failure
    - iterate_products:
        loop:
          for: product_id in product_ids
          do:
            product.iterate_products:
              - json: '${category_json}'
              - category_name: '${category_name}'
              - category_id: '${category_id}'
              - product_id: '${product_id}'
              - file_path: '${file_path}'
          break: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_category:
        x: 240
        'y': 320
      get_category_name:
        x: 520
        'y': 320
      get_product_ids:
        x: 760
        'y': 320
      iterate_products:
        x: 1040
        'y': 320
        navigate:
          4e03259a-aa41-97b0-a052-0c0aeada5ff3:
            targetId: 88c15a96-d15e-221d-a161-ba5a43d51b77
            port: SUCCESS
          7e43ad0b-a907-b8a2-80ac-7192a70b3b74:
            targetId: 25374720-5abc-c3e9-6b47-f2577ffcba93
            port: FAILURE
    results:
      SUCCESS:
        88c15a96-d15e-221d-a161-ba5a43d51b77:
          x: 1280
          'y': 320
      FAILURE:
        25374720-5abc-c3e9-6b47-f2577ffcba93:
          x: 1040
          'y': 600
