# -*- coding: utf-8 -*
import smtplib
from email.mime.text import MIMEText

mailto_list=['yunwei@huimin100.cn']        #收件人(列表)
mail_host="smtp.163.com"            #使用的邮箱的smtp服务器地址
mail_user="18201019599@163.com"                           #用户名
mail_pass="qishanrong1234"                             #密码
mail_postfix="163.com"                     #邮箱的后缀
def send_mail(to_list,sub,content):
    me="warning"+"<"+mail_user+"@"+mail_postfix+">"
    msg = MIMEText(content,_subtype='plain')
    msg['Subject'] = sub
    msg['From'] = me
    msg['To'] = ";".join(to_list)                #将收件人列表以‘；’分隔
    try:
        server = smtplib.SMTP()
        server.connect(mail_host)                            #连接服务器
        server.login(mail_user,mail_pass)               #登录操作
        server.sendmail(me, to_list, msg.as_string())
        server.close()
        return True
    except Exception, e:
        print str(e)
        return False

send_mail(mailto_list,"backup failure","123.56.182.0 mysql backup failure!")
