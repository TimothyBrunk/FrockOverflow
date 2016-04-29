package data;

import java.util.List;

import entities.Answer;
import entities.Question;

public interface FrockOverflowDao {
	public Question getQuestion(int id);

	public List <Question> createQuestion(Question q);

	public Answer postAnswer(Answer a); 

}
