from sphinx.models import CategoryModel

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


def populate_categories(db):
    for category in categories:
        insert = CategoryModel(title=category)
        db.session.add(insert)

    db.session.commit()