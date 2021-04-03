from . import db
from dataclasses import dataclass
from typing import List


@dataclass
class QuestionModel(db.Model):
    __tablename__ = "questions"

    id: int = db.Column(db.Integer, primary_key=True)
    category_id: int = db.Column(db.Integer, db.ForeignKey("categories.id"))
    text: str = db.Column(db.String)
    options: List = db.relationship("OptionModel", backref="question", lazy=True)

    def __repr__(self):
        return f"<Question {self.id}>"
