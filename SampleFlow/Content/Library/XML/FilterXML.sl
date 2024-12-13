namespace: XML
flow:
  name: FilterXML
  workflow:
    - validate:
        do:
          io.cloudslang.base.xml.validate:
            - xml_document: "C:\\OO220Labs\\XMLSample.xml"
            - xml_document_source: xmlPath
        publish:
          - validated_xml_document: '${xml_document}'
        navigate:
          - SUCCESS: xpath_query
          - FAILURE: on_failure
    - xpath_query:
        do:
          io.cloudslang.base.xml.xpath_query:
            - xml_document: '${validated_xml_document}'
            - xml_document_source: xmlPath
            - xpath_query:
                prompt:
                  type: text
        publish:
          - selected_value
        navigate:
          - SUCCESS: Display_Message
          - FAILURE: on_failure
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message: '${selected_value}'
        navigate:
          - success: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      validate:
        x: 120
        'y': 240
      xpath_query:
        x: 320
        'y': 240
      Display_Message:
        x: 520
        'y': 240
        navigate:
          32c72365-0614-60e0-55eb-fbe0b6e374bf:
            targetId: 954c4c5d-a908-5d13-3741-9e80491f709d
            port: success
    results:
      SUCCESS:
        954c4c5d-a908-5d13-3741-9e80491f709d:
          x: 680
          'y': 240
