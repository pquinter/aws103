from IPython.lib import passwd

input_msg = """
Please type in your password and press enter when done.
You will need this to login to your jupyter notebook from your web browser,
so make sure to write it down!\n
Your password --->"""
# get user's password
password = input(input_msg)
password_verif = input("Confirm your password --->")
while any((password != password_verif, len(password)<1)):
    password = input("That didn't seem right, please try again.\nYour password --->")
    password_verif = input("Confirm your password --->")
# create password hash
password = passwd(password)
jupyterconfig = \
"""c = get_config()
c.IPKernelApp.pylab = 'inline' 
c.NotebookApp.certfile = u'/home/ec2-user/certs/mycert.pem' 
c.NotebookApp.ip = '*' 
c.NotebookApp.open_browser = False
c.NotebookApp.password = u'{}' 
c.NotebookApp.port = 8888\n""".format(password)
# write it to jupyter config file
with open('/home/ec2-user/.jupyter/jupyter_notebook_config.py', 'r+') as f:
    content = f.read()
    f.seek(0, 0)
    f.write(jupyterconfig + content)
