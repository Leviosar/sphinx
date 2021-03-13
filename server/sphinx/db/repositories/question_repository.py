from db.repositories.base_repository import BaseRepository
import dataset
import random

class QuestionRepository(BaseRepository):
    def __init__(self):
        super().__init__()
        self.table = dataset.Table(self.db, 'questions')

    def get_questions_by_category(self, ids, limit = 15):
        response = list(self.table.find(category_id={'in': ids}))
        random.shuffle(response)
        return response[:limit]

    def get_question_by_id(self, id):
        response = list(
            self.db.query(
                f"""SELECT
                options.id as o_id, options.text as o_text, options.correct, questions.id as q_id, questions.text as q_text
                FROM options
                INNER JOIN questions ON options.question_id = questions.id
                WHERE question_id = :question_id
                """,
                question_id=id,
            )
        )

        return response

    def options(self, question_id):
        response = list(
            self.db.query(
                f"""SELECT options.* FROM options
                WHERE options.question_id = :question_id
                """,
                question_id=question_id,
            )
        )

        return response