import json
import requests
from config import token, gbw_test_env_url
from pylib.public.gbw.ComLib import ComLib

cl = ComLib()


class OrderReportLib:
    def __init__(self):
        pass

    def get_response_order_report(self, order_no, order_amt, notify_url):
        biz_content = {
            'order_no': order_no,
            'order_amt': order_amt,
            'notify_url': notify_url
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        print(payload)
        # result = requests.post(gbw_test_env_url, data=payload)
        # result_data = result.json()['data']
        # response = json.loads(result_data)
        # print(response)
        # return response

    def check_order_no(self):
        biz_content = {
            'order_no': '',
            'order_amt': 1,
            'notify_url': 'http://www.baidu.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(gbw_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_order_amt(self):
        biz_content = {
            'order_no': 'on123456789',
            'order_amt': '',
            'notify_url': 'http://www.baidu.com'
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(gbw_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response

    def check_notify_url(self):
        biz_content = {
            'order_no': 'on123456789',
            'order_amt': 1,
            'notify_url': ''
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(0)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(gbw_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        print(response)
        return response


if __name__ == '__main__':
    orl = OrderReportLib()
    orl.get_response_order_report('on123456789', 1, 'http://www.baidu.com')


