from sqlalchemy import create_engine
from sphinx.config import DB_PATH


class BaseRepository:
    def __init__(self):
        self.db = create_engine(DB_PATH)
