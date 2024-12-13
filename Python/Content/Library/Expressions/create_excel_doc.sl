namespace: Expressions
operation:
  name: create_excel_doc
  inputs:
    - sheet_name: sheet1
    - header_data
    - file_name
  python_action:
    use_jython: false
    script: "def execute(file_name, sheet_name, header_data):\n\tinstall()\n\timport openpyxl\n\tfrom openpyxl import Workbook\n\twb = Workbook()\n\tsheet = wb.active\n\tif (sheet_name is None):\n\t\tsheet_name = 'Sheet1'\n\tsheet.title = sheet_name\n\tif (header_data is not None):\n\t\tsheet.append(eval(header_data))\n\twb.save(file_name)\ndef install():\n\timport subprocess\n\timport sys\n\timport ssl\n\tproxy = \"\"\n\tpackages = \"openpyxl\"\n\tpip_cmd = \"install\"\n\tfor package in packages.split(\",\"):\n\t\tsubprocess.check_call([sys.executable, \"-m\", \"pip\", \"--proxy\", proxy, pip_cmd, package])"
  results:
    - SUCCESS
