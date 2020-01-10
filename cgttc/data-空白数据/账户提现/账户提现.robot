*** Settings ***
Library  pylib.interface.cgt.MchsubCreateLib
Library  pylib.interface.cgt.MchsubBindBankcardPrivateLib
Library  pylib.interface.cgt.MchaccntWithdrawLib
Library  pylib.public.cgt.DBHelper
Variables  config.py

*** Test Cases ***
# 注：以下绑定的银行卡都是对私的用例

子商户账户为空 -tc00251
        # 1.子商户账户为空
        ${result}=  check_mch_accnt_no_mchaccnt_withdrawLib
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{账户号}'

订单号为空 -tc00252
        # 2.订单号为空
        ${result}=  check_order_no_mchaccnt_withdrawLib
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{订单号}'

银行卡号为空 -tc00253
        # 3.银行卡号为空
        ${result}=  check_card_no_mchaccnt_withdrawLib
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{银行卡号}'

提现金额为空 -tc00254
        # 4.提现金额为空
        ${result}=  check_amount_no_mchaccnt_withdrawLib
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{提现金额}'

代付类型为空 -tc00255
        # 5.代付类型为空
        ${result}=  check_type_no_mchaccnt_withdrawLib
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{代付类型}'

异步回调地址为空 -tc00256
        # 6.异步回调地址为空
        ${result}=  check_notify_url_no_mchaccnt_withdrawLib
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{异步回调地址}'

大小额行号为空 -tc00257
        # 7.异步回调地址为空
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
        # 传入子商户账户进行判断大小额行号
        ${result2}=  check_card_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}  ${card_no}
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        ${biz_content2}=  set variable  &{result2}[biz_content]
        ${status}=  set variable  &{biz_content2}[status]
        should be true  $status=='3'

子商户账户正常提现 - tc00258
        # 8.账户提现正常
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
        # 进行账户提现
        ${wdResult}=  get_response_mchaccnt_withdrawLib2  ${mch_accnt_no}  ${card_no}  1  RPAYM  ${notify_url}  104100000004
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

传不存在的子商户账户号 -tc00259
        # 9.传不存在的子商户账户号
        ${result}=  check_mch_accnt_no_not_exists_mchaccnt_withdrawLib  Tabc
        should be true  $result['code']=='301'
        should be true  $result['message']=='银行卡信息不存在'

传其他平台的子商户账户号 -tc00260
        # 10.传不存在的子商户账户号
        ${result}=  check_mch_accnt_no_not_exists_mchaccnt_withdrawLib  T0020190906181127000649
        should be true  $result['code']=='301'
        should be true  $result['message']=='银行卡信息不存在'

子商户账户和卡号信息不一致 -tc00261
        # 11.传不存在的子商户账户号
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
        # 进行子商户账户提现
        ${wdResult}=  check_card_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}  6217003810041609317
        should be true  $wdResult['code']=='301'
        should be true   $wdResult['message']=='银行卡信息不存在'

子商户未绑定银行卡 -tc00262
        # 12.子商户未绑定银行卡
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
        # 进行账户提现
        ${result2}=  check_mch_accnt_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}
        should be true  $result2['code']=='301'
        should be true  $result2['message']=='银行卡信息不存在'

传相同的订单号(使用已请求成功过的订单号) -tc00263
        # 13.传相同的订单号(使用已请求成功过的订单号)
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
        ${result}=  check_order_no_same_mchaccnt_withdrawLib  ${mch_accnt_no}  on1234
        should be true  $result['code']=='305'
        should be true  $result['message']=='订单号重复，请勿重复提交'

传不存在的银行卡号 -tc00264
        # 14. 传不存在的银行卡号
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
        # 进行账户提现
        ${result3}=  check_card_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}  12356789
        should be true  $result3['code']=='301'
        should be true  $result3['message']=='银行卡信息不存在'

传银行卡号为负数 -tc00265
        # 15. 传银行卡号为负数
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
        # 进行账户提现
        ${result3}=  check_card_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}  -6217866300004303385
        should be true  $result3['code']=='301'
        should be true  $result3['message']=='银行卡信息不存在'

传银行卡号长度为2 tc00266
        # 16. 传银行卡号长度为2
        ${result}=  check_card_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}  12
        should be true  $result['code']=='301'
        should be true  $result['message']=='银行卡信息不存在'

