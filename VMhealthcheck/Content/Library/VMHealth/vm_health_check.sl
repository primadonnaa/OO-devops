namespace: VMHealth
flow:
  name: vm_health_check
  inputs:
    - ipaddress: 172.16.11.26
    - username: root
    - password:
        default: opentext
        sensitive: true
  workflow:
    - free_stat:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: free
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - free_value: '${standard_out}'
        navigate:
          - SUCCESS: vm_stat
          - FAILURE: on_failure
    - vm_stat:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: vmstat
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - vmstat_value: '${standard_out}'
        navigate:
          - SUCCESS: disk_stat
          - FAILURE: on_failure
    - disk_stat:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: df
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - disk_value: '${standard_out}'
        navigate:
          - SUCCESS: write_log
          - FAILURE: on_failure
    - write_log:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: |-
                rm -rf /tmp/vmhealth && mkdir /tmp/vmhealth && {
                    echo "$free_value" >> /tmp/vmhealth/vmhealth.log
                    echo "$vmstat_value" >> /tmp/vmhealth/vmhealth.log
                    echo "$disk_value" >> /tmp/vmhealth/vmhealt.log
                }
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish: []
        navigate:
          - SUCCESS: send_mail
          - FAILURE: on_failure
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: localhost
            - port: '25'
            - from: sheetal@ot.com
            - to: stephen@ot.com
            - subject: VM Health Report
            - body: |-
                ${'''Hello all,

                Pls find the H repoortt for VM!

                Free Space:
                %s

                vmstat details:
                %s

                Disk details:
                %s

                Thx
                ''' % (free_value, vmstat_value, disk_value)}
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      free_stat:
        x: 120
        'y': 280
      disk_stat:
        x: 440
        'y': 280
      vm_stat:
        x: 280
        'y': 280
      write_log:
        x: 560
        'y': 280
      send_mail:
        x: 760
        'y': 280
        navigate:
          27909cc2-7f82-eb88-8b82-3f1d053f3a5e:
            targetId: baf8bc7b-5463-1117-117d-54b5d7ab5927
            port: SUCCESS
    results:
      SUCCESS:
        baf8bc7b-5463-1117-117d-54b5d7ab5927:
          x: 960
          'y': 280
