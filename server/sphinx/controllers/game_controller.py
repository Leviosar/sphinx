from datetime import datetime

from db.repositories.game_repository import GameRepository


class GameController:
    def __init__(self):
        self.repository = GameRepository()
    
    def get_games_by_user_id(self, user_id):
        games = self.repository.get_games_by_user_id(user_id)

        return games

    def register(self, user_id, start, end, points, categories):
        try:
            start = datetime.fromisoformat(start)
            end = datetime.fromisoformat(end)
        except ValueError:
            return {"success": False, "error": True, "message": "Wrong date format", "code": 422}

        game_id = self.repository.store_game(user_id, start, end, points)

        for c in categories:
            self.repository.store_game_category(game_id, c)

        return {"error": False}