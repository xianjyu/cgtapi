*** Settings ***
Library  pylib.interface.cgt.MchsubCreateLib
Library  pylib.public.cgt.DBHelper

*** Test Cases ***
校验子商户名称 - tc00001
        # 1.校验子商户名称为空：mch_accnt_name
        ${result}=  check mch accnt name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{子商户名称}'

校验外部子商户号 - tc00002
        # 2.校验外部子商户号：out_mch_accnt_no
        ${result}=  check out mch accnt no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{外部子商户号}'

校验联系人姓名 - tc00003
        # 3.校验联系人姓名：link_name
        ${result}=  check link name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{联系人}'

校验联系人电话 - tc00004
        # 4.校验联系人电话：link_phone
        ${result}=  check link phone
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{联系电话}'

校验联系人邮箱 - tc00005
        # 5.校验联系人邮箱：link_email
        ${result}=  check link email
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        [Teardown]  delete sql

校验是否开设供应商账户 - tc00006
        # 校验是否开设供应商账户：is——supplier
        ${addResult}=  check is supplier
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        [Teardown]   delete sql

校验是否开设担保商账户 - tc00007
        # 校验是否开设担保商账户
        ${addResult}=  check is assure
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        [Teardown]   delete sql

创建子商户 - tc00008
        # 创建子商户并验证是否创建成功
        ${addResult}=  get response mchsub create  yxj  oman123456789  yxj  13989353209  2451255827@qq.com
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        [Teardown]   delete sql


再次创建子商户 - tc00009
        # 创建子商户并验证是否创建成功并且子商户名称、外部商户号、联系人姓名、联系人电话和联系人邮箱都相同的情况
        ${addResult}=  get response mchsub create  yxj  oman123456789  yxj  13989353209  2451255827@qq.com
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        [Teardown]   delete sql

再次创建(外部子商户相同) - tc00010
       # 前提条件：外部子商户相同的情况下再次请求子商户创建接口
       ${addResult}=  out mch accnt no repeat
       should be true  $addResult['code']=='0000'
       should be true  $addResult['message']=='success'
       ${addResult}=  out mch accnt no repeat
       should be true  $addResult['code']=='205'
       should be true  $addResult['message']=='外部子商户号重复'
       [Teardown]  delete sql

