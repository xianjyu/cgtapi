import json
import requests
from pprint import pprint
from config import token, cgt_test_env_url
from pylib.public.cgt.ComLib import ComLib


cl = ComLib()


class MchaccntPayDispatchLib:
    def __init__(self):
        pass

    def get_response_mchaccnt_pay_dispatch(self, trans_channel, trans_amt, settle_duration, settle_type, mch_accnt_no,
                                           dispatch_event, dispatch_type, business_type, amount, accnt_amount_before):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)  非必填参数
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': trans_channel,
            'trans_time': trans_time,
            'trans_amt': trans_amt,
            'settle_duration': settle_duration,
            'settle_type': settle_type,
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': dispatch_event,
                'dispatch_type': dispatch_type,
                'business_type': business_type,
                'amount': amount,
                'accnt_amount_before': accnt_amount_before
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_trans_no_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        # trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': '',
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': 1,
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_trans_channel_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '',
            'trans_time': trans_time,
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': 1,
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_trans_amt_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '',
            'settle_duration': 'D+1',
            'settle_type': 1,
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_settle_duration_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': '',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        pprint(data, indent=2)
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_settle_type_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': 'D+1',
            'settle_type': '',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_mch_accnt_no_mchaccnt_pay_dispatch(self):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': '',
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_trans_time_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        # trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': '',
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': 1,
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_order_no_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        # order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': '',
                'dispatch_event': 'pay',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_dispatch_event_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': '',
                'dispatch_type': 1,
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_dispatch_type_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '',
                'business_type': '网吧',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_business_type_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': 100,
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '',
                'amount': 100,
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_amount_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_after: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': '',
                'accnt_amount_before': 1
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def check_accnt_amount_after_mchaccnt_pay_dispatch(self, mch_accnt_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': '100',
                'accnt_amount_before': ''
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def use_same_trans_no_mchaccnt_pay_dispatch(self, mch_accnt_no, trans_no):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        # trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': '100',
                'accnt_amount_before': ''
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def use_trans_channel_mchaccnt_pay_dispatch(self, mch_accnt_no, trans_channel):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': trans_channel,
            'trans_time': trans_time,
            'trans_amt': '100',
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': '100',
                'accnt_amount_before': ''
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def use_trans_amt_mchaccnt_pay_dispatch(self, mch_accnt_no, trans_amt, amount):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': trans_amt,
            'settle_duration': 'D+1',
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': amount,
                'accnt_amount_before': ''
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response

    def use_trans_amt_mchaccnt_pay_dispatch(self, mch_accnt_no, settle_duration):
        """
        获取商户支付记账的返回报文方法:get_response_mchaccnt_pay_dispatch()
        :param trans_no:交易流水号(支付通道返回的交易订单号，标识唯一的一笔支付交易，同一商户下唯一)
        :param trans_channel:交易渠道(交易渠道标识，如微信扫码、公众号（1001/1002），该标识由商户定义，测试环境与正式环境都需要提前告知系统配置)
        :param trans_time:交易完成时间
        :param trans_amt:交易金额
        :param settle_duration:结算周期(结算周期：T1（T+1）、D0(D+0)、D1(D+1)、T7(T+7))
        :param settle_type:结算方式：0（其他通道转账）；1（通道结算）
        :param mch_accnt_no:子商户账户号
        :param order_no:订单号(由商户生成，标识在一笔支付交易完成后，每笔要进行清分的明细)
        :param dispatch_event:分账事件：pay(支付)；transfer( 转账 )
        :param dispatch_type:分账类型(1：正交易；2：反交易)
        :param business_type:业务类型（网吧、医药、保险..）
        :param amount:分账金额  分
        :param accnt_amount_before: 账户事前余额(商户系统中，对应该账户的余额)
        :return:商户支付记账的返回报文参数给外部调用者
        """
        trans_no = cl.get_trans_no()
        trans_time = cl.get_time()
        order_no = cl.get_order_no()
        biz_content = {
            'trans_no': trans_no,
            'trans_channel': '2051',
            'trans_time': trans_time,
            'trans_amt': '1000',
            'settle_duration': settle_duration,
            'settle_type': '1',
            'split_accnt_detail': [{
                'mch_accnt_no': mch_accnt_no,
                'order_no': order_no,
                'dispatch_event': 'pay',
                'dispatch_type': '1',
                'business_type': '网吧',
                'amount': '1000',
                'accnt_amount_before': ''
            }]
        }
        data = {'biz_content': biz_content}
        common_param = cl.get_common_param(6)
        data.update(common_param)
        data = json.dumps(data, separators=(',', ':'))
        sign = cl.get_sign(data, token)
        payload = {'data': data, 'sign': sign}
        result = requests.post(cgt_test_env_url, data=payload)
        result_data = result.json()['data']
        response = json.loads(result_data)
        pprint(response)
        return response


if __name__ == '__main__':
    mpd = MchaccntPayDispatchLib()
    mpd.get_response_mchaccnt_pay_dispatch('2051', '100', 'D1',  '1', 'T0020191219184043000188', 'pay', '1', '网吧', '100', '1')




