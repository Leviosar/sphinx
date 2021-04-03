from . import db
from dataclasses import dataclass


@dataclass
class CategoryModel(db.Model):
    __tablename__ = "categories"

    id: int = db.Column(db.Integer, primary_key=True)
    title: str = db.Column(db.String())
    icon: str = db.Column(db.String())

    def __repr__(self):
        return f"<Category {self.title}>"
