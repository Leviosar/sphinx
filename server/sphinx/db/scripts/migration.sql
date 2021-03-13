CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    icon TEXT
);

CREATE TABLE IF NOT EXISTS questions (
    id INTEGER PRIMARY KEY NOT NULL,
    category_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS options (
    id INTEGER PRIMARY KEY NOT NULL,
    question_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    correct INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES question(id)
);

CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    photo TEXT NOT NULL,
    token TEXT,
    expiration TIMESTAMP
);

CREATE TABLE IF NOT EXISTS game (
    id INTEGER PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL,
    start TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    points INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS game_categories (
    game_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY(game_id) REFERENCES game(id),
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS challenges (
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