传银行卡号超长长度 tc00267
        # 17. 传银行卡号超长长度
        ${result}=  check_card_no_not_exists_mchaccnt_withdrawLib  ${mch_accnt_no}  621786630000430338512346789123
        should be true  $result['code']=='301'
        should be true  $result['message']=='银行卡信息不存在'

子商户账号不存在 -tc00268
        # 18.子商户账号不存在:T0020191216191030000000  该商户在数据库中不存在
        ${result}=  get_response_mchaccnt_withdrawLib  T0020191216191030000000  on1234  6214835498324017  1
                                      ...  RPAYM  http://172.16.202.163:3054/api/bankcard/notify.htm  104100000004
        should be true  $result['code']=='203'
        should be true  $result['message']=='子商户账号不存在'

传不存在的bsbank_no -tc000269
        # 19.传不存在的bsbank_no：对私，其他参数正确
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
        # 进行账户提现
        ${wdResult}=  check_bsbank_no_mchaccnt_withdrawLib  ${mch_accnt_no}  123
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

传type为值为RPAYM -tc00270
        # 20.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  param
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

传type为值为HOH -tc00271
        # 21.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  HOH
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

传type为值为SUPER -tc00272
        # 22.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  SUPER
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

传type为值为SUPER，提现金额5万 -tc00273
        # 23.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_and_amount_mchaccnt_withdrawLib  ${mch_accnt_no}  SUPER  5000000
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

传type为值为SUPER，提现金额5.1万 -tc00274
        # 24.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_and_amount_mchaccnt_withdrawLib  ${mch_accnt_no}  SUPER  5000100
        should be true  $wdResult['code']=='406'
        should be true  $wdResult['message']=='超级网银限额5万'

传不存在的type值为 -tc00275
        # 25.传type为值为RPAYM(对私，其他参数正确)  abc123
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  abc123
        should be true  $wdResult['code']=='405'
        should be true  $wdResult['message']=='代付类型不合法'

传type值为特殊字符 -tc00276
        # 26.传type为值为RPAYM(对私，其他参数正确)  ！@#￥%
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  ！@#￥%
       should be true  $wdResult['code']=='405'
        should be true  $wdResult['message']=='代付类型不合法'

传type为值为小写rpaym -tc00277
        # 27.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  rpaym
        should be true  $wdResult['code']=='405'
        should be true  $wdResult['message']=='代付类型不合法'

传type为值为小写hoh -tc00278
        # 28.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  rpaym
        should be true  $wdResult['code']=='405'
        should be true  $wdResult['message']=='代付类型不合法'

传type为值为小写super -tc00279
        # 29.传type为值为RPAYM(对私，其他参数正确)  RPAYM   HOH  SUPER
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
        # 进行判断
        ${wdResult}=  check_type_mchaccnt_withdrawLib  ${mch_accnt_no}  rpaym
        should be true  $wdResult['code']=='405'
        should be true  $wdResult['message']=='代付类型不合法'

传错误格式的异步通知地址 -tc00280
        # 30.传错误格式的异步通知地址
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
        # 进行判断
        ${wdResullt}=  check_notify_url_mchaccnt_withdrawLib  ${mch_accnt_no}  http://abc.com
        should be true  $wdResult['code']=='0000'
        should be true  $wdResult['message']=='success'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        should be true  $status=='3'

提现金额小于手续费(配置了手续费且非分润提现账户) -tc00281
        # 31.提现金额小于手续费(配置了手续费且非分润提现账户)
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 获取商户号mch_no
        ${mch_no}=  set variable  &{result}[mch_no]
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000
        ${sql_amount}=  update amount sql  ${mch_accnt_no}
        # 手动更新mch表中的通道手续费fixed_poundage
        ${modify_fixed_poundage}=  modify_fixed_poundage  1000  ${mch_no}  cib
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
        # 进行判断
        ${wdResult}=  check_amount_mchaccnt_withdrawLib  ${mch_accnt_no}  ${card_no}  900
        should be true  $wdResult['code']=='402'
        should be true  $wdResult['message']=='提现金额小于等于提现手续费，无法提现'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        ${errmsg}=  set variable  &{biz_content3}[errmsg]
        should be true  $status=='2'
        # 再次手动还原mch表中的通道手续费fixed_poundage
        ${restore_fixed_poundage}=  modify_fixed_poundage  0  ${mch_no}  cib

