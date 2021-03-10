from db.Database import Database

class Controller:
    def __init__(self):
        self.db = Database()

    def get_categories(self):
        return self.db.get_categories()

    def get_question_by_id(self, id):
        response = {
            'options': []
        }
        
        result = self.db.get_question_by_id(id)

        response['id'] = result[0]['q_id']
        response['text'] = result[0]['q_text']

        for r in result:
            option = {}

            option['id'] = r['o_id']
            option['text'] = r['o_text']

            response['options'].append(option)

            if r['correct'] == 1:
                response['answer_id'] = r['o_id']

        return response

    def get_questions_by_category(self, category_id):
        response = []
        questions = {}

        result = self.db.get_questions_by_category(category_id)

        for r in result:
            option = {}
 
            if not r['q_id'] in questions:
                questions[r['q_id']] = {
                    'options': []
                }

                questions[r['q_id']]['text'] = r['q_text']

            option['id'] = r['o_id']
            option['text'] = r['o_text']

            questions[r['q_id']]['options'].append(option)

            if r['correct'] == 1:
                questions[r['q_id']]['answer_id'] = r['o_id']

        for id, question in questions.items():
            response.append({
                'id': id,
                'answer_id': question['answer_id'],
                'text': question['text'],
                'options': question['options']
            })

        return response