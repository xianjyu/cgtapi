*** Settings ***
Library  pylib.interface.MchsubCreateLib
Library  pylib.public.DBHelper

Suite Setup    get response mchsub create  yxj  oman123456789  yxj  13989353209  2451255827@qq.com

Suite Teardown    delete sql