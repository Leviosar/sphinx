import sqlite3 as db

categories = [
    "Animals",
    "Brain Teasers",
    "Celebrities",
    "Entertainment",
    "For Kids",
    "General",
    "Geography",
    "History",
    "Hobbies",
    "Humanities",
    "Literature",
    "Movies",
    "Music",
    "Newest",
    "People",
    "Rated",
    "Religion",
    "Science Technology",
    "Sports",
    "Television",
    "Video Games",
    "World",
]


def populate_categories():
    conn = db.connect("../esfincter.db")
    cursor = conn.cursor()
    for c in categories:
        cursor.execute("INSERT INTO categories (title) VALUES ('%s')" % c)

    conn.commit()


populate_categories()
