import time
import hashlib
from config import biz_type, sign_type, mch_no


class ComLib:
    """
    公共方法
    """
    def __init__(self):
        self.mch_no = mch_no
        self.biz_type = biz_type
        self.md5 = sign_type

    def get_time(self):
        """
        获取当前时间：年、月、日、时、分、秒
        :return:当前时间数字格式
        """
        timestamp = time.strftime('%Y%m%d%H%M%S', time.localtime(time.time()))
        return timestamp

    def get_sign(self, data, token):
        """
        获取签名：data + "&" + timestamp + token
        :param data:请求参数
        :param token:商户号对应的token
        :return:返回一串数字
        """
        timestamp = ComLib.get_time(self)
        sign = data + "&" + timestamp + token
        sign = hashlib.md5(sign.encode(encoding='utf-8')).hexdigest()
        return sign

    def get_biz_type(self, index):
        """
        从config中获取接口方法类型
        :param index:索引指的是对应config中biz_type对应的接口方法，例如0对应的是mchsub.create，且是正整数
        :return:返回接口类型方法
        """
        if index >= biz_type.__len__():
            print('注意：你输入的数字过大，大于config文件中的biz_type的数组长度！')
        elif index < 0:
            print('注意：不能输入小于0的数')
        else:
            oper_type = self.biz_type[index]
            return oper_type

    def get_out_trans_no(self):
        """
        外部追踪号：otn+时间戳
        :return:返回唯一的外部追踪号
        """
        timestamp = ComLib.get_time(self)
        out_trans_no = 'otn' + timestamp
        return out_trans_no

    def get_common_param(self, index):
        """
        获取公共参数方法
        :param index:和get_biz_type()方法中的index一致
        :return:
        """
        timestamp = ComLib.get_time(self)
        out_trans_no = ComLib.get_out_trans_no(self)
        biz_type = ComLib.get_biz_type(self, index)
        data = {
            'mch_no': self.mch_no,
            'out_trans_no': out_trans_no,
            'biz_type': biz_type,
            'timestamp': timestamp,
            'sign_type': self.md5
        }
        return data

    def get_out_mch_accnt_no(self):
        """
        获取外部子商户号：oman+时间戳
        :return:返回唯一的外部追踪号
        """
        timestamp = ComLib.get_time(self)
        out_mch_accnt_no = 'oman' + timestamp
        return out_mch_accnt_no


if __name__ == '__main__':
    cl = ComLib()
    # print(cl.get_time())
    # print(cl.get_sign("1", "123456"))
    # print(cl.get_out_mch_accnt_no())
    # print(cl.get_biz_type(0))
    # cl.get_common_param(0)
