import pandas as pd
import os

class Feedback:
    def __init__(self, chapter, line, feedback):
        self.chapter = chapter
        self.line = line
        self.feedback = feedback
    def to_dict(self):
        return {
            'chapter':self.chapter,
            'line':self.line ,
            'feedback':self.feedback
        }
class FeedbackDatabase:
    def __init__(self):
        try:
            self.db = pd.read_csv('feedback.csv')
        except:
            self.db = pd.DataFrame(columns=['chapter', 'line', 'feedback'])

    def add_obj(self, feedback):
        self.db = self.db.append(feedback.to_dict())
        self.save()
        
    def get_range(self, start, amt):
        return self.db.iloc[start:amt]

    def save(self):
        self.db.to_csv('feedback.csv')
