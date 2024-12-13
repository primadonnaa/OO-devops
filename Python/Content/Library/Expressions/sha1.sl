namespace: Expressions
operation:
  name: sha1
  inputs:
    - text: tests
  python_action:
    use_jython: false
    script: "import hashlib\ndef execute(text): \n return { 'sha1': hashlib.sha1(text.encode('utf-8')).hexdigest() }"
  outputs:
    - sha1: '${sha1}'
  results:
    - SUCCESS
