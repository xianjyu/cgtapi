import json
import requests
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchaccntBindNotify:
    def __init__(self):
        pass

    def get_response_mchaccnt_bind_notify(self, mch_accnt_no, card_no, status, message):
        biz_content = {
            'mch_accnt_no': mch_accnt_no,
            'card_no': card_no,
            'status': status,
            'message': message
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(4)
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
    mbn = MchaccntBindNotify()
    mbn.get_response_mchaccnt_bind_notify('T0020191105143247000007', '6214835498324017', '1', '成功')
