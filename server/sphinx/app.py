from flask import Flask, jsonify, request

from .db.Database import Database

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Bem-viado caralho'

@app.route('/questions')
def get_questions_by_category():
    db = Database()

    category_id = request.args.get('category')

    # TODO: implement error treating
    if category_id is None:
        return 'Tá de sacanagem menor'

    questions = db.get_questions_by_category(category_id)

    response = []

    for q in questions['questions']:
        question = {
            'text': '',
            'options': []
        }

        question_id = q[1]

        question['text'] = q[0]
        question['id'] = question_id

        for o in questions['options']:
            option = dict()

            if o[3] == question_id:
                option['id'] = o[2]
                option['text'] = o[0]

                if o[1] == 1:
                    question['answer_id'] = o[2]

                question['options'].append(option)

        response.append(question)

    return jsonify(response)

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
