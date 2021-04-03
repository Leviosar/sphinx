from sphinx.db.repositories.base_repository import BaseRepository
from sphinx.models import QuestionModel
import random

class QuestionRepository(BaseRepository):
    def __init__(self):
        super().__init__()
        self.model = QuestionModel

    def get_questions_by_category(self, ids, limit = 15):
        questions = self.model.query.filter(self.model.category_id.in_(ids)).all()
        random.shuffle(questions)
        return questions[:limit]

    def get_question_by_id(self, question_id):
        return self.model.query.get(question_id)