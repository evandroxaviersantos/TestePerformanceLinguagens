import flask
from flask import request, jsonify
import fdb, json, collections
#import uvicorn

app = flask.Flask(__name__)
app.config["DEBUG"] = False

con = fdb.connect(
    host='127.0.0.1', database='E:\\CienciaDeDados\\PythonIniciante\\apiRest\\AGRO.FDB',
    user='sysdba', password='masterkey'
  )
#con = fdb.connect(dsn='127.0.0.1:E:\\CienciaDeDados\\PythonIniciante\\apiRest\\AGRO.FDB', user='sysdba', password='masterkey')

@app.route('/api/ping', methods=['GET'])
def ping():
    return '''pong'''

@app.route('/api/clientes', methods=['GET', 'POST'])
def clientes():
    if request.method == 'GET':
        cur = con.cursor()
        cur.execute("select * from CLIENTEDB")
        rows = cur.fetchall()        
        
        objects_list = []
        for row in rows:
            d = collections.OrderedDict()
            d["id"] = row[0]
            d["nome"] = row[1]
            d["cpf"] = row[2]
            d["endereco"] = row[3]
            objects_list.append(d)
        return json.dumps(objects_list) 
    if request.method == 'POST':
        curPost = con.cursor()
        dados = request.get_json()
        sql   = "insert into CLIENTEDB (nome, cpf, endereco) values (?,?,?)"
        curPost.execute(sql, (dados.get('nome', ''),dados.get('cpf', ''),dados.get('endereco', '')))
        con.commit()
        return  dados
   

if __name__ == "__main__":
    from waitress import serve
    serve(app, host="127.0.0.1", connection_limit=1000000, backlog=100000, port=5000, threads=400)
