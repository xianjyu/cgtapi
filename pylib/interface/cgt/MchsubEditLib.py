import json
import requests
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchsubEditLib:
    def __init__(self):
        pass

    def get_response_mchsub_edit(self, mch_accnt_name, out_mch_accnt_no, mch_accnt_no, order_no, link_name, link_phone, link_email=None):
        biz_content = {
            'mch_accnt_name': mch_accnt_name,
            'out_mch_accnt_no': out_mch_accnt_no,
            'mch_accnt_no': mch_accnt_no,
            'order_no': order_no,
            'link_name': link_name,
            'link_phone': link_phone,
            'link_email': link_email
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_mach_accnt_name(self):
        biz_content = {
            'mch_accnt_name': '',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'man123456789',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_out_mch_accnt_no(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'T0020191213182413000108',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
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
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'T0020191213182413000108',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
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
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'T0020191213182413000108',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_name(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'T0020191213182413000108',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_name(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'T0020191213182413000108',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_email(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman12346789',
            'mch_accnt_no': 'T0020191213182413000108',
            'order_no': 'on123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(1)
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
    mel = MchsubEditLib()
    # mel.get_response_mchsub_edit('yxj2', 'oman987654321',  'T0020191213182413000108', 'on987654321', '13989353206', 'xianjyu@qq.com')
    mel.check_mach_accnt_name()


