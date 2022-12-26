import warnings
warnings.filterwarnings("ignore", category=FutureWarning)
from flask import abort, render_template, Flask
import logging
import db

APP = Flask(__name__)

# Start page
@APP.route('/')
def index():
    lots=list(db.execute("SELECT COUNT(*) FROM LAYOFF"))
    many=list(db.execute("SELECT SUM(WorkersLaid) FROM LAYOFF"))
    odate=list(db.execute("SELECT YEAR(MIN(Date)) FROM LAYOFF"))
    return render_template('index.html',message='People in Movement.',lots=lots[0].get('COUNT(*)'),many=many[0].get('SUM(WorkersLaid)'),odate=odate[0].get('YEAR(MIN(Date))'))

@APP.route('/about.html')
def about():
    return render_template('about.html')

@APP.route('/database.html')
def database():
    layoff=list(db.execute("SELECT COUNT(*) FROM LAYOFF"))
    company=list(db.execute("SELECT COUNT(*) FROM COMPANY"))
    industry=list(db.execute("SELECT COUNT(*) FROM INDUSTRY"))
    lupdate=list(db.execute("SELECT MAX(Date) FROM LAYOFF"))
    return render_template('database.html',company=company[0].get('COUNT(*)'),layoff=layoff[0].get('COUNT(*)'),industry=industry[0].get('COUNT(*)'),lupdate=lupdate[0].get('MAX(Date)'))
