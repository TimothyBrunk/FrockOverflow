package data;

import java.util.List;

import entities.Answer;
import entities.Question;
import entities.Tag;
import entities.User;

public interface FrockOverflowDao {
	Question getQuestion(int id);

	List <Question> createQuestion(Question q, User u);
	
	List<Question> getAllQuestions();
	
	List<Question> getAllPostedQuestions();
	
	List<Question> getAllAnsweredQuestions();
	
	List<Question> getAllResolvedQuestions();
	
	List<Question> getQuestionsByUser(User u);

	Question postAnswer(Answer a, User user, int q);
	
	Question acceptAnswer(int id);
	
	List<Answer> getAnswersByQuestionId(int questionId);

	User createUser(User u);

	User getUser(String email, String password);

	List<Tag> getTags();

	List<Question> getQuestionByTag(String tag);
	
	Question getMostRecentQuestion(); 
	
//	Answer voteUp (int rating); 
	
//	Answer voteDown (int rating); 
 

}
