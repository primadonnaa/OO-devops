namespace: Expressions
flow:
  name: sha1_flow
  workflow:
    - sha1:
        do:
          Expressions.sha1: []
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      sha1:
        x: 160
        'y': 320
        navigate:
          78132010-ccd2-8680-1055-8a1430014a4f:
            targetId: 1bf5362f-52ef-24d3-9f64-8ca8c64b53df
            port: SUCCESS
    results:
      SUCCESS:
        1bf5362f-52ef-24d3-9f64-8ca8c64b53df:
          x: 520
          'y': 320
