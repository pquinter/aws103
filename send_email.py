import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def send_notification(fromaddr, password, toaddr,
        subject='Message from your Amazon EC2 server',
        body='Your calculation has finished, \nCheers from the Cloud!',
        host='smtp.gmail.com', port=587):
    """ Send an email notification """
    msg = MIMEMultipart()
    msg['From'] = fromaddr
    msg['To'] = toaddr
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))
    server = smtplib.SMTP(host, port)
    server.starttls()
    server.login(fromaddr, password)
    text = msg.as_string()
    server.sendmail(fromaddr, toaddr, text)
    server.quit()
    return None
