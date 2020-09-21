import paramiko
import os

host = os.getenv('VM_IP')
password = os.getenv('SSH_PASS')
username = "env0"
port = 22


command = '''python -c "
import SimpleHTTPServer
import SocketServer

PORT = 8000
Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
httpd = SocketServer.TCPServer(('', PORT), Handler)
print 'serving at port', PORT
httpd.serve_forever()
"
'''

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, port, username, password)

stdin, stdout, stderr = ssh.exec_command(command)
lines = stdout.readlines()
print(lines)