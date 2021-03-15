from db.repositories.game_repository import GameRepository

class GameController:
    def __init__(self):
        self.repository = GameRepository()
    
    def get_games_by_user_id(self, user_id):
        games = self.repository.get_games_by_user_id(user_id)

        return games