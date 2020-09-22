import paramiko
import os

host = os.getenv('VM_IP')
password = os.getenv('SSH_PASS')
username = "env0"
ssh_port = 22

http_server_port = os.getenv('TF_VAR_http_server_port')

command = f'''python -c "
import SimpleHTTPServer
import SocketServer

PORT = {http_server_port}
Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
httpd = SocketServer.TCPServer(('', PORT), Handler)

httpd.serve_forever()
" > /dev/null 2>&1 &
'''

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, ssh_port, username, password)

ssh.exec_command(f'sudo kill -9 $(sudo lsof -t -i:{http_server_port})')

transport = ssh.get_transport()
channel = transport.open_session()

channel.exec_command(command)

print(f'serving at http://{host}:{http_server_port}')