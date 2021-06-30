
from flask import Flask, render_template, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

import logging
import yaml

app = Flask(__name__)
log = logging.getLogger('werkzeug')
log.disabled=True
log.setLevel(logging.ERROR)

db_config = yaml.load(open('database.yaml'))
app.config['SQLALCHEMY_DATABASE_URI'] = db_config['uri'] 
db = SQLAlchemy(app)
CORS(app)

class Cliente(db.Model):
    __tablename__ = "ClientePython"
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(255))
    endereco = db.Column(db.String(255))
    cpf = db.Column(db.String(255))

    def __init__(self, nome, endereco, cpf):
        self.nome = nome
        self.endereco = endereco
        self.cpf = cpf
    
    def __repr__(self):
        return '%s/%s/%s/%s' % (self.id, self.nome, self.endereco, self.cpf)

@app.route('/api/Clientes', methods=['POST', 'GET'])
def data():
    if request.method == 'POST':
        body = request.json
        nome = body['nome']
        endereco = body['endereco']
        cpf = body['cpf']

        data = Cliente(nome, endereco, cpf)
        db.session.add(data)
        db.session.commit()

        return jsonify({
            'status': 'Cliente foi inserido!',
            'nome': nome,
            'endereco': endereco,
            'cpf': cpf
        })
    
    if request.method == 'GET':
        data = Cliente.query.order_by(Cliente.id).all()        
        dataJson = []
        for i in range(len(data)):
            dataDict = {
                'id': str(data[i]).split('/')[0],
                'nome': str(data[i]).split('/')[1],
                'endereco': str(data[i]).split('/')[2],
                'cpf': str(data[i]).split('/')[3]

            }
            dataJson.append(dataDict)
        return jsonify(dataJson)

@app.route('/cliente/<string:id>', methods=['GET', 'DELETE', 'PUT'])
def onedata(id):

    if request.method == 'GET':
        data = Cliente.query.get(id)
        dataDict = {
            'id': str(data).split('/')[0],
            'nome': str(data).split('/')[1],
            'endereco': str(data).split('/')[2],
            'cpf': str(data).split('/')[3]
        }
        return jsonify(dataDict)
        
    if request.method == 'DELETE':
        delData = Cliente.query.filter_by(id=id).first()
        db.session.delete(delData)
        db.session.commit()
        return jsonify({'status': 'Cliente '+id+' foi excluido!'})

    if request.method == 'PUT':
        body = request.json
        newNome = body['nome']
        newEndereco = body['endereco']
        newCpf = body['cpf']
        editData = Cliente.query.filter_by(id=id).first()
        editData.nome = newNome
        editData.endereco = newEndereco
        editData.cpf = newCpf
        db.session.commit()
        return jsonify({'status': 'Cliente '+id+' foi atualizado!'})

@app.route('/')
def hello():
    return "Hello World!"

@app.route('/ping')
def ping():
    return "Pong"

if __name__ == '__main__':
    import os
    HOST = os.environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(os.environ.get('SERVER_PORT', '5555'))
    except ValueError:
        PORT = 5555
    app.run(HOST, PORT, debug=False, threaded=True, use_debugger=False)
