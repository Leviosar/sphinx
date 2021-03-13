from db.repositories.base_repository import BaseRepository


class UserRepository(BaseRepository):
    def __init__(self):
        self.table = "users"
        super().__init__()

    def get(self, user_id):
        return self.db.query(
            f"SELECT users.* FROM users WHERE id = :param LIMIT 1", param=user_id
        )

    def store(self, user_id, name, email, photo):
        return self.db.query(
            f"INSERT INTO users (id, name, email, photo) values (:user_id, :name, :email, :photo)",
            user_id=user_id,
            name=name,
            email=email,
            photo=photo,
        )

    def store_token(self, user_id, token):
        return self.db.query(
            f"UPDATE users SET token = :token WHERE users.id = :user_id",
            user_id=user_id,
            token=token,
        )
