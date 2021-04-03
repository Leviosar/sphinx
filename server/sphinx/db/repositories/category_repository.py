from sphinx.db.repositories.base_repository import BaseRepository
from sphinx.models import CategoryModel


class CategoryRepository(BaseRepository):
    def __init__(self):
        self.model = CategoryModel
        super().__init__()

    def get_categories(self):
        categories = self.model.query.all()
        return list(categories)
