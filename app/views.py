from flask import render_template, Flask, jsonify
from app import app
import pymysql as mdb

db = mdb.connect(user="root", host="localhost", db="world_innodb", charset='utf8')

fcc_db = mdb.connect(user="root", host="localhost", db="FCC", charset="utf8")

@app.route('/')
@app.route('/index')
def index():
	return render_template("index.html",
        title = 'Home')

@app.route("/jquery")
def index_jquery():
    return render_template('index_js.html') 

@app.route("/neutral")
def index_neutral():
    return render_template('greyscale/index.html') 

@app.route("/db_json")
def cities_json():
	with db:
		cur = db.cursor()
		cur.execute("SELECT Name, CountryCode, Population FROM city ORDER BY Population DESC;")
		query_results = cur.fetchall()
	cities = []
	for result in query_results:
		cities.append(dict(name=result[0], country=result[1], population=result[2]))
	return jsonify(dict(cities=cities))
    
@app.route('/db')
def cities_page():
	with db: 
		cur = db.cursor()
		cur.execute("SELECT Name FROM city LIMIT 15;")
		query_results = cur.fetchall()
	cities = ""
	for result in query_results:
		cities += result[0]
		cities += "<br>"
	return cities

@app.route("/db_fancy")
def cities_page_fancy():
	with db:
		cur = db.cursor()
		cur.execute("SELECT Name, CountryCode, Population FROM city ORDER BY Population LIMIT 15;")

		query_results = cur.fetchall()
	cities = []
	for result in query_results:
		cities.append(dict(name=result[0], country=result[1], population=result[2]))
	return render_template('cities.html', cities=cities) 


@app.route("/neutralopinion")
def index_neutralopinion():
    return render_template('index_grayscale.html') 



@app.route("/states_fancy")
def states_page_fancy():
	with fcc_db:
		cur = fcc_db.cursor()
		cur.execute("SELECT state, comments from FCC;")

		query_results = cur.fetchall()
	states = []
	for result in query_results:
		states.append(dict(state=result[0], comments=result[1]))
	return render_template('states.html', states=states) 

