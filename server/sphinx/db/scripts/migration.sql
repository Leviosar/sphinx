CREATE TABLE IF NOT EXISTS public.categories (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    icon VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS public.questions (
    id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS public.options (
    id SERIAL PRIMARY KEY NOT NULL,
    question_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    correct BOOLEAN NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

CREATE TABLE IF NOT EXISTS public.users (
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email VARCHAR(255) NOT NULL,
    photo TEXT NOT NULL,
    token TEXT,
    expiration TIMESTAMP
);

CREATE TABLE IF NOT EXISTS public.games (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    started_at TIMESTAMP NOT NULL,
    ended_at TIMESTAMP,
    points INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS public.game_categories (
    game_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY(game_id) REFERENCES games(id),
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS public.challenges (
    started_at TIMESTAMP NOT NULL,
    challenger_user_id VARCHAR(255) NOT NULL,
    challenged_user_id VARCHAR(255) NOT NULL,
    challenger_game_id INTEGER,
    challenged_game_id INTEGER,
    FOREIGN KEY(challenger_user_id) REFERENCES users(id),
    FOREIGN KEY(challenged_user_id) REFERENCES users(id),
    FOREIGN KEY(challenger_game_id) REFERENCES games(id),
    FOREIGN KEY(challenged_game_id) REFERENCES games(id),
    PRIMARY KEY (started_at, challenger_user_id, challenged_user_id)
);
