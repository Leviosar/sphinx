import json
import sqlite3
import os


def translate_categories(categories):
    translated = {}

    for c in categories:
        translated[c[1]] = c[0]

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

categories = []

conn = sqlite3.connect("../esfincter.db")
cursor = conn.cursor()

for c in cursor.execute("SELECT * FROM categories"):
    categories.append(c)

categoryId = translate_categories(categories)
conn.commit()
print(categoryId)


def populate_questions_options():
    for root, dirs, files in os.walk("../quizes/"):
        questionId = 1
        for filename in files:
            with open(root + filename, encoding='utf8') as json_file:
                j = json.load(json_file)

                for question in j:
                    dbCategoryId = categoryId[fromJsonToDB[question["category"]]]
                    options = question["choices"]

                    s = f"INSERT INTO questions (id, category_id, text) VALUES ({questionId}, {dbCategoryId}, '{question['question']}')"

                    cursor.execute(s)

                    for option in options:
                        correct = 1 if question["answer"] == option else 0

                        s = f"INSERT INTO options (question_id, text, correct) VALUES({questionId}, '{option}', {correct})"

                        cursor.execute(s)

                    questionId += 1

    conn.commit()


populate_questions_options()
