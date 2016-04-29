package data;

import java.util.List;

import entities.Answer;
import entities.Question;
import entities.User;

public interface FrockOverflowDao {
	Question getQuestion(int id);

	List <Question> createQuestion(Question q);

	Answer postAnswer(Answer a);

	User createUser(User u);

	User getUser(String email, String password); 

}
