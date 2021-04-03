from sphinx.db.repositories.category_repository import CategoryRepository


class CategoryController:
    def __init__(self):
        self.repository = CategoryRepository()

    def get_categories(self):
        return self.repository.get_categories()
