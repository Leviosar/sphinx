from db.repositories.base_repository import BaseRepository
from models import UserModel
from sqlalchemy import text
from sqlalchemy.orm import load_only


class UserRepository(BaseRepository):
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

    def search_by_email(self, email):
        search = self.model.email.like(f"%{email}%")
        return self.model.query.filter(search).all()

    def get_ranking(self, limit):
        statement = text(
            """SELECT users.id, users.name as name, users.email as email, SUM(games.points) as points
            FROM users
            INNER JOIN games ON users.id = games.user_id
            GROUP BY users.id
            ORDER BY points DESC
            LIMIT :limite
        """
        )

        rows = self.db.execute(statement, limite=limit)

        return [
            {"id": user[0], "name": user[1], "email": user[2], "points": user[3]}
            for user in rows
        ]
