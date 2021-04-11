import jwt

from db.repositories.user_repository import UserRepository
from datetime import datetime


class UserController:
    def __init__(self):
        self.repository = UserRepository()

    def get(self, user_id):
        return self.repository.get(user_id)

    def auth(self, user_id):
        user = self.repository.get(user_id)

        if user:
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

    def search_by_email(self, email):
        users = self.repository.search_by_email(email)
        users = [user.__dict__ for user in users]

        for user in users:
            del user['_sa_instance_state']

            user["token"] = {
                "access_token": user["token"],
                "expiration_date": datetime.now().isoformat(sep=" ", timespec='seconds'),
                "expires_in": 86400,
                "refresh_token": "",
                "type_token": "Bearer"
            }

        return users


    def create_challenge(self, challenger_user_id, challenged_user_id, started_at):
        return self.repository.create_challenge(challenger_user_id, challenged_user_id, started_at)


    def update_challenge(self, challenger_user_id, challenged_user_id, challenger_game_id, challenged_game_id, started_at):
        return self.repository.update_challenge(challenger_user_id, challenged_user_id, challenger_game_id, challenged_game_id, started_at)

    
    def get_all_challenges_from_user(self, user_id):
        return self.repository.get_all_challenges_from_user(user_id)