from random import randint

from flask import Flask, jsonify, request

from .db.Database import Database

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Bem-viado caralho'

@app.route('/questions/<id>')
def get_question_by_id(id):
    db = Database()

    question_options = db.get_question_by_id(id)

    response = {
        'text': '',
        'options': [],
    }

    response['id'] = question_options['question'][1]
    response['text'] = question_options['question'][0]

    for o in question_options['options']:
        option = dict()

        option['text'] = o[0]
        option['id'] = o[2]

        response['options'].append(option)

        if o[1] == 1:
            response['answer_id'] = o[2]

    return jsonify(response)

@app.route('/categories')
def get_categories():
    db = Database()

    categories = db.get_categories()

    response = [{'title': c[1], 'id': c[0]} for c in categories]

    return jsonify(response)
