#!/Library/Frameworks/Python.framework/Versions/2.7/bin/python

from flask import render_template, Flask, jsonify
import pymysql as mdb
app = Flask(__name__)

fcc_db = mdb.connect(user="root", host="localhost", db="FCC", charset="utf8")

@app.route('/')
@app.route('/index')
def index():
    return render_template('index_grayscale.html', title = 'Home') 

@app.route("/fcc_db_json")
def states_json():
	with fcc_db:
		cur = fcc_db.cursor()
		cur.execute("SELECT state, comment_rate, sentiment_score, duplication_rate FROM states;")
		query_results = cur.fetchall()
	states = []
	for result in query_results:
		states.append(dict(state=result[0], comment_rate=result[1], sentiment_score=result[2], duplication_rate=result[3]))
	return jsonify(dict(states=states))


if __name__ == "__main__":
	app.run(debug = True)

