import json
import sqlite3
import os

from sphinx.models import CategoryModel, QuestionModel


def translate_categories(categories):
    translated = {}

    for category in categories:
        translated[category[1]] = category[0]

    return translated


fromJsonToDB = {
    "animals": "Animals",
    "brain-teasers": "Brain Teasers",
    "celebrities": "Celebrities",
    "entertainment": "Entertainment",
    "for-kids": "For Kids",
    "general": "General",
    "geography": "Geography",
    "history": "History",
    "hobbies": "Hobbies",
    "humanities": "Humanities",
    "literature": "Literature",
    "movies": "Movies",
    "music": "Music",
    "newest": "Newest",
    "people": "People",
    "rated": "Rated",
    "religion-faith": "Religion",
    "science-technology": "Science Technology",
    "sports": "Sports",
    "television": "Television",
    "video-games": "Video Games",
    "world": "World",
}


def populate_questions_options(db):
    categories = [
        [category.id, category.title] for category in CategoryModel.query.all()
    ]
    categoryId = translate_categories(categories)

    question_inserts = "INSERT INTO questions (id, category_id, text) VALUES "
    option_inserts = "INSERT INTO options (question_id, text, correct) VALUES "

    for root, dirs, files in os.walk("./db/quizes/"):
        questionId = 1
        for filename in files:
            with open(root + filename, encoding="utf8") as json_file:
                j = json.load(json_file)

                for question in j:
                    dbCategoryId = categoryId[fromJsonToDB[question["category"]]]
                    options = question["choices"]

                    s = f"({questionId}, {dbCategoryId}, '{question['question']}'), "
                    question_inserts += s

                    for option in options:
                        correct = question["answer"] == option

                        s = f"({questionId}, '{option}', {correct}), "
                        option_inserts += s

                    questionId += 1

    with open("./question_inserts.sql", "w", encoding="utf8") as fp:
        fp.write(question_inserts)

    with open("./option_inserts.sql", "w", encoding="utf8") as fp:
        fp.write(option_inserts)

    db.session.commit()
