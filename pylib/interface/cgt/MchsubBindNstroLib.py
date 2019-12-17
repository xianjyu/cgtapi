import json
import requests
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchsubBindNstroLib:
    def __init__(self):
        pass

    def get_response_mchsub_bind_nstro(self, mch_accnt_no, card_no, amt):
        """
        获取往账请求后的返回报文：get_response_mchsub_bind_nstro
        业务场景：子商户绑定对公账户时往账（对私绑卡不可调用该接口）
        :param mch_accnt_no:子商户账号
        :param card_no:银行卡号
        :param amt:往账金额
        :return:往账请求后的返回报文

        步骤：
            1、对公绑卡请求成功
            2、将对公绑卡请求成功后的mch_accnt_no、card_no，返回给往账请求接口
            3、再操作往账接口前，先操作数据库，对状态进行修改
            4、最后调取往账请求接口
        """
        biz_content = {
            'mch_accnt_no': mch_accnt_no,
            'card_no': card_no,
            'amt': amt
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(3)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        print(result)
        result_data = result.json()['data']
        # response = json.loads(result_data)
        # print(response)
        # return response


if __name__ == '__main__':
    mbn = MchsubBindNstroLib()
    mbn.get_response_mchsub_bind_nstro('T0020191105143247000007', '6214835498324017', '1')
