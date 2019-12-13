*** Settings ***
Library  pylib.interface.MchsubCreateLib
Library  pylib.public.DBHelper

*** Test Cases ***
校验子商户名称 - tc00001
        # 1.校验子商户名称为空：mch_accnt_name
        ${result}=  check mch accnt name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{子商户名称}'
        [teardown]  delete sql

校验外部子商户号 - tc00002
        # 2.校验外部子商户号：out_mch_accnt_no
        ${result}=  check out mch accnt no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{外部子商户号}'

校验联系人姓名 - tc00003
        # 3.校验外部子商户号：link_name
        ${result}=  check link name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{联系人}'

校验联系人电话 - tc00004
        # 4.校验外部子商户号：link_phone
        ${result}=  check link phone
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{联系电话}'

校验联系人邮箱 - tc00005
        # 5.校验外部子商户号：link_email
        ${result}=  check link email
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        [Teardown]  delete sql

添加子商户 - tc00006
        # 创建子商户并验证是否创建成功
        ${addResult}=  get response mchsub create  yxj  yxj  13989353209  2451255827@qq.com
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        [Teardown]   delete sql

再次创建 - tc00007
       """
       前提条件：外部子商户相同的情况下再次请求子商户创建接口
       """
       ${addResult}=  out mch accnt no repeat
       should be true  $addResult['code']=='0000'
       should be true  $addResult['message']=='success'
       ${addResult}=  out mch accnt no repeat
       [Teardown]  delete sql
