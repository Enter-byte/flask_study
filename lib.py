from flask import Flask, render_template,request,redirect,url_for,json
import pymysql
from flask_cors import *

app.config[SECRET_KEY] = 'ccnu'

app = Flask(__name__)
CORS(app, supports_credentials = True)
# 连接数据库的四个要素（端口号默认3306，已省略）
hostName = "localhost"
userName = "root"
userPassword = "root"
dbName = "study11"


#路由默认只支持get，如果需要增加，需要自行指定
#书目检索表的建立和书表格
@app.route("/lib",methods=['GET','POST'])
def index():
    # 使用connect方法进行连接MySQL
    # 函数
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    # 我们需要一个游标
    cursor = db.cursor()
    # 编写SQL
    sql = "select * from imd_book"
    # sql = """insert into imd_book (isdn,publish_date,author,publisher,name,bookid)
    # values ('188XXX188','2007/2/3','施耐庵','中国出版社','水浒传',21)"""
    #sql = "delete from imd_book where bookid=17"
    #馆藏副本总数
    sql1 = "select count(*) from imd_copybook where book_id = %s"
    #馆藏可借总数  is_borrow=1可借 stautus=1未被借走
    sql2 = "select count(*) from imd_copybook where is_borrow=1 and status=1 and book_id= %s"
    try:
        # 执行SQL，使用execute方法执行
        cursor.execute(sql)
        # 获取数据
        results = cursor.fetchall()
        #print(results)
        # 循环显示数据
        datalist = []
        for row in results:
            #每一次循环都把one列表变成空列表
            one = []
            #把第一本书的所有数据放在one这个列表中
            one.append(row[0])
            one.append(row[1])
            one.append(row[2])
            one.append(row[3])
            one.append(row[4])
            one.append(row[5])
            #通过sql1和书的id去imd_copybook表中查询书的总数量
            cursor.execute(sql1, [row[5]])
            #把该id的书的所有馆藏副本数量赋给results1
            results1 = cursor.fetchone()
            #print (results1)
            #再把这个数据加入到one这个列表中
            one.append(results1[0])
            #print (one)
            #执行sql2，获取可以借阅到的副本数量
            cursor.execute(sql2,[row[5]])
            #把该值赋给results2
            results2 = cursor.fetchone()
            #再加入到one列表中
            one.append(results2[0])
            #把整个one列表加入到datalist空列表中
            datalist.append(one)
    except:
        print("error")
#检索图书
    if request.method == 'POST':
        # 获取想要的参数
        #print (request.form['f'])
        #print (name_key)
        sql3 = sql + " where " + request.form['f'] + " like '%{}%'"
        sql3 = sql3.format(request.form.get('key'))
        #print (sql3)
        sql4 = "select count(*) from imd_copybook where book_id = %s"
        sql5 = "select count(*) from imd_copybook where is_borrow=1 and status=1 and book_id= %s"
        datalist_two = []
        try:
            #查询书本信息
            cursor.execute(sql3)
            results3 = cursor.fetchall()
            #print (results3[0])
            two = []
            for row_one in results3[0]:
                two.append(row_one)
            #print(two)
            #查询馆藏数量
            cursor.execute(sql4,two[5])
            results4 = cursor.fetchone()
            #print(results4)
            #查询可借数量
            cursor.execute(sql5, two[5])
            results5 = cursor.fetchone()
            #print(results5)
            two.append(results4[0])
            two.append(results5[0])
            #数据导入列表
            datalist_two.append(two)
            #print (datalist_two)
        except:
            print("error")
        return render_template('lib.html', datalist=datalist_two)
    # 关闭游标
    cursor.close()
    # 关闭数据库
    db.close()
    return render_template('lib.html',datalist = datalist)

