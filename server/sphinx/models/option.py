from . import db
from dataclasses import dataclass


@dataclass
class OptionModel(db.Model):
    __tablename__ = "options"

    id: int = db.Column(db.Integer, primary_key=True)
    question_id: int = db.Column(db.Integer, db.ForeignKey("questions.id"))
    text: str = db.Column(db.String)
    correct: bool = db.Column(db.Boolean)

    def __repr__(self):
        return f"<Option {self.id}>"
