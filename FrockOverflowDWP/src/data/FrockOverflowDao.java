package data;

import java.util.List;

import entities.AComment;
import entities.Answer;
import entities.QComment;
import entities.Question;
import entities.Tag;
import entities.User;

public interface FrockOverflowDao {
	
	void createQuestion(Question q, User u, String s);
	
	Question getQuestion(int id);
	
	List<Question> getAllQuestions();
	
	List<Question> getAllPostedQuestions();
	
	List<Question> getAllAnsweredQuestions();
	
	List<Question> getAllResolvedQuestions();
	
	List<Question> getQuestionsByUser(User u);

	List<Question> getQuestionByTag(String tag);
	
	Question getMostRecentQuestion();
	
	void removeQuestion(int id);
	
	void postAnswer(Answer a, User user, int q);
	
	Question commentOnAnswer(AComment c, int userId, int answerId);
	
	Question commentOnQuestion(QComment c, int userId, int questionId);

	Question acceptAnswer(int id);

	List<Answer> getAnswersByQuestionId(int questionId);
	
	Question removeAnswer(int id);

	User createUser(User u);

	User getUser(String email, String password);
	
	User editUser(User u); 
	
	void removeUser(int id);

	List<Tag> getTags();
	
	Question voteUp (int answerId, int userId); 
	
	Question voteDown (int answerId, int userId); 
	
	User logOut(User u); 
	
	List <User> getAllUsers(); 
	
	void deactivateUser (int userId, int userType); 
	
	void activateUser (int userId, int userType); 
 

}
