*** Settings ***
Library  pylib.interface.cgt.MchsubEditLib
Library  pylib.public.cgt.DBHelper

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
        # 前提条件：订单号相同，已修改成功后再次请求
        sleep  1s
        ${result}=  get response mchsub edit  yxj2  T0020191121104442000000
                                         ...    13989353206  xianjyu@qq.com
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

        ${result}=  get response mchsub edit  yxj2  T0020191121104442000000
                                         ...  3989353206  xianjyu@qq.com
        should be true  $result['code']=='305'
        should be true  $result['message']=='订单号重复，请勿重复提交'

传不存在的子商户账号 - tc00029
        # 前提条件：传不存在的子商户号：T0020191213182413000108
        ${result}=  get response mchsub edit  yxj2  T0020191213182413000108
                                         ...    13989353206  xianjyu@qq.com
        should be true  $result['code']=='203'
        should be true  $result['message']=='子商户账号不存在'

传不存在的子商户账号 - tc00030
        # 前提条件：传不存在的子商户号(顺网平台下的商户号)：T0020181120112414000007
        ${result}=  get response mchsub edit  yxj2  T0020181120112414000007
                                         ...    13989353206  xianjyu@qq.com
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
        ${result}=  get response mchsub edit  xj2  T0020191121104442000000
                                         ...    13989353206  xianjyu@qq.com
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'
        sleep  1s
        ${result}=  get response mchsub edit  xj2  T0020191121104442000000
                                         ...  13989353206  xianjyu@qq.com
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

订单号相同 - tc00033
        sleep  1s
        ${result}=  get response mchsub edit  yxj2  T0020191121104442000000
                                         ...    13989353206  xianjyu@qq.com
        should be true  $result['code']=='0000'
        should be true  $result['message']=='success'

        ${result}=  get response mchsub edit  yxj2  T0020191121104442000000
                                         ...  3989353206  xianjyu@qq.com
        should be true  $result['code']=='305'
        should be true  $result['message']=='订单号重复，请勿重复提交'


