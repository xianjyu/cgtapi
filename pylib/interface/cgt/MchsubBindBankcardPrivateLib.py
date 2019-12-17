import json
import requests
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchsubBindBankcardPrivateLib:
    def __init__(self):
        pass

    def get_response_mchsub_bind_bankcard_private(self, mch_accnt_no, card_accnt_type, card_no, bank_name, bank_branch_name, user_name
                                                  , card_phone, notify_url, cert_type, cert_no
                                                  , card_type, bank_no, card_cvn=None, card_expire_date=None, authen_type=None,):
        """
        获取对私绑定银行卡的返回报文信息：get_response_mchsub_bind_bankcard_private
        注：对私绑定银行卡成功后的状态直接是success，不是待认证
        :param mch_accnt_no:子商户账户(平台子商账户号)
        :param card_accnt_type:银行卡账户类型(银行卡账户类型：0-对公；1-对私)
        :param card_no:银行卡号
        :param bank_name:开户行名称
        :param bank_branch_name:分支行信息
        :param user_name:户名
        :param card_phone:银行预留手机号
        :param notify_url:异步通知地址(异步通知地址http:www.xxxxx)
        :param cert_type:证件类型(0：身份证(目前仅支持身份证))
        :param cert_no:持有人证件号
        :param card_type:银行卡类型
        :param bank_no:银行代码(0-储蓄卡;1-信用卡)
        :param card_cvn:信用卡cvn(信用卡背面末三位安全码(信用卡认证必填，即 card_type=1))
        :param card_expire_date:信用卡有效期(信用卡认证必填)
        :param authen_type:
        :return:返回给外部调用者的对私绑卡的报文信息
        """
        order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": mch_accnt_no,
            "order_no": order_no,
            "card_accnt_type": card_accnt_type,
            "card_no": card_no,
            "bank_name": bank_name,
            "bank_branch_name": bank_branch_name,
            "user_name": user_name,
            "card_phone": card_phone,
            "notify_url": notify_url,
            "cert_type": cert_type,
            "cert_no": cert_no,
            "card_type": card_type,
            "bank_no": bank_no,
            "card_cvn": card_cvn,
            "card_expire_date": card_expire_date,
            'authen_type': authen_type
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_mch_accnt_no_bind_bankcard_private(self):
        order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": '',
            "order_no": order_no,
            "card_accnt_type": '1',
            "card_no": '6217866300004303385',
            "bank_name": '中国银行',
            "bank_branch_name": '杭州滨江支行',
            "user_name": '余道友',
            "card_phone": '18158857961',
            "notify_url": 'http://172.16.202.160:3054/api/bankcard/notify.htm',
            'authen_type': '0',
            "cert_type": '0',
            "cert_no": '342423196910292879',
            "card_type": '104100000004',
            "bank_no": '123',
            "card_cvn": '2100-01-01',
            "card_expire_date": '0'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_order_no_bind_bankcard_private(self):
        # order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": 'T0020191217150549000011',
            "order_no": '',
            "card_accnt_type": '1',
            "card_no": '6217866300004303385',
            "bank_name": '中国银行',
            "bank_branch_name": '杭州滨江支行',
            "user_name": '余道友',
            "card_phone": '18158857961',
            "notify_url": 'http://172.16.202.160:3054/api/bankcard/notify.htm',
            'authen_type': '0',
            "cert_type": '0',
            "cert_no": '342423196910292879',
            "card_type": '104100000004',
            "bank_no": '123',
            "card_cvn": '2100-01-01',
            "card_expire_date": '0'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_card_accnt_type_bind_bankcard_private(self):
        order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": 'T0020191217150549000011',
            "order_no": order_no,
            "card_accnt_type": '',
            "card_no": '6217866300004303385',
            "bank_name": '中国银行',
            "bank_branch_name": '杭州滨江支行',
            "user_name": '余道友',
            "card_phone": '18158857961',
            "notify_url": 'http://172.16.202.160:3054/api/bankcard/notify.htm',
            'authen_type': '0',
            "cert_type": '0',
            "cert_no": '342423196910292879',
            "card_type": '104100000004',
            "bank_no": '123',
            "card_cvn": '2100-01-01',
            "card_expire_date": '0'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_card_no_bind_bankcard_private(self):
        order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": 'T0020191217150549000011',
            "order_no": order_no,
            "card_accnt_type": '1',
            "card_no": '',
            "bank_name": '中国银行',
            "bank_branch_name": '杭州滨江支行',
            "user_name": '余道友',
            "card_phone": '18158857961',
            "notify_url": 'http://172.16.202.160:3054/api/bankcard/notify.htm',
            'authen_type': '0',
            "cert_type": '0',
            "cert_no": '342423196910292879',
            "card_type": '104100000004',
            "bank_no": '123',
            "card_cvn": '2100-01-01',
            "card_expire_date": '0'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_bank_name_bind_bankcard_private(self):
        order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": 'T0020191217150549000011',
            "order_no": order_no,
            "card_accnt_type": '1',
            "card_no": '6217866300004303385',
            "bank_name": '',
            "bank_branch_name": '杭州滨江支行',
            "user_name": '余道友',
            "card_phone": '18158857961',
            "notify_url": 'http://172.16.202.160:3054/api/bankcard/notify.htm',
            'authen_type': '0',
            "cert_type": '0',
            "cert_no": '342423196910292879',
            "card_type": '104100000004',
            "bank_no": '123',
            "card_cvn": '2100-01-01',
            "card_expire_date": '0'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_bank_branch_name_bind_bankcard_private(self):
        order_no = cl.get_order_no()
        biz_content = {
            "mch_accnt_no": 'T0020191217150549000011',
            "order_no": order_no,
            "card_accnt_type": '1',
            "card_no": '6217866300004303385',
            "bank_name": '中国银行',
            "bank_branch_name": '',
            "user_name": '余道友',
            "card_phone": '18158857961',
            "notify_url": 'http://172.16.202.160:3054/api/bankcard/notify.htm',
            'authen_type': '0',
            "cert_type": '0',
            "cert_no": '342423196910292879',
            "card_type": '104100000004',
            "bank_no": '123',
            "card_cvn": '2100-01-01',
            "card_expire_date": '0'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(2)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response


if __name__ == '__main__':
    mbbpl = MchsubBindBankcardPrivateLib()
    # mbbpl.get_response_mchsub_bind_bankcard_private('T0020191217150549000011', '1', '6217866300004303385', '中国银行', '杭州滨江支行', '余道友'
    #                                                 , '18158857961', 'http://172.16.202.160:3054/api/bankcard/notify.htm', '0', '342423196910292879'
    #                                                 , '0', '104100000004', '123', '2100-01-01', '0')
    # mbbpl.check_mch_accnt_no_bind_bankcard_private()
    # mbbpl.check_order_no_bind_bankcard_private()
    # mbbpl.check_card_accnt_type_bind_bankcard_private()
    # mbbpl.check_card_no_bind_bankcard_private()
    # mbbpl.check_bank_name_bind_bankcard_private()
    mbbpl.check_bank_branch_name_bind_bankcard_private()




