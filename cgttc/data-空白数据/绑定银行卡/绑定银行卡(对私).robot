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
        ${sql_amount}=  update amount sql  1000  1000  ${mch_accnt_no}
        # 对私：校验子商户账户为空时的判断
        ${result}=  check mch accnt no bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{子商户账号}'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

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
        ${sql_amount}=  update amount sql  1000  1000  ${mch_accnt_no}
        # 对私：校验订单号为空为空时的判断
        ${result}=  check order no bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{订单号}'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

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
        ${sql_amount}=  update amount sql  1000  1000  ${mch_accnt_no}
        # 对私：银行卡账户类型为空时的判断
        ${result}=  check card accnt type bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡账户类型}'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

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
        ${sql_amount}=  update amount sql  1000  1000  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result}=  check card no bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡号}'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

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
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  1000  1000  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result}=  check bank name bind bankcard private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{开户行名称}'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

分支行名称为空 - tc00156
        # 6分支行名称为空:check_bank_branch_name_bind_bankcard_private()
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result2}=  check_bank_branch_name_bind_bankcard_private  ${mch_accnt_no}  1  6217866300004303385  中国银行
                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
                                                                            ...  0  342423196910292879  0  104100000004  123  2100-01-01  0
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        # 获取绑定银行卡成功的返回报文
        ${biz_content2}=  set variable  &{result2}[biz_content]
        ${card_no}=  set variable  &{biz_content2}[card_no]
        ${remark}=  set variable  &{biz_content2}[remark]
        ${status}=  set variable  &{biz_content2}[status]
        should be true  $remark=='绑卡成功'
        should be true   $status=='success'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

户名为空 - tc00157
        # 7.户名为空:check_user_name_bind_bankcard_private()
        ${result}=  check_user_name_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{户名}'

银行预留手机号为空 - tc00158
        # 8.银行预留手机号为空:check_user_name_bind_bankcard_private()
        ${result}=  check_card_phone_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行预留手机号码}'

异步通知地址为空 - tc00159
        # 9.异步通知地址为空:check_user_name_bind_bankcard_private()
        ${result}=  check_notify_url_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{异步通知地址}'

证件类型为空 - tc00160
        # 10.异步通知地址为空:check_user_name_bind_bankcard_private()
        ${result}=  check_cert_type_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{证件类型}'

持有人证件号为空 - tc00161
        # 11.持有人证件号为空:check_user_name_bind_bankcard_private()
        ${result}=  check_cert_no_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{持有人证件号}'

银行卡类型为空 - tc00162
        # 12.银行卡类型为空:check_user_name_bind_bankcard_private()
        ${result}=  check_card_type_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡类型}'

银行代码为空 - tc00163
        # 13.银行代码为空
        ${result}=  check_bank_no_bind_bankcard_private
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行代码}'

信用卡cvn为空 - tc00164
        # 14.信用卡cvn为空
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result2}=  check_card_cvn_bind_bankcard_private  ${mch_accnt_no}  1  6217866300004303385  中国银行  中国银行支行
                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
                                                                            ...  0  342423196910292879  0  104100000004  2100-01-01  0
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        # 获取绑定银行卡成功的返回报文
        ${biz_content2}=  set variable  &{result2}[biz_content]
        ${card_no}=  set variable  &{biz_content2}[card_no]
        ${remark}=  set variable  &{biz_content2}[remark]
        ${status}=  set variable  &{biz_content2}[status]
        should be true  $remark=='绑卡成功'
        should be true   $status=='success'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

信用卡有效期为空 - tc00165
        # 15.信用卡有效期为空
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result2}=  check_card_expire_date_bind_bankcard_private  ${mch_accnt_no}  1  6217866300004303385  中国银行  中国银行支行
                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
                                                                            ...  0  342423196910292879  0  104100000004  123  0
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        # 获取绑定银行卡成功的返回报文
        ${biz_content2}=  set variable  &{result2}[biz_content]
        ${card_no}=  set variable  &{biz_content2}[card_no]
        ${remark}=  set variable  &{biz_content2}[remark]
        ${status}=  set variable  &{biz_content2}[status]
        should be true  $remark=='绑卡成功'
        should be true   $status=='success'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

authen_type为空 - tc00166
        # 16.authen_type为空
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        # 对私：银行卡号为空时的判断
        ${result2}=  check_authen_type_bind_bankcard_private  ${mch_accnt_no}  1  6217866300004303385  中国银行  中国银行支行
                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
                                                                            ...  0  342423196910292879  0  104100000004  123  2100-01-01
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        # 获取绑定银行卡成功的返回报文
        ${biz_content2}=  set variable  &{result2}[biz_content]
        ${card_no}=  set variable  &{biz_content2}[card_no]
        ${remark}=  set variable  &{biz_content2}[remark]
        ${status}=  set variable  &{biz_content2}[status]
        should be true  $remark=='绑卡成功'
        should be true   $status=='success'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}

账户提现正常 - tc00200
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
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        # 对私：对子商户绑定银行卡${mch_accnt_no}
        ${result2}=  get response mchsub bind bankcard private  ${mch_accnt_no}  1  6217866300004303385  中国银行  中国银行支行
                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
                                                                            ...  0  342423196910292879  0  104100000004  123  2100-01-01  0
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        # 获取绑定银行卡成功的返回报文
        ${biz_content2}=  set variable  &{result2}[biz_content]
        ${card_no}=  set variable  &{biz_content2}[card_no]
        ${remark}=  set variable  &{biz_content2}[remark]
        ${status}=  set variable  &{biz_content2}[status]
        should be true  $remark=='绑卡成功'
        should be true   $status=='success'
        ${sql_amount}=  update amount sql  0  0  ${mch_accnt_no}


