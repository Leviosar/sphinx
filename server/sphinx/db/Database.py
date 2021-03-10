import sqlite3

import dataset

from config import DB_PATH

class Database:
    def __init__(self):
        self.db = dataset.connect(f'sqlite:///{DB_PATH}')

    def get_questions_by_category(self, category_id):
        response = list(self.db.query(
            f'''SELECT
                 options.id as o_id, options.text as o_text, options.correct, questions.id as q_id, questions.text as q_text
                FROM questions
                 INNER JOIN options ON questions.id = options.question_id
                  WHERE questions.category_id = :category_id
            ''',
            category_id=category_id
        ))

        return response

    def get_question_by_id(self, id):
        response = list(self.db.query(
            f'''SELECT
                 options.id as o_id, options.text as o_text, options.correct, questions.id as q_id, questions.text as q_text
                FROM options
                 INNER JOIN questions ON options.question_id = questions.id
                  WHERE question_id = :question_id
             ''',
             question_id=id
        ))

        return response

    def get_categories(self):
        categories = list(self.db['categories'].find())

        return categories
