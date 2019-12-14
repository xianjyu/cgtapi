*** Settings ***
Library  pylib.interface.cgt.MchsubBindBankcardLib
Library  pylib.interface.cgt.MchsubCreateLib
Library  pylib.public.cgt.DBHelper

*** Test Cases ***
校验子商户账号 -tc00051
        # 1.校验外部子商户号：mch_accnt_no 为空
        ${result}=  check mch accnt no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{子商户账号}'

校验银行账户类型 -tc00052
        # 2.校验银行卡账户类型：check_card_accnt_type 为空
        ${result}=  check card accnt type
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡账户类型}'

校验银行卡号 -tc00053
        # 3.校验银行卡号：check_card_no 为空
        ${result}=  check card no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡号}'

校验开户行名称 -tc00054
        # 4.校验开户行名称：check_bank_name 为空
        ${result}=  check bank name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{开户行名称}'

校验订单号 -tc00055
        # 5.校验订单号：check_order_no 为空
        ${result}=  check order no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{订单号}'

校验外部子商户号 -tc00056
        # 6.校验外部子商户号：check_user_name 为空
        ${result}=  check user name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{户名}'

校验银行支行名称 -tc00057
        # 7.校验银行支行名称：check_bank_branch_name 为空
        # 该用例分两步：1、先请求子商户创建的接口 2、将创建成功后的子商户账号返回给绑定银行卡的接口
        # 第一步
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        log  ${mch_accnt_no}
        # 将创建子商户生成的子商户账号交个mch_accnt_no变量，给到get_mch_accnt_no中
        sleep  1s
        ${result}=  get mch accnt no  ${mch_accnt_no}
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

校验银行预留手机号码 -tc00058
        # 8.校验银行预留手机号码：check_card_phone 为空
        ${result}=  check card phone
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行预留手机号码}'

校验异步通知地址 -tc00059
        # 9.校验异步通知地址：check_notify_url 为空
        ${result}=  check notify url
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{异步通知地址}'

正常绑定银行卡(对公) -tc00060
        # 10.分为两步，第一步先创建子商户，第二步创建成功后的报文中mch_accnt_no取出来’
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        ${result}=  get mch accnt no  ${mch_accnt_no}
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传不存在的子商户账号 - tc00061
        # 11.输入一个不存在的子商户号
        ${result}=  get mch accnt no  T123456
        should be true  $result['code']=='203'
        should be true  $result['message']=='子商户账号不存在'


传入其他平台的子商户账号 - tc00062
        # 12.传入其他平台的子商户账号，
        # 顺网平台下的子商户账号：T0020190614154321000001
        ${result}=  get_mch_accnt_no  T0020190614154321000001
        should be true  $result['code']=='203'
        should be true  $result['message']=='子商户账号不存在'

传相同的订单号 -tc00063
        # 13.传相同的订单号：bind_bank_card_same_order_no
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        ${result}=  bind bank card same order no  ${mch_accnt_no}
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        sleep  1s
        ${addResult2}=  mchsub create out mch accnt no not repeat
        should be true  $addResult2['code']=='0000'
        should be true  $addResult2['message']=='success'
        ${biz_content2}=  set variable  &{addResult2}[biz_content]
        ${mch_accnt_no2}=  set variable  &{biz_content2}[mch_accnt_no]
        ${result2}=  bind bank card same order no  ${mch_accnt_no2}
        should be true  $result2['code']=='305'
        should be true  $result2['message']=='订单号重复，请勿重复提交'
