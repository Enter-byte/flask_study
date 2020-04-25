from flask import Flask, render_template
app = Flask(__name__)
@app.route("/")
def hello_world():
    return "我是李松烨"
@app.route("/Hello/<name>")
def hello_name(name):
    return "<span style='color:red'>Hello</span>,<strong>%s</strong>"%name
@app.route("/hello/<name>")
def hello(name):
    return render_template('Hello.html',namex=name)
if __name__ == '__main__':
    app.run(host="0.0.0.0")
