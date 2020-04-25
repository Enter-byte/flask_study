from flask import Flask,session

app = Flask(__name__)

app.config['SECRET_KEY'] = 'abc'
@app.route('/')
def index():
    session['isLogin'] = 'Yes';
    session['name'] = 'lsy'
    return "session set "

@app.route('/session')
def showSession():
    return session['name']

@app.route('/session2')
def showSession2():
    return session.get('isLogin')

if __name__ == '__main__':
    app.run()