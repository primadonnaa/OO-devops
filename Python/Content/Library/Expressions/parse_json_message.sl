namespace: Expressions
operation:
  name: parse_json_message
  inputs:
    - json_string
  python_action:
    use_jython: false
    script: |-
      import json
      def execute(json_string):
        data = json.loads(json_string)

        message_id = data['id']
        subject = data['subject']

        emailAddress = data['sender']['emailAddress']
        sender_name = emailAddress['name']
        sender_email = emailAddress['address']

        #todo handle multiple recipients
        emailAddress = data['toRecipients'][0]['emailAddress']
        recipient_name = emailAddress['name']
        recipient_email = emailAddress['address']

        body = data['body']
        content_type = body['contentType']
        content = body['content']

        has_attachments = str(data['hasAttachments'])
        return locals()
  outputs:
    - subject: '${subject}'
    - sender_name: '${sender_name}'
  results:
    - SUCCESS