提现金额等于手续费(配置了手续费且非分润提现账户) -tc00282
        # 32.提现金额小于手续费(配置了手续费且非分润提现账户)
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为10000000
        ${sql_amount}=  update amount sql  10000000  10000000  ${mch_accnt_no}
        # 手动更新mch表中的通道手续费fixed_poundage
        ${fixed_poundage}=  modify_fixed_poundage  1000  ${mch_no}  cib
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
        # 进行判断
        ${wdResult}=  check_amount_mchaccnt_withdrawLib  ${mch_accnt_no}  ${card_no}  1000
        should be true  $wdResult['code']=='402'
        should be true  $wdResult['message']=='提现金额小于等于提现手续费，无法提现'
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]
        ${errmsg}=  set variable  &{biz_content3}[errmsg]
        should be true  $status=='2'
        # 再次手动还原mch表中的通道手续费fixed_poundage
        ${restore_fixed_poundage}=  modify_fixed_poundage  0  ${mch_no}  cib

提现金额大于手续费并且小于等于提现账户结算余额 -tc00283
        # 33.提现金额大于手续费并且小于等于提现账户结算余额(配置了手续费且非分润提现账户)
        sleep  1s
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为1000000
        ${sql_amount}=  update amount sql  10000000  10000000  ${mch_accnt_no}
        # 手动更新mch表中的通道手续费fixed_poundage
        ${fixed_poundage}=  modify_fixed_poundage  1000  ${mch_no}  cib
        # 对私：对子商户绑定银行卡${mch_accnt_no}
        ${result2}=  get response mchsub bind bankcard private  ${mch_accnt_no}  1  6217866300004303385  中国银行  中国银行支行
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
        # 进行判断：提现10块钱
        ${wdResult}=  check_amount_mchaccnt_withdrawLib  ${mch_accnt_no}  ${card_no}  10000
        # 校验是否提现成功
        should be true  $result2['code']=='0000'
        should be true  $result2['message']=='success'
        # 校验表中各字段数据是否符合预期
        ${biz_content3}=  set variable  &{wdResult}[biz_content]
        ${status}=  set variable  &{biz_content3}[status]   # 提现状态
        ${amount}=  set variable  &{biz_content3}[amount]   # 提现金额
        ${trans_fee}=  set variable  &{biz_content3}[trans_fee]     # 提现需要扣除的手续费
        ${accnt_amt_after}=  set variable  &{biz_content3}[accnt_amt_after]     # 事后余额
        should be true  $status=='3'
        should be true  $amount==10000
        should be true  $trans_fee==1000
        should be true  $accnt_amt_after==9990000
        # 再次手动还原mch表中的通道手续费fixed_poundage
        ${restore_fixed_poundage}=  modify_fixed_poundage  0  ${mch_no}  cib

#提现金额大于提现账户结算余额 -tc00284
         # 34.提现金额大于提现账户结算余额(1、未配置手续费且非分润提现账户2、未开启超额提现开关)



#跨行转账为填写bsbank_no -tc00268
#        # 18. 跨行转账为填写bsbank_no
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
#        # 绑定其他银行
#        ${result2_1}=  get response mchsub bind bankcard private  ${mch_accnt_no}  1  6217866300004303385  建设银行  建设银行支行
#                                                                            ...  余道友  18158857961  http://172.16.202.160:3054/api/bankcard/notify.htm
#                                                                            ...  0  342423196910292879  0  105100000017  123  2100-01-01  0
#        should be true  $result2_1['code']=='0000'
#        should be true  $result2_1['message']=='success'
#        # 获取绑定银行卡成功的返回报文
#        ${biz_content2_1}=  set variable  &{$result2_1}[biz_content]
#        ${card_no_2}=  set variable  &{biz_content2_1}[card_no]
#        ${remark_2}=  set variable  &{biz_content2_1}[remark]
#        ${status_2}=  set variable  &{biz_content2_1}[status]
#        should be true  $remark_2=='绑卡成功'
#        should be true   $status_2=='success'
#        # 对第二个账户进行修改，修改字段：bank_no、bank_name、bank_branch_name
#        ${update_bank}=  update_bank_sql
#        # 进行账户提现
#        ${wdResult}=  get_response_mchaccnt_withdrawLib2  ${mch_accnt_no}  ${card_no}  1  RPAYM  ${notify_url}  104100000004
#        should be true  $wdResult['code']=='0000'
#        should be true  $wdResult['message']=='success'
#        ${biz_content3}=  set variable  &{wdResult}[biz_content]
#        ${status}=  set variable  &{biz_content3}[status]
#        should be true  $status=='3'


