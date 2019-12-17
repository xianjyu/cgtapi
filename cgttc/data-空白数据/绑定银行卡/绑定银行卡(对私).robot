*** Settings ***
Library  pylib.interface.cgt.MchsubCreateLib
Library  pylib.interface.cgt.MchsubBindBankcardPrivateLib
Library  pylib.public.cgt.DBHelper

*** Test Cases ***
子商户账户为空 - tc00151
        # 1.子商户账户为空:check_mch_accnt_no_bind_bankcard_private
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 对私：校验子商户账户为空时的判断
        ${result}=  check mch accnt no bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{子商户账号}'

订单号为空 - tc00152
        # 2.订单号为空:check_order_no_bind_bankcard_private()
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 对私：校验订单号为空为空时的判断
        ${result}=  check order no bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{订单号}'

银行卡账户类型为空 - tc00153
        # 3.银行卡账户类型为空:check_card_accnt_type_bind_bankcard_private()
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 对私：银行卡账户类型为空时的判断
        ${result}=  check card accnt type bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡账户类型}'

银行卡号为空 - tc00154
        # 4.银行卡号为空:check_card_no_bind_bankcard_private()
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result}=  check card no bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡号}'

开户行名称为空 - tc00155
        # 5.开户行名称为空:check_bank_name_bind_bankcard_private()
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result}=  check bank name bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{开户行名称}'

开户行名称为空 - tc00156
        # 5.开户行名称为空:check_bank_name_bind_bankcard_private()
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result}=  check bank name bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{开户行名称}'












#账户提现正常 - tc00200
#        # 正常创建子商户
#        ${result}=  mchsub create out mch accnt no not repeat
#        should be true  $result['code']=='0000'
#        should be true  $result['message']=='success'
#        # 把获取到的biz_content交给变量
#        ${biz_content}=  set variable  &{result}[biz_content]
#        # 获取mch_accnt_no
#        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
#        # 手动更新子商户账户剩余资金和已结算余额分别为1000
#        ${sql_amount}=  update amount sql  ${mch_accnt_no}
#        # 对私：对子商户绑定银行卡${mch_accnt_no}
#        ${result2}=  get response mchsub bind bankcard private  ${mch_accnt_no}  1  6217866300004303385  中国银行  中国银行支行
#                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
#                                                                            ...  0  342423196910292879  0  104100000004  123  2100-01-01  0
#        should be true  $result2['code']=='0000'
#        should be true  $result2['message']=='success'
#        # 获取绑定银行卡成功的返回报文
#        ${biz_content2}=  set variable  &{result2}[biz_content]
#        ${card_no}=  set variable  &{biz_content2}[card_no]
#        ${remark}=  set variable  &{biz_content2}[remark]
#        ${status}=  set variable  &{biz_content2}[status]
#        should be true  $remark=='绑卡成功'
#        should be true   $status=='success'

