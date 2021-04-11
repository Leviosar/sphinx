from . import db
from dataclasses import dataclass
from typing import List
from datetime import datetime


@dataclass
class UserModel(db.Model):
    __tablename__ = "users"

    id: int = db.Column(db.Integer, primary_key=True)
    name: str = db.Column(db.String)
    email: str = db.Column(db.String)
    token: str = db.Column(db.String)
    photo: str = db.Column(db.String)
    expiration: datetime = db.Column(db.DateTime)
    games: List = db.relationship("GameModel", backref="user")

    @classmethod
    def create(cls, **kwargs):
        db.session.add(cls(**kwargs))
        db.session.commit()
        return cls(**kwargs)

    def update(self):
        db.session.commit()

    def __repr__(self):
        return f"<User {self.name}>"
