from db.repositories.question_repository import QuestionRepository


class QuestionController:
    def __init__(self):
        self.repository = QuestionRepository()

    def get_question_by_id(self, id):
        response = {"options": []}

        result = self.repository.get_question_by_id(id)

        response["id"] = result[0]["q_id"]
        response["text"] = result[0]["q_text"]

        for r in result:
            option = {}

            option["id"] = r["o_id"]
            option["text"] = r["o_text"]

            response["options"].append(option)

            if r["correct"] == 1:
                response["answer_id"] = r["o_id"]

        return response

    def get_questions_by_category(self, ids, limit):
        result = self.repository.get_questions_by_category(ids, limit=limit)

        for row in result:
            row["options"] = self.repository.options(row["id"])
            row["answer_id"] = list(filter(lambda option: option["correct"] == 1, row["options"]))[0]["id"]

        return {
            "page": 1,
            "per_page": limit,
            "count": len(result),
            "data": result
        }
