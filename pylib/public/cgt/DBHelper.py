import pymysql
from pymysql.err import OperationalError
from config import localhost, username, password, database


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

    def update_sql(self, mch_accnt_no):
        sql = 'UPDATE bank_card SET status = ' + "'success'" + 'WHERE mch_no = ' + "'MH20181229115220NBUu'" + ' And mch_accnt_no = ' + "'" + mch_accnt_no + "'"
        result = self.cursor.execute(sql)
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        return result


if __name__ == '__main__':
    db = DBHelper()
    # db.select_sql()
    db.update_sql('T0020191105143247000007')
