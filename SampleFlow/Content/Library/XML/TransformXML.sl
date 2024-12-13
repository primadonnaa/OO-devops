namespace: XML
flow:
  name: TransformXML
  workflow:
    - validate:
        do:
          io.cloudslang.base.xml.validate:
            - xml_document: "C:\\OO220Labs\\books.xml"
            - xml_document_source: xmlPath
        publish:
          - validated_xml_document: '${xml_document}'
        navigate:
          - SUCCESS: convert_to_html
          - FAILURE: on_failure
    - convert_to_html:
        do:
          io.cloudslang.base.xml.apply_xsl_transformation:
            - xml_document: '${validated_xml_document}'
            - xsl_template: "C:\\OO220Labs\\books.xsl"
            - output_file: "C:\\OO220Labs\\books.html"
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
      convert_to_html:
        x: 360
        'y': 280
        navigate:
          9b291f78-b20e-4894-7bb6-a336c954802a:
            targetId: 954c4c5d-a908-5d13-3741-9e80491f709d
            port: SUCCESS
    results:
      SUCCESS:
        954c4c5d-a908-5d13-3741-9e80491f709d:
          x: 520
          'y': 280
