import sqlite3

import dataset

from config import DB_PATH


class BaseRepository:
    def __init__(self):
        self.db = dataset.connect(f"sqlite:///{DB_PATH}")
