*** Settings ***
Library  pylib.interface.cgt.MchsubCreateLib
Library  pylib.interface.cgt.MchsubBindBankcardPrivateLib
Library  pylib.interface.cgt.MchaccntWithdrawLib
Library  pylib.interface.cgt.MchaccntPayDispatchLib
Library  pylib.public.cgt.DBHelper
Library  pylib.public.cgt.ComLib
Variables  config.py

*** Test Cases ***
交易流水号为空 -tc00351
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
        ${result}=  check_trans_no_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{[trans_no]参数}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易渠道为空 -tc00352
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
        ${result}=  check_trans_channel_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{[trans_channel]参数}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易金额为空 -tc00353
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
        ${result}=  check_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{[trans_amt]参数}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

结算周期为空 -tc00354
        sleep  1s
        # 正常创建子商户   结算周期非必填
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        ${result}=  check_settle_duration_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

结算方式为空 -tc00355
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
        ${result}=  check_settle_type_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{[settle_type]参数}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

订单号为空 -tc00356
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
        ${result}=  check_order_no_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='210'
        should be true  $result['message']=='必输参数不能为空{order_no}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

子商户账户为空 -tc00357
        ${result}=  check_mch_accnt_no_mchaccnt_pay_dispatch
        should be true  $result['code']=='210'
        should be true  $result['message']=='必输参数不能为空{mch_accnt_no}'

分账类型为空 -tc00358
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
        ${result}=  check_dispatch_type_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='210'
        should be true  $result['message']=='必输参数不能为空{dispatch_type}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

分账事件为空 -tc00359
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
        ${result}=  check_dispatch_event_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='210'
        should be true  $result['message']=='必输参数不能为空{dispatch_event}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易完成时间为空 -tc00360
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
        ${result}=  check_trans_time_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{[trans_time]参数}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

业务类型为空 -tc00361
        sleep  1s
        # 正常创建子商户  非必填
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        ${result}=  check_business_type_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

分账金额为空 -tc00362
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
        ${result}=  check_amount_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='210'
        should be true  $result['message']=='必输参数不能为空{amount}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

事前余额为空 -tc00363
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
        ${result}=  check_accnt_amount_after_mchaccnt_pay_dispatch  ${mch_accnt_no}
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

使用同一个交易流水号 -tc00364
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
        ${result}=  use_same_trans_no_mchaccnt_pay_dispatch  ${mch_accnt_no}  tn201912201642
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        sleep  1s
        ${result}=  use_same_trans_no_mchaccnt_pay_dispatch  ${mch_accnt_no}  tn201912201642
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易流水号不存在 -tc00365
        sleep  1s
        # 注：在支付记账时不校验交易流水号是否是同一个，只校验是否为空
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
        ${result}=  use_same_trans_no_mchaccnt_pay_dispatch  ${mch_accnt_no}  tn_abcdefg!@#$%
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易渠道不存在 -tc00366
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
        ${result}=  use_trans_channel_mchaccnt_pay_dispatch  ${mch_accnt_no}  0000
        should be true  $result['code']=='210'
        should be true  $result['message']=='参数无效:{trans_channel}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易金额为负数 -tc00367
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
        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  -100  100
        should be true  $result['code']=='316'
        should be true  $result['message']=='分账金额有误:{[trans_amt]参数}'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易金额与分账金额不一致 -tc00368
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
        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  10  100
        should be true  $result['code']=='210'
        should be true  $result['message']=='支付记账，交易金额trans_amt和明细金额不一致'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易金额小于分账金额 -tc00369
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
        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  99  100
        should be true  $result['code']=='210'
        should be true  $result['message']=='支付记账，交易金额trans_amt和明细金额不一致'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易金额大于分账金额 -tc00370
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
        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  999  100
        should be true  $result['code']=='210'
        should be true  $result['message']=='支付记账，交易金额trans_amt和明细金额不一致'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

交易金额为0 -tc00371
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
        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  0  100
        should be true  $result['code']=='210'
        should be true  $result['message']=='支付记账，交易金额trans_amt和明细金额不一致'
        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

结算周期为T1 tc00372
        # 正常创建子商户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 获取mch_no
        ${mch_no}=  set variable  &{result}[mch_no]
        # 把获取到的biz_content交给变量
        ${biz_content}=  set variable  &{result}[biz_content]
        # 获取mch_accnt_no
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 手动更新子商户账户剩余资金和已结算余额分别为100000
        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
        ${result}=  use_settle_duration_mchaccnt_pay_dispatch  ${mch_accnt_no}  T1
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        # 存管户账户剩余资金和已结算余额
        ${select_mch_accnt}=  select_mch_accnt  ${mch_no}  ${mch_accnt_no}
        ${get_list}=  get_list  $select_mch_accnt

#        ${delete_mch_accnt_no}=  delete_mch_accnt_no  ${mch_accnt_no}

#结算周期为D1 -tc00373
#        sleep  1s
#        # 正常创建子商户
#        ${result}=  mchsub create out mch accnt no not repeat
#        should be true  $result['code']=='0000'
#        should be true  $result['message']=='success'
#        # 把获取到的biz_content交给变量
#        ${biz_content}=  set variable  &{result}[biz_content]
#        # 获取mch_accnt_no
#        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
#        # 手动更新子商户账户剩余资金和已结算余额分别为100000
#        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
#        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  D+1
#        should be true  $result['code']=='210'
#        should be true  $result['message']=='支付记账，交易金额trans_amt和明细金额不一致'

#结算周期为不存在的类型 -tc00374
#        sleep  1s
#        # 正常创建子商户
#        ${result}=  mchsub create out mch accnt no not repeat
#        should be true  $result['code']=='0000'
#        should be true  $result['message']=='success'
#        # 把获取到的biz_content交给变量
#        ${biz_content}=  set variable  &{result}[biz_content]
#        # 获取mch_accnt_no
#        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
#        # 手动更新子商户账户剩余资金和已结算余额分别为100000
#        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
#        ${result}=  use_trans_amt_mchaccnt_pay_dispatch  ${mch_accnt_no}  abc
#        should be true  $result['code']=='210'
#        should be true  $result['message']=='支付记账，交易金额trans_amt和明细金额不一致'



#正常请求商户支付记账 -tc00351
#        sleep  1s
#        # 正常创建子商户
#        ${result}=  mchsub create out mch accnt no not repeat
#        should be true  $result['code']=='0000'
#        should be true  $result['message']=='success'
#        # 把获取到的biz_content交给变量
#        ${biz_content}=  set variable  &{result}[biz_content]
#        # 获取mch_accnt_no
#        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
#        # 手动更新子商户账户剩余资金和已结算余额分别为100000
#        ${sql_amount}=  update amount sql  100000  100000  ${mch_accnt_no}
#        # 进行商户支付记账
#        ${pdResult}=  get_response_mchaccnt_pay_dispatch  2051  100  D1  1  ${mch_accnt_no}  pay  1  网吧  100  1