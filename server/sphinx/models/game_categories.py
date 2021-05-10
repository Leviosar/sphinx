from . import db
from dataclasses import dataclass


@dataclass
class GameCategoriesModel(db.Model):
    __tablename__ = "game_categories"
    __table_args__ = {'extend_existing': True}

    game_id: int = db.Column(db.Integer, db.ForeignKey("games.id"), primary_key=True)
    category_id: str = db.Column(db.String, db.ForeignKey("categories.id"))

    @classmethod
    def create(cls, **kwargs):
        db.session.add(cls(**kwargs))
        db.session.commit()
        return cls(**kwargs)

    def update(self):
        db.session.commit()

    def __repr__(self):
        return f"<GameCategories {self.title}>"
