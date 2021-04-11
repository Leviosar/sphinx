from db.repositories.base_repository import BaseRepository
from models import GameModel, GameCategoriesModel


class GameRepository(BaseRepository):
    def __init__(self):
        self.model = GameModel
        self.game_categories_model = GameCategoriesModel
        super().__init__()

    def get_games_by_user_id(self, user_id):
        return self.model.query.filter_by(user_id=user_id).all()

    def store_game(self, user_id, start, end, points):
        return self.model.create(
            user_id=user_id, started_at=start, ended_at=end, points=points
        )

    def store_game_category(self, game_id, category_id):
        return self.game_categories_model.create(
            game_id=game_id, category_id=category_id
        )
