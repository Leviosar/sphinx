from db.repositories.base_repository import BaseRepository
from models import UserModel, ChallengeModel, GameModel
from sqlalchemy import text
from sqlalchemy.orm import load_only
from datetime import datetime
import json


class UserRepository(BaseRepository):
    def __init__(self):
        self.model = UserModel
        self.challenge_model = ChallengeModel
        super().__init__()

    def get(self, user_id):
        user = self.model.query.get(user_id)
        user = user.__dict__

        user.pop("_sa_instance_state", None)

        user["token"] = {
            "access_token": user["token"],
            "expiration_date": datetime.now().isoformat(sep=" ", timespec="seconds"),
            "expires_in": 86400,
            "refresh_token": "",
            "type_token": "Bearer",
        }

        return user

    def store(self, user_id, name, email, photo):
        return self.model.create(id=user_id, name=name, email=email, photo=photo)

    def store_token(self, user_id, token):
        user = self.model.query.get(user_id)
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

    def get_category_ranking(self, limit, categories):
        array = json.dumps(categories).replace('[', '(').replace(']', ')')
        
        statement = text(
            f"""SELECT users.id, users.name as name, users.email as email, SUM(games.points) as points
            FROM users
            INNER JOIN games ON users.id = games.user_id
            INNER JOIN game_categories ON game_categories.game_id = games.id
            WHERE game_categories.category_id IN {array}
            GROUP BY users.id
            ORDER BY points DESC
            LIMIT :limite
        """
        )

        rows = self.db.execute(statement, limite=limit, categories=categories)

        return [
            {"id": user[0], "name": user[1], "email": user[2], "points": user[3]}
            for user in rows
        ]

    def create_challenge(self, challenger_user_id, challenged_user_id, started_at):
        return self.challenge_model.create(
            challenged_user_id=challenged_user_id,
            challenger_user_id=challenger_user_id,
            started_at=started_at,
        )

    def update_challenge(
        self,
        challenger_user_id,
        challenged_user_id,
        challenger_game_id,
        challenged_game_id,
        started_at,
    ):
        challenge = self.challenge_model.query.filter(
            self.challenge_model.challenger_user_id == challenger_user_id,
            self.challenge_model.challenged_user_id == challenged_user_id,
            self.challenge_model.started_at == started_at,
        ).all()

        print(challenged_game_id)
        print(challenger_game_id)

        if challenge:
            if challenger_game_id is not None:
                challenge[0].challenger_game_id = challenger_game_id
            if challenged_game_id is not None:
                challenge[0].challenged_game_id = challenged_game_id

            challenge[0].update()

            return challenge[0]
        else:
            return []

    def get_all_challenges_from_user(self, user_id):
        challenges = self.challenge_model.query.filter(
            (self.challenge_model.challenger_user_id == user_id)
            | (self.challenge_model.challenged_user_id == user_id),
        ).all()

        challenges = [challenge.__dict__ for challenge in challenges]

        for challenge in challenges:

            del challenge["_sa_instance_state"]

            challenge["challenger_game"] = GameModel.query.get(
                challenge["challenger_game_id"]
            )
            challenge["challenged_game"] = GameModel.query.get(
                challenge["challenged_game_id"]
            )
            challenge["challenger_user"] = self.get(challenge["challenger_user_id"])
            challenge["challenged_user"] = self.get(challenge["challenged_user_id"])

            del challenge["challenger_game_id"]
            del challenge["challenged_game_id"]
            del challenge["challenger_user_id"]
            del challenge["challenged_user_id"]

        return challenges
