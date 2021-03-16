import jwt

from db.repositories.user_repository import UserRepository
from datetime import datetime


class UserController:
    def __init__(self):
        self.repository = UserRepository()

    def get(self, user_id):
        user = self.repository.get(user_id)

        if len(user) != 0:
            return user
        else:
            return None

    def auth(self, user_id):
        user = self.repository.get(user_id)

        if len(list(user)) != 0:
            token_fields = {"id": user_id, "time": datetime.now().isoformat()}

            token = jwt.encode(token_fields, "segredo, mané", algorithm="HS256")

            self.repository.store_token(user_id, token)

            return {"token": token}
        else:
            return {"error": True, "msg": "User not found"}

    def register(self, user_id, name, email, photo):
        user = self.repository.store(user_id, name, email, photo)
        
        return self.auth(user_id)

    def get_ranking(self, limit=15):
        response = self.repository.get_ranking(limit)

        return response