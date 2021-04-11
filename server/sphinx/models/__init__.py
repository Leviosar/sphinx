from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from .category import CategoryModel
from .user import UserModel
from .game import GameModel
from .game_categories import GameCategoriesModel
from .question import QuestionModel
from .option import OptionModel
from .challenge import ChallengeModel
