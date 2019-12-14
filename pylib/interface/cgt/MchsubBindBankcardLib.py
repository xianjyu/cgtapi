import json
import requests
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchsubBindBankcardLib:

    def __init__(self):
        pass

    def get_response_mchsub_bind_bankcard_public(self, mch_accnt_no, card_accnt_type, card_no, bank_name, bank_branch_name, user_name, card_phone, notify_url):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': mch_accnt_no,
            'card_accnt_type': card_accnt_type,
            'card_no': card_no,
            'bank_name': bank_name,
            'bank_branch_name': bank_branch_name,
            'order_no': order_no,
            'user_name': user_name,
            'card_phone': card_phone,
            'notify_url': notify_url
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

    def check_mch_accnt_no(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': '',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_card_accnt_type(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_card_no(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_bank_name(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_order_no(self):
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': '',
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_user_name(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': '',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_bank_branch_name(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_card_phone(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def check_notify_url(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020191121104442000000',
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': ''
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

    def get_mch_accnt_no(self, mch_accnt_no):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': mch_accnt_no,
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def mch_accnt_no_not_exist(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T123456',  # 顺网平台下的子商户账号
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def mch_accnt_no_other_platform(self):
        order_no = cl.get_order_no()
        biz_content = {
            'mch_accnt_no': 'T0020190614154321000001',  # 顺网平台下的子商户账号
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': order_no,
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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

    def bind_bank_card_same_order_no(self, mch_accnt_no):
        biz_content = {
            'mch_accnt_no': mch_accnt_no,
            'card_accnt_type': '0',
            'card_no': '6214835498324017',
            'bank_name': '杭州银行',
            'bank_branch_name': '杭州滨江支行',
            'order_no': 'on20112141645',
            'user_name': 'yuxj',
            'card_phone': '13989353209',
            'notify_url': 'http://172.16.202.160:3054/api/bankcard/notify.htm'
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
    mbb = MchsubBindBankcardLib()
    # mbb.get_response_mchsub_bind_bankcard_public('T0020191121104442000000', '0', '6214835498324017', '杭州银行', '杭州滨江支行', 'yuxj', '13989353209', 'http://172.16.202.160:3054/api/bankcard/notify.htm')
    # mbb.check_mch_accnt_no()
    # mbb.check_card_accnt_type()
    # mbb.check_card_no()
    # mbb.check_bank_name()
    # mbb.check_order_no()
    # mbb.check_user_name()
    # mbb.check_bank_branch_name()
    # mbb.check_card_phone()
    # mbb.check_notify_url()
    # mbb.mch_accnt_no_not_exist()
    # mbb.mch_accnt_no_other_platform()
    mbb.same_mch_accnt_no()
