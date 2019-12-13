*** Settings ***
Library  pylib.interface.MchsubCreateLib
Library  pylib.public.DBHelper

*** Test Cases ***
添加子商户 - tc00001
        # 创建子商户并验证是否创建成功
        ${addResult}=  get response mchsub create  yxj  yxj  13989353209  2451255827@qq.com
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        [teardown]=  delete sql
