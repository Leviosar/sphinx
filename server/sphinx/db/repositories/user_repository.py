from db.repositories.base_repository import BaseRepository
from models import UserModel


class UserRepository:
    def __init__(self):
        self.model = UserModel
        super().__init__()

    def get(self, user_id):
        return self.model.query.get(user_id)

    def store(self, user_id, name, email, photo):
        return self.model.create(id=user_id, name=name, email=email, photo=photo)

    def store_token(self, user_id, token):
        user = self.get(user_id)
        user.token = token
        user.update()
        return user

    def get_ranking(self, limit):
        return self.db.execute(
            f"""SELECT users.id, users.name as name, users.email as email, SUM(game.points) as points
              FROM users
              INNER JOIN game ON users.id = game.user_id
              GROUP BY game.user_id
              ORDER BY points DESC
              LIMIT :_limit""",
            _limit=limit,
        )
