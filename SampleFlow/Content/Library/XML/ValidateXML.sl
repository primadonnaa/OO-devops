namespace: XML
flow:
  name: ValidateXML
  workflow:
    - validate:
        do:
          io.cloudslang.base.xml.validate:
            - xml_document: "C:\\OO220Labs\\XMLSample.xml"
            - xml_document_source: xmlPath
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      validate:
        x: 200
        'y': 280
        navigate:
          c3cfab2b-2024-b169-a152-20bc5a551975:
            targetId: 954c4c5d-a908-5d13-3741-9e80491f709d
            port: SUCCESS
    results:
      SUCCESS:
        954c4c5d-a908-5d13-3741-9e80491f709d:
          x: 520
          'y': 280
