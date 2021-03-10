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

CREATE TABLE users (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    photo TEXT NOT NULL
);

CREATE TABLE game (
    id INTEGER PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL,
    start TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    points INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE game_categories (
    game_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY(game_id) REFERENCES game(id),
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE challenges (
    start TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    challenger_user_id INTEGER NOT NULL,
    challenged_user_id INTEGER NOT NULL,
    challenger_game_id INTEGER NOT NULL,
    challenged_game_id INTEGER NOT NULL,
    FOREIGN KEY(challenger_user_id) REFERENCES game(user_id),
    FOREIGN KEY(challenged_user_id) REFERENCES game(user_id),
    FOREIGN KEY(challenger_game_id) REFERENCES game(id),
    FOREIGN KEY(challenged_game_id) REFERENCES game(id),
    PRIMARY KEY (start, challenger_user_id, challenged_user_id)
);