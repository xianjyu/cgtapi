# 存管通测试环境URL
cgt_test_env_url = 'http://172.16.202.160:3054/api/deposit.htm'
# cgt_test_env_url = 'http://172.16.202.163:3054/api/deposit.htm'
# 存管通预发布环境URL
# cgt_pre_env_url = 'http://172.16.202.163:3054/api/deposit.htm'
# 工保网测试环境URL
gbw_test_env_url = ''
# 签名类型
sign_type = 'MD5'
# 测试专户号
mch_no = 'MH20181229115220NBUu'
# 子商户账号
mch_accnt_no = 'T0020191214172318000328'
# 订单号,每次运行全部用例需要更改，只针对用例tc00063、tc00074
order_no = '201912142102'
# 接口类型
biz_type = ['mchsub.create', 'mchsub.edit', 'mchsub.bind.bankcard', 'mchsub.bind.nostro', 'mchaccnt.bind.notify',
            'mchaccnt.withdraw', 'mchaccnt.pay.dispatch']
# 测试环境对应的token
# token = '9b389216c3c55a7c535510b33b9e6eb7'
# 预发布环境对应的token
token = '9b389216c3c55a7c535510b3ghlhhhhh'

# 异步通知地址
notify_url = 'http://172.16.202.163:3054/api/bankcard/notify.htm'

# 测试环境数据库参数
localhost = '172.16.202.160'
username = 'yuxianjia'
password = 'yuxianjia'
database = 'deposit'

# 测试环境数据库参数
# localhost = '172.16.202.162'
# username = 'yuxianjia'
# password = 'yuxianjia'
# database = 'deposit'


gbw_biz_type = ['mchaccnt.submit.order', 'mchaccnt.change.notify', 'mchaccnt.match',
                'mchaccnt.refund', 'mchaccnt.refund.open', 'mchaccnt.refund.notify',
                'mchaccnt.withdraw.work.safety ', 'mchaccnt.withdraw.notify',
                'mchsub.transfer', 'mchaccnt.transfer.notify', 'mchaccnt.balance.query_work',
                'mchaccnt.transaction.total', 'mchaccnt.transaction.query']

