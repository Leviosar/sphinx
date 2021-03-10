from flask import Flask, jsonify, request

from db.Database import Database
from Controller import Controller

app = Flask(__name__)

controller = Controller()

@app.route('/')
def hello_world():
    return 'Bem-viado caralho'

@app.route('/questions')
def get_questions_by_category():
    category_id = request.args.get('category')

    # TODO: implement error treating
    if category_id is None:
        return 'Tá de sacanagem menor'

    questions = controller.get_questions_by_category(category_id)

    return jsonify(questions)

@app.route('/questions/<id>')
def get_question_by_id(id):
    response = controller.get_question_by_id(id)

    return jsonify(response)

@app.route('/categories')
def get_categories():
    categories = controller.get_categories()

    return jsonify(categories)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
