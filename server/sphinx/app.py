from flask import Flask, jsonify, request

from db.Database import Database

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

        question['text'] = q['text']
        question['id'] = q['id']

        for o in questions['options']:
            option = dict()

            if o['question_id'] == q['id']:
                option['id'] = o['id']
                option['text'] = o['text']

                if o['correct'] == 1:
                    question['answer_id'] = o['id']

                question['options'].append(option)

        response.append(question)

    return jsonify(response)

@app.route('/questions/<id>')
def get_question_by_id(id):
    db = Database()

    question_options = db.get_question_by_id(id)
    print(question_options)

    response = {
        'text': '',
        'options': [],
    }

    response['id'] = question_options['question']['id']
    response['text'] = question_options['question']['text']

    for o in question_options['options']:
        option = dict()

        option['text'] = o['text']
        option['id'] = o['id']

        response['options'].append(option)

        if o['correct'] == 1:
            response['answer_id'] = o['id']

    return jsonify(response)

@app.route('/categories')
def get_categories():
    db = Database()

    categories = db.get_categories()

    return jsonify(categories)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
