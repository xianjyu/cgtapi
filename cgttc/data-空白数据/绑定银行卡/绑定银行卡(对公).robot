*** Settings ***
Library  pylib.interface.cgt.MchsubBindBankcardLib
Library  pylib.interface.cgt.MchsubCreateLib
Variables  config.py

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

校验银行户名 -tc00056
        # 6.校验外部子商户号：check_user_name 为空
        ${result}=  check user name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{户名}'

校验银行支行名称 -tc00057
        # 7.校验银行支行名称：check_bank_branch_name 为空
        # 该用例分两步：1、先请求子商户创建的接口 2、将创建成功后的子商户账号返回给绑定银行卡的接口
        # 第一步
        sleep  1s
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
        # 10.分为两步，第一步先创建子商户，第二步创建成功后的报文中mch_accnt_no取出来
        sleep  1s
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

传入相同的订单号 -tc00063
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

传入银行卡账户类型为2 - tc00064
        # 14.校验银行卡账户类型：check_card_accnt_type_validity(param)
        ${result}=  check card accnt type validity  2
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡账户类型无效}'

传入银行卡账户类型为-1 -tc00065
        # 15.校验银行卡账户类型：check_card_accnt_type_validity(param)
        ${result}=  check card accnt type validity  -1
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡账户类型无效}'

传入银行卡账户类型为其他字符 -tc00066
        # 16.校验银行卡账户类型：check_card_accnt_type_validity(param)
        ${result}=  check card accnt type validity  ab%%
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡账户类型无效}'

传入银行卡号为负的数字 -tc00067
        # 17.校验银行卡卡号：check_card_no_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check card no validity  ${mch_accnt_no}  -12346
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入银行卡号为其他字符类型 -tc00068
        # 18.校验银行卡卡号：check_card_no_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check card no validity  ${mch_accnt_no}  abcdefg
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入银行卡号超长度 -tc00069
        # 19.校验银行卡卡号：check_card_no_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check card no validity  ${mch_accnt_no}  632145623654789999555552233222323545311
        should be true  $result['code']=='500'
        should be true  $result['message']=='未知错误'

传入开户行名称为特殊字符 -tc00070
        # 20.校验开户行名称：check_bank_name_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check bank name validity  ${mch_accnt_no}  $#%$
        should be true  $result['code']=='302'
        should be true  $result['message']=='银行卡信息认证失败{未找到对应机构，不支持该银行！}'

传入开户行名称不存在 -tc00071
        # 21.校验开户行名称：check_bank_name_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check bank name validity  ${mch_accnt_no}  人民银行
        should be true  $result['code']=='302'
        should be true  $result['message']=='银行卡信息认证失败{未找到对应机构，不支持该银行！}'

传入开户行名称带空格 -tc00072
        # 22.校验开户行名称：check_bank_name_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check bank name validity  ${mch_accnt_no}  杭州 银行
        should be true  $result['code']=='302'
        should be true  $result['message']=='银行卡信息认证失败{未找到对应机构，不支持该银行！}'

传入开户行名名称为数字 -tc00073
        # 23.校验开户行名称：check_bank_name_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check bank name validity  ${mch_accnt_no}  123456789
        should be true  $result['code']=='302'
        should be true  $result['message']=='银行卡信息认证失败{未找到对应机构，不支持该银行！}'

传入相同的订单号 -tc00074
        # 24.校验开户行名称：check_order_no_validity(param)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check order no validity  ${mch_accnt_no}  ${order_no}
        should be true  $result['code']=='305'
        should be true  $result['message']=='订单号重复，请勿重复提交'

传入银行卡户名为特殊字符 -tc00075
        # 25.传入银行卡户名为特殊字符：check_user_name_validity(param**)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check user name validity  ${mch_accnt_no}  !@#$
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入银行卡户名为数字 -tc00076
        # 26.传入银行卡户名为数字：check_user_name_validity(param**)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check user name validity  ${mch_accnt_no}  123456789
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入银行支行名称为特殊字符 -tc00077
        # 27.传入银行支行名称为特殊字符：check_bank_branch_name_validity(param**)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check bank branch name validity  ${mch_accnt_no}  @%…………&&
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入银行卡电话长度为负数 -tc00078
        # 28.传入银行卡电话长度为负数：check_card_phone_validity(param**)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check card phone validity  ${mch_accnt_no}  -13989353209
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入银行卡电话长度为13 -tc00079
        # 29.传入银行卡电话长度为13：check_card_phone_validity(param**)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check card phone validity  ${mch_accnt_no}  132989353209
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传入异步通知地址不存在 -tc00080
        # 30.传入银行卡电话长度为12：check_notify_url_validity(param**)
        sleep  1s
        ${addResult}=  mchsub create out mch accnt no not repeat
        should be true  $addResult['code']=='0000'
        should be true  $addResult['message']=='success'
        ${biz_content}=  set variable  &{addResult}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]

        ${result}=  check notify url validity  ${mch_accnt_no}  @&&*
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

