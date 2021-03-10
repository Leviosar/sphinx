import sqlite3

import dataset

from config import DB_PATH

class Database:
    def __init__(self):
        #self.db = dataset.connect(f'sqlite:///{DB_PATH}')
        ...

    def get_questions_by_category(self, category_id):
        questions = list(self.db['questions'].find(
            category_id=category_id,
            order_by='id',
            _limit=100
        ))

        options = list(self.db.query(
            f'''SELECT text, correct, id, question_id
                 FROM options
                 WHERE question_id
                    IN (
                        SELECT id
                        FROM questions WHERE category_id = :category_id
                    )
                 ORDER BY question_id
                 LIMIT 500
             ''',
             category_id=category_id
        ))

        return {'questions': questions, 'options': options}

    def get_question_by_id(self, id):
        db = dataset.connect(f'sqlite:///{DB_PATH}')
        question = db['questions'].find_one(
            id=id
        )

        options = list(db.query(
            f'''SELECT text, correct, id
                 FROM options
                 WHERE question_id = :question_id
             ''',
             question_id=id
        ))

        return {'question': question, 'options': options}

    def get_categories(self):
        categories = list(self.db['categories'].find())

        return categories
