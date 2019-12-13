*** Settings ***
Library  pylib.interface.MchsubCreateLib

Suite Setup  get response mchsub create  yxj  yxj  13989353209  2451255827@qq.com
Suite Teardown  delete sql
