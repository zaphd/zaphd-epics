#!/usr/bin/env python3

import smtplib
import datetime
from email.mime.text import MIMEText

# Function to send out email to email list
def sendEmailAlert(emailList, message, subject):

        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login("zaphdexperiment@gmail.com", "NoKinks0316")

        msg = MIMEText(message)

        msg['Subject'] = subject
        msg['From'] = 'zaphdexperiment@gmail.com'

        for i in range(0, len(emailList)):
                msg['To'] = emailList[i]
                server.sendmail("zaphdexperiment@gmail.com", emailList[i], msg.as_string())
                
        server.quit()

# Email list to send out to
emailList = ['webert2@uw.edu', 'shumlak@uw.edu', 'yzhang@zapenergyinc.com',
             'eclaveau@uw.edu', 'egf6@uw.edu', 'nelson@zapenergyinc.com', 'astepano@uw.edu']
#emailList = ['webert2@uw.edu']

HVVCloseMessage = """ZaP-HD High Vacuum Gate Valve is Closed - \n
This message was sent by a python script running on the raspberry pi that interfaces
with the vacuum system (10.10.10.233 on user name pi).\n Please contact Tobin Weber for questions
(webert2@uw.edu, 858-692-1135)"""

#Monday is 0 and Sunday is 6
day = datetime.datetime.today().weekday()
hour = datetime.datetime.today().time().hour

# If it's on the weekend, or not 8am-5pm, send out an alert
if ( (day==5) | (day==6)):
    sendEmailAlert(emailList, HVVCloseMessage, "High Vacuum Gate Valve is Closed")

else:
                        
    if ( (hour > 17) | (hour < 8) ):
        sendEmailAlert(emailList, HVVCloseMessage, "High Vacuum Gate Valve is Closed")
