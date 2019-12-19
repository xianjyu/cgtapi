import pymysql
from pymysql.err import OperationalError
from config import localhost, username, password, database
# from robot.api import logger


class DBHelper:
    def __init__(self):
        """  建立数据库连接"""
        try:
            self.conn = pymysql.connect(localhost, username, password, database)
            self.cursor = self.conn.cursor()
        except OperationalError as e:
            print("MySQL Error %d: %s" % (e.args[0], e.args[1]))

    def select_sql(self):
        sql = 'SELECT * FROM mch_accnt WHERE mch_accnt_name = ' + "'yxj'"
        self.cursor.execute(sql)
        result = self.cursor.fetchone()   # fetchall()
        self.cursor.close()
        self.conn.close()
        return result

    def delete_sql(self):
        sql = 'DELETE FROM mch_accnt WHERE mch_accnt_name =' + "'yxj'"
        result = self.cursor.execute(sql)
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        return result

    def update_status_sql(self, mch_accnt_no):
        sql = 'UPDATE bank_card SET status = ' + "'success'" + ' WHERE mch_no = ' + "'MH20181229115220NBUu'" + ' And mch_accnt_no = ' + "'" + mch_accnt_no + "'"
        print(sql)
        result = self.cursor.execute(sql)
        if result == 1:
            print("数据库修改状态成功！")
        elif result == 0:
            print("数据库修改状态失败！")
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        return result

    def update_amount_sql(self, remain_amt, settled_amount, mch_accnt_no):
        sql = 'UPDATE mch_accnt SET remain_amt = ' + "'" + remain_amt + "'" + ', settled_amount = ' + "'" + settled_amount + "'" + ' WHERE mch_no = ' + "'MH20181229115220NBUu'" + ' And mch_accnt_no = ' + "'" + mch_accnt_no + "'"
        print(sql)
        result = self.cursor.execute(sql)
        if result == 1:
            print("数据库修改状态成功！")
        elif result == 0:
            print("数据库修改状态失败！")
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        return result

    def update_bank_sql(self, mch_accnt_no):
        sql = 'UPDATE bank_card SET bank_no = ' + "'105100000017'" + ', bank_name = ' + "'建设银行'" + ', bank_branch_name = ' + "'建设银行支行'" + ' WHERE mch_no = ' + "'MH20181229115220NBUu'" + ' And mch_accnt_no = ' + "'" + mch_accnt_no + "'"
        print(sql)
        result = self.cursor.execute(sql)
        if result == 1:
            print("数据库修改状态成功！")
        elif result == 0:
            print("数据库修改状态失败！")
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        return result

    def modify_fixed_poundage(self, amount, mch_no, acc_type):
        """
        修改mch表中的通道手续费：fixed_poundage方法，modify_fixed_poundage
        :param amount:手续费金额
        :param mch_no:商户号
        :param acc_type:通道类型
        :return:
        """
        self.connect = pymysql.connect(localhost, username, password, database)
        self.mfp_cursor = self.connect.cursor()
        sql = 'UPDATE mch SET fixed_poundage = ' + "'" + amount + "'" + ' WHERE mch_no = ' + "'" + mch_no + "'" + 'And acc_type = ' + "'" + acc_type + "'"
        print(sql)
        result = self.mfp_cursor.execute(sql)
        if result == 1:
            print("数据库修改状态成功！")
        elif result == 0:
            print("数据库修改状态失败！")
        self.connect.commit()
        self.mfp_cursor.close()
        self.connect.close()
        return result


if __name__ == '__main__':
    db = DBHelper()
    # db.select_sql()
    # db.update_status_sql('T0020191217142756000008')
    # db.update_amount_sql('T0020191217140921000005')
    # db.update_bank_sql('T0020191217152411000013')]
    db.modify_fixed_poundage('1000', 'wx', 'MH20181229115220NBUu')



