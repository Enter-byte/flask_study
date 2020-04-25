from flask import Flask, render_template,request,redirect,url_for,json
import pymysql
app = Flask(__name__)

# 连接数据库的四个要素（端口号默认3306，已省略）
hostName = "localhost"
userName = "root"
userPassword = "root"
dbName = "study11"


@app.route("/bookListJson")
def bookListJson():
    #获取参数
    # 拼写sql
    sql = "select * from imd_book"
    # 连接数据库
    db = pymysql.connect(hostName,userName,userPassword,dbName)
    # 获取游标，执行sql
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        results = cursor.fetchall()
    except:
        print ("error")
    # 关闭游标，关闭数据库
    cursor.close()
    db.close()
    # 跳转或重定向输出json
    return json.dumps(results,ensure_ascii=False)


@app.route("/bookShowJson")
def bookShowJson(id):
    id = request.args.get('id')
    sql = "select * from imd_book where book_id = {}"
    sql = sql.format(id)
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        results = cursor.fetchone()
    except:
        print("error")
    cursor.close()
    db.close()
    return json.dumps(results, ensure_ascii=False)

if __name__ == '__main__':
    app.run(host="0.0.0.0")
