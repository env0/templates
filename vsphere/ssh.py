import paramiko
import os

host = os.getenv('VM_IP')
password = os.getenv('SSH_PASS')
username = "env0"
ssh_port = 22

server_port = 8000
command = f'''python -c "
import SimpleHTTPServer
import SocketServer

PORT = {server_port}
Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
httpd = SocketServer.TCPServer(('', PORT), Handler)

httpd.serve_forever()
" &
'''

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, ssh_port, username, password)
transport = ssh.get_transport()
channel = transport.open_session()

stdin, stdout, stderr = channel.exec_command(command)
lines = stdout.readlines()
print(lines)

if stderr is None:
  print(f'serving at port {server_port}')