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

@APP.route('/search/company/<expr>/')
def search_movie(expr):
  search = { 'expr': expr }
  expr = '%' + expr + '%'
  movies = db.execute(
      ''' 
      SELECT MovieId, Title
      FROM MOVIE 
      WHERE Title LIKE %s
      ''', expr).fetchall()
  return render_template('movie-search.html',
           search=search,movies=movies)

# Main Layoff
@APP.route('/layoff/')
def list_actors():
    layoffs = db.execute('''
      SELECT LayoffId,
            BranchId,
            FundsRaised,
            WorkersLaid,
            Percentage,
            Date 
      FROM LAYOFF
    ''').fetchall()
    return render_template('layoff-list.html', layoffs=layoffs)

@APP.route('/layoff/<int:id>/')
def get_layoff(id):
  layoff = db.execute(
      '''
      SELECT LayoffId,
            BranchId,
            FundsRaised,
            WorkersLaid,
            Percentage,
            Date 
      FROM LAYOFF 
      WHERE LayoffId = %s
      ''', id).fetchone()

  if layoff is None:
     abort(404, 'Layoff id {} does not exist.'.format(id))

  company = db.execute(
      '''
      SELECT CompanyId,Name 
      FROM COMPANY
      JOIN BRANCH USING(CompanyId)
      JOIN LAYOFF USING(BranchId)
      WHERE LayoffId = %s 
      ''', id).fetchall()

  branches = db.execute(
      '''
      SELECT BranchId FROM BRANCH WHERE
      CompanyId=(
      SELECT CompanyId 
      FROM COMPANY
      JOIN BRANCH USING(CompanyId)
      JOIN LAYOFF USING(BranchId)
      WHERE LayoffId = %s)
      ''', id).fetchall()
  industries = db.execute(
      '''
      SELECT INDUSTRY.Name 
      FROM INDUSTRY
      JOIN COMPANY_INDUSTRY USING(IndustryId)
      JOIN COMPANY USING(CompanyId)
      JOIN BRANCH USING(CompanyId)
      JOIN LAYOFF USING(BranchId)
      WHERE LayoffId = %s 
      ''', id).fetchall()

  return render_template('layoff.html', 
           layoff=layoff, company=company,branches=branches,industries=industries)