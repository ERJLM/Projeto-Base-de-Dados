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

# MAIN ENDPOINTS
# Layoff
@APP.route('/layoff/')
def list_layoff():
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
      SELECT INDUSTRY.IndustryId,INDUSTRY.Name 
      FROM INDUSTRY
      JOIN COMPANY_INDUSTRY USING(IndustryId)
      JOIN COMPANY USING(CompanyId)
      JOIN BRANCH USING(CompanyId)
      JOIN LAYOFF USING(BranchId)
      WHERE LayoffId = %s 
      ''', id).fetchall()

  return render_template('layoff.html', 
           layoff=layoff, company=company,branches=branches,industries=industries)

# Company
@APP.route('/company/<int:id>/')
def get_company(id):
  company = db.execute(
      '''
      SELECT CompanyId,
            Name 
      FROM COMPANY
      WHERE CompanyId = %s
      ''', id).fetchone()

  if company is None:
     abort(404, 'Company id {} does not exist.'.format(id))

  branches = db.execute(
      '''
      SELECT BranchId FROM BRANCH WHERE
      CompanyId = %s
      ''', id).fetchall()
  industries = db.execute(
      '''
      SELECT INDUSTRY.IndustryId,INDUSTRY.Name 
      FROM INDUSTRY
      JOIN COMPANY_INDUSTRY USING(IndustryId)
      WHERE CompanyId = %s 
      ''', id).fetchall()

  return render_template('company.html', 
           company=company,branches=branches,industries=industries)

@APP.route('/company/')
def list_company():
    companys = db.execute('''
      SELECT CompanyId,
            Name
      FROM COMPANY
    ''').fetchall()
    return render_template('company-list.html', companys=companys)


# Branch
@APP.route('/branch/<int:id>/')
def get_branch(id):
  branch = db.execute(
      '''
      SELECT BranchId,CompanyId,LocationId
      FROM BRANCH
      WHERE BranchId = %s
      ''', id).fetchone()

  if branch is None:
     abort(404, 'Branch id {} does not exist.'.format(id))

  return render_template('branch.html',branch=branch)

@APP.route('/branch/')
def list_branch():
    branchs = db.execute('''
      SELECT BranchId,
            LocationId,
            CompanyId,
            Headquarter
      FROM BRANCH
    ''').fetchall()
    return render_template('branch-list.html', branchs=branchs)

  # Industry
@APP.route('/industry/')
def list_idustry():
    industrys = db.execute('''
      SELECT IndustryId,
            Name
      FROM INDUSTRY
    ''').fetchall()
    return render_template('industry-list.html', industrys=industrys)

@APP.route('/industry/<int:id>/')
def get_industry(id):
  industry = db.execute(
      '''
      SELECT IndustryId,Name
      FROM INDUSTRY
      WHERE IndustryId = %s
      ''', id).fetchone()

  if industry is None:
     abort(404, 'Industry id {} does not exist.'.format(id))

  return render_template('industry.html',industry=industry)

  # Location
@APP.route('/location/<int:id>/')
def get_location(id):
  location = db.execute(
      '''
      SELECT LocationId,Name,CountryId
      FROM LOCATION
      WHERE LocationId = %s
      ''', id).fetchone()

  if location is None:
     abort(404, 'Location id {} does not exist.'.format(id))

  return render_template('location.html',location=location)

@APP.route('/location/')
def list_location():
    locations = db.execute('''
      SELECT LocationId,
            CountryId
      FROM LOCATION
    ''').fetchall()
    return render_template('location-list.html', locations=locations)

  

  # Country
@APP.route('/country/<int:id>/')
def get_country(id):
  country = db.execute(
      '''
      SELECT CountryId,Name
      FROM COUNTRY
      WHERE CountryId = %s
      ''', id).fetchone()

  if country is None:
     abort(404, 'Country id {} does not exist.'.format(id))

  return render_template('country.html',country=country)

@APP.route('/country/')
def list_country():
    countrys = db.execute('''
      SELECT Name,
            CountryId
      FROM COUNTRY
    ''').fetchall()
    return render_template('country-list.html', countrys=countrys)




# OTHER 3 ENDPOINTS
@APP.route('/mostlayoffs/all/')
def list_most_company():
    company = db.execute('''
      SELECT COMPANY.CompanyId,COMPANY.Name,BRANCH.BranchId,COUNT(LAYOFF.LayoffId) AS N FROM BRANCH JOIN LAYOFF USING(BranchId) JOIN COMPANY USING(CompanyId) JOIN LOCATION USING(LocationId) JOIN COUNTRY USING(CountryId) GROUP BY BRANCH.BranchId ORDER BY N DESC LIMIT 1
    ''').fetchone()
    return render_template('custom.html', company=company)

@APP.route('/mostlayoffs/month/')
def list_most_month():
    month = db.execute('''
      SELECT MONTH(LAYOFF.Date) AS Name,COUNT(LAYOFF.LayoffId) AS N FROM LAYOFF GROUP BY MONTH(LAYOFF.Date) ORDER BY N DESC LIMIT 1
    ''').fetchone()
    return render_template('customMonth.html', month=month)

@APP.route('/mostlayoffs/industry/')
def list_most_industry():
    industry = db.execute('''
      SELECT INDUSTRY.Name,COUNT(LAYOFF.LayoffId) AS N FROM LAYOFF JOIN BRANCH USING(BranchId) JOIN COMPANY USING(CompanyId) JOIN COMPANY_INDUSTRY USING(CompanyId) JOIN INDUSTRY USING(IndustryId) GROUP BY INDUSTRY.Name ORDER BY N DESC LIMIT 1
    ''').fetchone()
    return render_template('customIndustry.html', industry=industry)