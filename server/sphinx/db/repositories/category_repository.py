from db.repositories.base_repository import BaseRepository 

class CategoryRepository(BaseRepository):

    def __init__(self):
        self.table = "categories"
        super().__init__()

    def get_categories(self):
        categories = list(self.db['categories'].find())

        return categories
