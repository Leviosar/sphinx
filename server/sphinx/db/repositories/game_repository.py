from db.repositories.base_repository import BaseRepository

class GameRepository(BaseRepository):
    def __init__(self):
        super().__init__()

    def get_games_by_user_id(self, user_id):
        games = dict()
        
        games["games"] = list(self.db["game"].find(user_id=user_id))

        return games

    def store_game(self, user_id, start, end, points):
        return self.db["game"].insert(dict(
            user_id=user_id,
            start=start,
            end=end,
            points=points,
        ))

    def store_game_category(self, game_id, category_id):
        return self.db["game_categories"].insert(dict(
            game_id=game_id,
            category_id=category_id,
        ))