CREATE TABLE categories (
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    icon TEXT
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY NOT NULL,
    category_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE options (
    id INTEGER PRIMARY KEY NOT NULL,
    question_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    correct INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES question(id)
);
