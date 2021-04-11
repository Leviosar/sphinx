from . import db
from datetime import datetime
from dataclasses import dataclass


@dataclass
class ChallengeModel(db.Model):
    __tablename__ = "challenges"

    challenger_user_id: str = db.Column(
        db.String, db.ForeignKey("users.id"), primary_key=True
    )
    challenged_user_id: str = db.Column(
        db.String, db.ForeignKey("users.id"), primary_key=True
    )
    challenger_game_id: str = db.Column(db.Integer, db.ForeignKey("games.id"))
    challenged_game_id: str = db.Column(db.Integer, db.ForeignKey("games.id"))
    started_at: datetime = db.Column(db.DateTime, primary_key=True)

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
        return f"<Challenge {self.challenger_user_id}, {self.challenged_user_id}>"
