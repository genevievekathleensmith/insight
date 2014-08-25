#!/Library/Frameworks/Python.framework/Versions/2.7/bin/python

from flask import render_template, Flask, jsonify, request
import pymysql as mdb
app = Flask(__name__)


@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html', title = 'Home') 

@app.route("/fcc_db_json/")
def whatever():
	fcc_db = mdb.connect(user="root", host="localhost", db="FCC", charset="utf8")
	with fcc_db:
		cur = fcc_db.cursor()
		cur.execute("SELECT state, comment_rate, sentiment_score, duplication_rate FROM states;")
		query_results = cur.fetchall()
	states = []
	for result in query_results:
		states.append(dict(state=result[0], comment_rate=result[1], sentiment_score=result[2], duplication_rate=result[3]))
	return jsonify(dict(states=states))


@app.route("/fcc_db_json_test/", methods=["GET"])
def anything():
	fcc_test_db = mdb.connect(user="root", host="localhost", db="FCC", charset="utf8")
	print 'hello'
	inputstate = request.args.get('inputstate')
	with fcc_test_db:
		cur = fcc_test_db.cursor()
		cur.execute("SELECT state, comment_rate, sentiment_score, duplication_rate, rank, average, sent_average, full_name FROM states WHERE state = '%s'" %(inputstate))
		query_results = cur.fetchall()
		mydict = {'state':query_results[0][0], 
			'comment_rate':round(query_results[0][1],2), 
			'sentiment_score':round(query_results[0][2],2), 
			'duplication_rate':round(query_results[0][3]*100,1),
			'comment_rank':query_results[0][4],
			'comment_average':query_results[0][5],
			'sent_avergae':query_results[0][6],
			'full_name':query_results[0][7]}
		print mydict	
    	return jsonify(mydict)



if __name__ == "__main__":
	app.run(host='0.0.0.0',port=5000)

