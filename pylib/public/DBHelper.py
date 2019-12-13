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

    def select_sql(self, param):
        try:
            sql = 'SELECT * FROM mch_accnt WHERE mch_accnt_name = ' + param
            self.cursor.execute(sql)
            data = self.cursor.fetchall()
        except:
            print("MySQL Error %s" % data)
        self.cursor.close()
        self.conn.close()
        return data

    def delete_sql(self, param):
        try:
            sql = 'DELETE FROM mch_accnt WHERE mch_accnt_name =' + param
            data = self.cursor.execute(sql)
            if data == 1:
                result = 'Done'
            else:
                result = 'Failed'
        except:
            print("MySQL Error %s" % data)
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        return result


if __name__ == '__main__':
    db = DBHelper()
    db.select_sql('yxj')

