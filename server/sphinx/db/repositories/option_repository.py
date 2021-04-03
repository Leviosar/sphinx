from db.repositories.base_repository import BaseRepository


class OptionRepository(BaseRepository):
    def __init__(self):
        self.table = "options"
        super().__init__()

    def get(self, option_id):
        return self.db.query(
            f"SELECT options.* FROM options WHERE id = :param LIMIT 1", param=option_id
        )
