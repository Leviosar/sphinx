from . import db
from datetime import datetime
from dataclasses import dataclass


@dataclass
class GameModel(db.Model):
    __tablename__ = "games"

    id: int = db.Column(db.Integer, primary_key=True)
    title: str = db.Column(db.String)
    icon: str = db.Column(db.String)
    user_id: str = db.Column(db.String, db.ForeignKey("user.id"))
    started_at: datetime = db.Column(db.DateTime)
    ended_at: datetime = db.Column(db.DateTime)
    points: int = db.Column(db.Integer)

    @classmethod
    def create(cls, **kwargs):
        db.session.add(cls(**kwargs))
        db.session.commit()
        return cls(**kwargs)

    def update(self):
        db.session.commit()

    def __repr__(self):
        return f"<Game {self.title}>"
