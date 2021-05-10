from . import db
from datetime import datetime
from dataclasses import dataclass
from typing import List

GameCategories = db.Table(
    'game_categories', 
    db.Model.metadata,
    db.Column('game_id', db.Integer, db.ForeignKey("games.id"), primary_key=True),
    db.Column('category_id', db.Integer, db.ForeignKey("categories.id"))
)

@dataclass
class GameModel(db.Model):
    __tablename__ = "games"

    id: int = db.Column(db.Integer, primary_key=True)
    user_id: str = db.Column(db.String, db.ForeignKey("users.id"))
    started_at: datetime = db.Column(db.DateTime)
    ended_at: datetime = db.Column(db.DateTime)
    points: int = db.Column(db.Integer)
    categories: List = db.relationship("CategoryModel", secondary=GameCategories, backref="game")

    @classmethod
    def create(cls, **kwargs):
        game = cls(**kwargs)
        db.session.add(game)
        db.session.commit()
        db.session.refresh(game)
        return game

    def update(self):
        db.session.commit()

    def __repr__(self):
        return f"<Game {self.id}>"
