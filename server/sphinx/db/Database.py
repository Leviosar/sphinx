import sqlite3

from ..config import DB_PATH

class Database:
    def __init__(self):
        self.conn = sqlite3.connect(DB_PATH)
        self.c = self.conn.cursor()

    def get_questions_by_category(self, category_id):
        s = f'''SELECT text, id
                FROM questions
                WHERE category_id = ?
                ORDER BY id
                LIMIT 100
            '''

        s2 = f'''SELECT text, correct, id, question_id
                 FROM options
                 WHERE question_id
                    IN (
                        SELECT id
                        FROM questions WHERE category_id = ?
                    )
                 ORDER BY question_id
                 LIMIT 100
             '''

        questions = self.c.execute(s, [category_id]).fetchall()
        options = self.c.execute(s2, [category_id]).fetchall()

        return {'questions': questions, 'options': options}

    def get_question_by_id(self, id):
        s = f'''SELECT text, id
                FROM questions
                WHERE id = ?
            '''

        s2 = f'''SELECT text, correct, id
                 FROM options
                 WHERE question_id = ?
             '''

        question = self.c.execute(s, [id]).fetchone()
        options = self.c.execute(s2, [id]).fetchall()

        return {'question': question, 'options': options}

    def get_categories(self):
        s = f'''SELECT id, title FROM categories'''

        r = self.c.execute(s)

        return r.fetchall()