@app.route("/book/<id>")
def book(id):
    #1、通过主键获取书的信息
    sql1 = "select * from imd_book where book_id={}"
    sql1 = sql1.format(id)
    #2、查询馆藏书
    sql2 ="select count(*) from imd_copybook where book_id={}"
    sql2 = sql2.format(id)
    #3、查询可借复本数
    sql3 = "select count(*) from imd_copybook where status = 1 and is_borrow = 1 and book_id = {}"
    sql3 = sql3.format(id)
    #4、借阅记录数
    sql4 = "select count(*) from imd_record a left join imd_copybook b on a.copy_id=b.copybookid" \
           " where b.book_id={}"
    sql4 = sql4.format(id)
    #5、借阅记录
    sql5 = "select a.*,c.* from imd_record a " \
           "left join imd_user c on a.user_id = c.user_id " \
           "left join imd_copybook b on a.copy_id = b.copybookid " \
           "where b.book_id = {}"
    sql5 = sql5.format(id)
    #6、书的平均评分
    sql6 = "select avg(a.score) from imd_comment a left join imd_copybook b on a.copy_id=b.copybookid" \
           " where b.book_id={}"
    sql6 = sql6.format(id)
    #7、书的评分及评论记录
    sql7 = "select a.*,c.* from imd_comment a " \
           "left join imd_user c on a.user_id = c.user_id " \
           "left join imd_copybook b on a.copy_id = b.copybookid " \
           " where b.book_id = {}"
    sql7 = sql7.format(id)
    #8、书的评论总记录数
    sql8 = "select count(*) from imd_comment a left join imd_copybook b on a.copy_id=b.copybookid" \
           " where b.book_id={}"
    sql8 = sql8.format(id)
    #9、查询副本状态
    sql9 = "select * from imd_copybook where book_id={}"
    sql9 = sql9.format(id)

    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    datalist = []
    try:
        one = []
        #print (sql1)
        cursor.execute(sql1)
        results1 = cursor.fetchall()
        #print (results1)
        for row in results1:
            one.append(row[0])
            one.append(row[1])
            one.append(row[2])
            one.append(row[3])
            one.append(row[4])
            one.append(row[5])
        #print (one)
        #print(sql2)
        cursor.execute(sql2)
        results2 = cursor.fetchone()
        #print (results2)
        one.append(results2[0])
        #print(one)
        #print(sql3)
        cursor.execute(sql3)
        results3 = cursor.fetchone()
        #print(results3)
        one.append(results3[0])
        #print(one)
        #print(sql4)
        cursor.execute(sql4)
        results4 = cursor.fetchone()
        #print(results4)
        #print(sql5)
        cursor.execute(sql5)
        results5 = cursor.fetchall()
        #print(results5)
        #print(sql6)
        cursor.execute(sql6)
        results6 = cursor.fetchone()
        #print (results6)
        #print(sql7)
        cursor.execute(sql7)
        results7 = cursor.fetchall()
        #print(results7)
        #print(sql8)
        cursor.execute(sql8)
        results8 = cursor.fetchall()
        #print(results8)
        cursor.execute(sql9)
        results9 = cursor.fetchall()
        #print (results9)
    except:
        print ("error")
    datalist.append(one)
    #print (datalist)
    cursor.close()
    db.close()
    return render_template("2.html",re4 = results4,datalist = datalist,re5 = results5,re6 = results6,re7 = results7,re8 = results8,re9 = results9)

@app.route("/2")
def rrrrr():
    return render_template("2.html")


#添加图书，直接跳转到添加书的页面，点击提交按钮后，跳转到savebook
@app.route("/addBook")
def add_Book():
    return render_template('add_book.html')
#与数据库对接，有了添加图书的基本信息后添加到数据库中，并转到最初的index（书表）中
@app.route("/saveBook",methods=['GET','POST'])
def saveBook():
    #1.获取数据
    # print (request.form['name'])
    # print (request.form['author'])
    # print (request.form['publisher'])
    # print (request.form['isbn'])
    # print (request.form['publishDate'])

    #2.拼写sql
    sql = "insert into imd_book (name,author,publisher,isbn,publish_date)" \
          " values ('{}','{}','{}','{}','{}')"

    sql = sql.format(request.form['name'],request.form['author'],request.form['publisher'],
                     request.form['isbn'],request.form['publishDate'])
    #print (sql)
    #3.连接数据库
    db = pymysql.connect(hostName, userName, userPassword, dbName)

    #4.获取游标，执行sql
    cursor = db.cursor()
    try:
        cursor.execute (sql)
    except:
        print ("error")

    #5.关闭游标，关闭数据库
    cursor.close()
    db.close()

    #7.重定向或跳转
    return redirect(url_for("listBook"))
#删除图书，这一步的目的是获取要删除的书的编号
@app.route ("/delBook")
def delBook():
    #获取数据，表示get方式来获取内容，直接获取id后下面可以直接使用
    id = request.args.get('id')
    return id
#获取到书的编号，与数据库对接，并执行删除书的操作，并返回到管理员的书的展示页面
@app.route ("/delBook/<id>")
def delBook2(id):
    sql = "delete from imd_book where bookid = {}"
    sql = sql.format(id)
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        cursor.execute(sql)
    except:
        print ("error")
    cursor.close()
    db.close()
    return redirect(url_for('listBook'))
