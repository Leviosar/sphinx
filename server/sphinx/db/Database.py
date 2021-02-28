import sqlite3

from ..config import DB_PATH

class Database:
    def __init__(self):
        self.conn = sqlite3.connect(DB_PATH)
        self.c = self.conn.cursor()

    def get_categories(self):
        s = f'''SELECT id, title FROM categories'''

        r = self.c.execute(s)

        return r.fetchall()
