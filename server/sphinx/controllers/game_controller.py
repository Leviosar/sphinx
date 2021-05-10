from datetime import datetime

from db.repositories.game_repository import GameRepository


class GameController:
    def __init__(self):
        self.repository = GameRepository()

    def get_games_by_user_id(self, user_id):
        return self.repository.get_games_by_user_id(user_id)

    def register(self, user_id, start, end, points, categories):
        try:
            start = datetime.fromisoformat(start)
            end = datetime.fromisoformat(end)
        except ValueError:
            return {
                "success": False,
                "error": True,
                "message": "Wrong date format",
                "code": 422,
            }

        game = self.repository.store_game(user_id, start, end, points)

        for category in categories:
            self.repository.store_game_category(game.id, category)

        return {"error": False}

    def delete(self, game_id):
        return self.repository.delete(game_id)