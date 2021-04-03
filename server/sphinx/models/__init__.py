from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from .category import CategoryModel
from .user import UserModel
from .game import GameModel
from .question import QuestionModel
from .option import OptionModel