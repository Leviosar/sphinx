from flask import Flask, jsonify, request

from controllers.user_controller import UserController
from controllers.question_controller import QuestionController
from controllers.category_controller import CategoryController
from controllers.game_controller import GameController

app = Flask(__name__)

user_controller = UserController()
question_controller = QuestionController()
category_controller = CategoryController()
game_controller = GameController()

@app.route("/")
def hello_world():
    return "Index"


@app.route("/register", methods=["POST"])
def register():
    user = {
        "id": request.json.get("id"),
        "name": request.json.get("name"),
        "email": request.json.get("email"),
        "photo": request.json.get("photo"),
    }

    if user_controller.get(user["id"]):
        return jsonify(user_controller.auth(user["id"]))
    else:
        return jsonify(
            user_controller.register(
                user["id"], user["name"], user["email"], user["photo"]
            )
        )


@app.route("/questions", methods=["POST"])
def get_questions_by_category():
    ids = request.json.get("categories")
    limit = request.json.get("limit", 15)

    # TODO: implement error treating
    if ids is None:
        return "Tá de sacanagem menor"

    questions = question_controller.get_questions_by_category(ids, limit)

    return jsonify(questions)


@app.route("/questions/<id>")
def get_question_by_id(id):
    response = question_controller.get_question_by_id(id)

    return jsonify(response)


@app.route("/games")
def get_games_by_user_id():
    response = game_controller.get_games_by_user_id(request.json.get("user_id"))

    return jsonify(response)


@app.route("/games/register", methods=["POST"])
def register_game():
    response = game_controller.register(
        request.json.get("user_id"),
        request.json.get("start"),
        request.json.get("end"),
        request.json.get("points"),
        request.json.get("categories")
    )

    if response["error"] == True:
        return response, response["code"]

    return jsonify(sucess=True)


@app.route("/categories")
def get_categories():
    categories = category_controller.get_categories()

    return jsonify(categories)


if __name__ == "__main__":
    app.run(host="0.0.0.0")
