import json
import requests
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchaccntWithdrawLib:
    def __init__(self):
        pass

    def get_response_mchaccnt_withdrawLib(self, mch_accnt_no, order_no, card_no, amount, type, notify_url, bsbank_no=None):
        """
        获取账户提现接口返回报文的方法：get_response_mchaccnt_withdrawLib()
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号
        :param card_no:银行卡号
        :param amount:提现金额
        :param type:代付类型
            RPAYM:收付直通车（收费，实时到账）
            HOH：普通网银（免费，T+1到账）
            SUPER:超级网银（免费，实时到账，限额5万）
        :param notify_url:异步回调地址
        :param bsbank_no:大小额行号  非必填
            某网点的行号(当跨行转账，收款账号为对公账号，金额在 5 万以上，大小额行号、大小额银行名称必输)
        :return:
        """
        biz_content = {
            'mch_accnt_no': mch_accnt_no,
            'order_no': order_no,
            'card_no': card_no,
            'bsbank_no': bsbank_no,
            'amount': amount,
            'type': type,
            'notify_url': notify_url
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(5)
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
    mw = MchaccntWithdrawLib()
    mw.get_response_mchaccnt_withdrawLib('T0020191216191030000000', 'on123', '6214835498324017', '1', 'RPAYM', 'http://172.16.202.163:3054/api/bankcard/notify.htm')
