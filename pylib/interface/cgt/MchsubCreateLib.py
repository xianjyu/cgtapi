from pylib.public.cgt.ComLib import ComLib
from config import token, cgt_test_env_url
import json
import requests


cl = ComLib()


class MchsubCreateLib:

    def __init__(self):
        pass

    def get_response_mchsub_create(self, mch_accnt_name, out_mch_accnt_no, link_name, link_phone, link_email, is_supplier=None, is_assure=None):
        """
        获取子商户创建的返回值
        :param mch_accnt_name:子商户名称
        :param out_mch_accnt_no:外部子商户号
        :param link_name:联系人姓名
        :param link_phone:联系人电话
        :param link_email:联系人邮箱
        :param is_supplier:是否是供应商子账户Y/N（如果是，则开设供应商子账户+供应商待结算子账户；如果否，则开设为普通子商户账户）是否是供应商子账户Y/N（如果是，则开设供应商子账户+供应商待结算子账户；如果否，则开设为普通子商户账户）
        :param is_assure:是否开启担保账户Y/N（如果是，则开设普通子商户账户+担保子账户；如果否，则开设为普通子商户账户）
        :return:返回一个子商户创建接口的返回报文
        """
        biz_content = {
            'mch_accnt_name': mch_accnt_name,
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': link_name,
            'link_phone': link_phone,
            'link_email': link_email,
            'is_supplier': is_supplier,
            'is_assure': is_assure
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_mch_accnt_name(self):
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': '',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
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
            'out_mch_accnt_no': '',
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
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
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': '',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_link_phone(self):
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': 'yxj',
            'link_phone': '',
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
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
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_is_supplier(self):
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com',
            'is_supplier': '',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_is_assure(self):
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': 'yxj',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': 'yxj',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': ''
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
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
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def mchsub_create_out_mch_accnt_no_not_repeat(self):
        out_mch_accnt_no = cl.get_out_mch_accnt_no()
        biz_content = {
            'mch_accnt_name': 'yxj2',
            'out_mch_accnt_no': out_mch_accnt_no,
            'link_name': 'yxj2',
            'link_phone': '13989353209',
            'link_email': '2451255827@qq.com',
            'is_supplier': 'N',
            'is_assure': 'N'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
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
    mc = MchsubCreateLib()
    mc.get_response_mchsub_create('xianjyu', 'oman123456789', 'xianjyu', '13989353209', '2451255827@qq.com', 'N', 'N')
    # mc.check_out_mch_accnt_no()

