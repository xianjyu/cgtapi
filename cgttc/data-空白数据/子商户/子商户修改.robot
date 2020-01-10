*** Settings ***
Library  pylib.interface.cgt.MchsubEditLib
Variables  config.py

*** Test Cases ***
校验子商户账号名称 - tc00021
        # 校验子商户账号名称：mch_accnt_name
        # 问题：修改mch_accnt_name为空，返回成功，但是数据库中该字段没有为空
        ${result}=  check mch accnt name
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

校验外部子商户号 - tc00022
        # 校验外部子商户号：out_mch_accnt_no
        # 问题：out_mch_accnt_no，返回成功，但是数据库中该字段没有为空
        sleep  1s
        ${result}=  check out mch accnt no
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

校验子商户账号号 - tc00023
        # 校验外部子商户号：out_mch_accnt_no
        ${result}=  check mch accnt no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{子商户号}'

校验订单号 - tc00024
        # 校验外部子商户号：out_mch_accnt_no
        ${result}=  check order no
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{订单号}'

校验联系人姓名 - tc00025
        # 校验外部子商户号：check_link_name
        ${result}=  check link name
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{联系人}'

校验联系人姓名 - tc00026
        # 校验外部子商户号：check_link_phone
        ${result}=  check link phone
        should be true  $result['code']=='101'
        should be true  $result['message']=='必输参数不能为空:{联系电话}'

校验联系人姓名 - tc00027
        # 校验外部子商户号：check_link_email
        sleep  1s
        ${result}=  check link email
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

再次修改(修改成功后) - tc00028
        # 前提条件：传入订单号相同，已修改成功后再次请求
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu  xianjyu  13989353209
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

        ${result}=  get response mchsub edit  xianjyu  xianjyu  13989353209
        should be true  $result['code']=='305'
        should be true  $result['message']=='订单号重复，请勿重复提交'

传不存在的子商户账号 - tc00029
        # 前提条件：传不存在的子商户号：T0020191213182413000108
        ${result}=  mchsub edit mchsub accnt no not exists  T0020191213182413000108
        should be true  $result['code']=='203'
        should be true  $result['message']=='子商户账号不存在'

传不存在的子商户账号 - tc00030
        # 前提条件：传不存在的子商户号(顺网平台下的商户号)：T0020181120112414000007
        ${result}=  mchsub edit mchsub accnt no not exists  T0020181120112414000007
        should be true  $result['code']=='203'
        should be true  $result['message']=='子商户账号不存在'

传相同的外部子商户号 - tc00031
        # 前提条件：传相同的外部子商户号:out_mch_accnt_no
        sleep  1s
        ${result}=  same out mch accnt no
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        sleep  1s
        ${result}=  same out mch accnt no
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

传不同的外部子商户号 - tc00032
        # 前提条件：传不同的外部子商户号:out_mch_accnt_no
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu2  xianjyu2  3989353209  xianjyu@qq.com
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu2  xianjyu2  13989353209  xianjyu@qq.com
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

修改子商户账户名称 - tc00033
        # 修改子商户账户名称：mch_accnt_name
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu2  xianjyu2  13989353209
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

修改联系人姓名 - tc00034
        # 修改联系人姓名：link_name
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu2  xianjyu2  13989353209
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

修改联系人电话 - tc00035
        # 修改联系人电话：link_phone
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu2  xianjyu2  13989353206
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

修改联系人邮箱 - tc00036
        # 修改联系人姓名：link_name
        sleep  1s
        ${result}=  get response mchsub edit  xianjyu2  xianjyu2  13989353209  2451255827@qq.ocm
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

# 正常创建子商户 - tc 00037
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


