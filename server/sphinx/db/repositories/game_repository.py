from db.repositories.base_repository import BaseRepository

class GameRepository(BaseRepository):
    def __init__(self):
        super().__init__()

    def get_games_by_user_id(self, user_id):
        games = dict()
        
        games["games"] = list(self.db["game"].find(user_id=user_id))

        return games