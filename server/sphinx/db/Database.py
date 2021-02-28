import sqlite3

from ..config import DB_PATH

class Database:
    def __init__(self):
        self.conn = sqlite3.connect(DB_PATH)
        self.c = self.conn.cursor()

    def get_question_by_id(self, id):
        s = f'''SELECT text
                FROM questions
                WHERE id = ?
            '''

        s2 = f'''SELECT text, correct
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
