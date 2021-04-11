from . import db
from datetime import datetime
from dataclasses import dataclass


@dataclass
class GameModel(db.Model):
    __tablename__ = "games"

    id: int = db.Column(db.Integer, primary_key=True)
    user_id: str = db.Column(db.String, db.ForeignKey("users.id"))
    started_at: datetime = db.Column(db.DateTime)
    ended_at: datetime = db.Column(db.DateTime)
    points: int = db.Column(db.Integer)

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
