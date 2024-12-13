namespace: product
flow:
  name: send_query
  inputs:
    - category_f
    - product_f
    - email_f
    - subject_f
  workflow:
    - send_query_act:
        do:
          product.send_query_act:
            - category: '${category_f}'
            - product: '${product_f}'
            - email: '${email_f}'
            - subject: '${subject_f}'
        publish:
          - send_status
        navigate:
          - SUCCESS: string_equals
          - WARNING: string_equals
          - FAILURE: on_failure
    - string_equals:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${send_status}'
            - second_string: Thank you for contacting Advantage support.
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      string_equals:
        x: 320
        'y': 200
        navigate:
          4fb8fa6a-aaf7-cd6c-6581-c07adc4d2c9c:
            targetId: deb26dbc-62db-5e1c-d7f4-82ef164a25d6
            port: SUCCESS
      send_query_act:
        x: 160
        'y': 200
    results:
      SUCCESS:
        deb26dbc-62db-5e1c-d7f4-82ef164a25d6:
          x: 480
          'y': 200
