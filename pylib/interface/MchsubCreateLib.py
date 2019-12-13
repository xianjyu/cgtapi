from pylib.public.ComLib import ComLib
from config import token, test_env_url
import json
import requests


cl = ComLib()


class MchsubCreateLib:

    def __init__(self):
        pass

    def get_response_mchsub_create(self, mch_accnt_name, out_mch_accnt_no, link_name, link_phone, link_email):
        """
        获取子商户创建的返回值
        :param mch_accnt_name:子商户名称
        :param out_mch_accnt_no:外部子商户号
        :param link_name:联系人姓名
        :param link_phone:联系人电话
        :param link_email:联系人邮箱
        :return:返回一个子商户创建接口的返回报文
        """
        biz_content = {
            'mch_accnt_name': mch_accnt_name,
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': link_name,
            'link_phone': link_phone,
            'link_email': link_email
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_mch_accnt_name(self):
        biz_content = {
            'mch_accnt_name': '',
            'out_mch_accnt_no': 'oman123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_out_mch_accnt_no(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': '',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_name(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman123456789',
            'link_name': '',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_phone(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman123456789',
            'link_name': 'yxj',
            'link_phone': '',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_email(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': ''
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def out_mch_accnt_no_repeat(self):
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': 'oman123456789',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response


if __name__ == '__main__':
    mc = MchsubCreateLib()
    # mc.get_response_mchsub_create('yxj', '', 'yxj', '13989353209', '2451255827@qq.com')
    mc.check_out_mch_accnt_no()