#更改图书
@app.route("/updateBook",methods=['GET','POST'])
def updateBook():
    #获取数据：
    bookid = request.form['bookid']
    name = request.form['name']
    publisher = request.form['publisher']
    publishDate = request.form['publishDate']
    isbn = request.form['isbn']
    author = request.form['author']
    sql = "update imd_book set bookid={},name='{}',publisher='{}',publish_date='{}',isbn='{}',author='{}' where book_id={}"
    sql = sql.format(bookid,name,publisher,publishDate,isbn,author,bookid)
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        print (sql)
        cursor.execute(sql)
    except:
        print("error")
    cursor.close()
    db.close()
    return redirect(url_for('listBook'))
#管理员界面，在该页面可以对书进行直接操作
@app.route("/listBook")
def listBook():
    #1.获取参数
    #2.拼写sql
    sql = "select * from imd_book"
    #3.连接数据库
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    #4.获取游标，执行sql
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        results = cursor.fetchall()
    except:
        print ("error")
    #5.关闭游标，关闭数据库
    cursor.close()
    db.close()
    #6.重定向或跳转
    return render_template("list.html",re = results)
#展示单一的一本书，并对这本书执行相关操作
@app.route("/showBook/<id>")
def showBook(id):
    sql = "select * from imd_book where book_id = {}"
    sql = sql.format(id)
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        #print (sql)
        cursor.execute(sql)
        results = cursor.fetchall()
        #print (results)
    except:
        print ("error")
    cursor.close
    db.close()
    return render_template("show_book.html",re = results)
#对图书的副本情况的展示
@app.route("/listCopyBook/<id>")
def listCopyBook(id):
    sql = "select * from imd_copybook where book_id={}"
    sql = sql.format(id)

    sql2 = "select * from imd_book where book_id={}"
    sql2 = sql2.format(id)

    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        #print (sql)
        cursor.execute(sql)
        results = cursor.fetchall()
        #print (results)
        #print (sql2)
        cursor.execute(sql2)
        book = cursor.fetchone()
        #print (book)
    except:
        print ("error")
    cursor.close()
    db.close()
    return render_template("listCopyBook.html",book = book,rs = results)
#对一个副本的展示
@app.route("/showCopyBook/<copybookid>")
def showCopyBook(copybookid):
    sql = "select * from imd_copybook where copybookid = '{}'"
    sql = sql.format(copybookid)
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        #print (sql)
        cursor.execute(sql)

        results = cursor.fetchall()
        #print (results)
    except:
        print ("error")
    cursor.close
    db.close()
    return render_template("showCopyBook.html",re = results)

#对图书副本进行添加操作
@app.route("/addCopyBook")
def addCopyBook():
    return render_template("addCopyBook.html")
#跳转页面后执行下面函数来进行操作并跳转到listCopyBook页面
@app.route("/saveCopyBook",methods=['GET','POST'])
def saveCopyBook():
    id = request.form['bookid']
    sql = "insert into imd_copybook (place,status,is_borrow,copybookid,book_id) values('{}','{}','{}','{}','{}')"
    sql = sql.format(request.form['place'],request.form['status'],request.form['is_borrow'],request.form['copybookid'],request.form['bookid'])

    sql2 = "select * from imd_book where book_id = {}"
    sql2 = sql2.format(id)

    sql3 = "select * from imd_copybook where book_id={}"
    sql3 = sql3.format(id)

    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        #print (sql)
        cursor.execute(sql2)
        #print (sql2)
        book = cursor.fetchone()
        #print (book)
        cursor.execute (sql3)
        #print (sql3)
        results = cursor.fetchall()
        #print (results)
    except:
        print ("error")
    cursor.close()
    db.close()
    return render_template("listCopyBook.html",book = book,rs = results)

#对图书副本执行修改操作
@app.route("/updateCopyBook",methods=['GET','POST'])
def updateCopyBook():
    copybookid = request.form['copybookid']
    place = request.form['place']
    status = request.form['status']
    is_borrow = request.form['is_borrow']
    id = request.form['bookid']

    sql = "update imd_copybook set place='{}',copybookid='{}',status='{}',is_borrow='{}' where copybookid='{}'"
    sql = sql.format(place,copybookid,status,is_borrow,copybookid)
    print(sql)
    db = pymysql.connect(hostName, userName, userPassword, dbName)
    cursor = db.cursor()

    try:
        cursor.execute(sql)
    except:
        print ("error")
    cursor.close()
    db.close()
    return redirect(url_for("listCopyBook",id=id))

#对图书副本执行删除操作
@app.route("/delCopyBook/<copybookid>")
def delCopyBook(copybookid):
    sql = "delete from imd_copybook where copybookid='{}'"
    sql = sql.format(copybookid)
    db = pymysql.connect( hostName, userName, userPassword, dbName)
    cursor = db.cursor()
    try:
        #print (sql)
        cursor.execute(sql)
    except:
        print("error")
    cursor.close()
    db.close()
    return redirect(url_for("listBook"))

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
def bookShowJson():
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
