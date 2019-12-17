*** Settings ***
Library  pylib.interface.cgt.MchsubBindBankcardLib
Library  pylib.interface.cgt.MchsubBindNstroLib
Library  pylib.interface.cgt.MchsubCreateLib
Library  pylib.public.cgt.DBHelper

*** Test Cases ***
正常请求往账接口 -tc00100
        # 先创建子商户返回子商户账户
        ${result}=  mchsub create out mch accnt no not repeat
        should be true  result['code']=='0000'
        should be true  result['message']=='success'
        # 获取mch_accnt_no
        ${biz_content}=  set variable  &{result}[biz_content]
        ${mch_accnt_no}=  set variable  &{biz_content}[mch_accnt_no]
        # 获取card_no
        ${card_no}=  set variable  &{biz_content}[card_no]
        # 再执行数据库操作进行对其状态修改为成功
        ${sql_result}=  update sql  ${mch_accnt_no}
        # 最后再请求往账接口
#        ${result2}=  get response mchsub bind nstro  ${mch_accnt_no}  ${card_no}  1
#        should be true  $result2['code']=='0000'
#        shloud be true  $result2['message']=='success'

