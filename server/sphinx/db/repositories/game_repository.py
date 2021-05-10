from db.repositories.base_repository import BaseRepository
from models import GameModel, GameCategoriesModel
from sqlalchemy import text

class GameRepository(BaseRepository):
    def __init__(self):
        self.model = GameModel
        self.game_categories_model = GameCategoriesModel
        super().__init__()

    def get_games_by_user_id(self, user_id):
        games = self.model.query.filter_by(user_id=user_id).all()
        
        return games

    def store_game(self, user_id, start, end, points):
        return self.model.create(
            user_id=user_id, started_at=start, ended_at=end, points=points
        )

    def store_game_category(self, game_id, category_id):
        return self.game_categories_model.create(
            game_id=game_id, category_id=category_id
        )

    def delete(self, game_id):
        statement = text(
            f"""
            DELETE FROM game_categories where game_id = :game_id
            """
        )

        self.db.execute(statement, game_id=game_id)

        statement = text(
            f"""
                DELETE FROM games where id = :game_id
            """
        )

        if self.db.execute(statement, game_id=game_id):
            return {"error": False, "message": "Game deleted"}
        else:
            return {"error": True, "message": "Could not delete games and also i didn't used transactions so maybe you're fckd"}