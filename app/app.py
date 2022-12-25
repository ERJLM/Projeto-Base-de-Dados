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
    return render_template('index.html',message='People in Movement.',lots=lots[0].get('COUNT(*)'),many=many[0].get('SUM(WorkersLaid)'))

@APP.route('/about.html')
def about():
    return render_template('about.html')

@APP.route('/database.html')
def database():
    return render_template('database.html')
