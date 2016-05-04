package data;

import java.util.List;

import entities.AComment;
import entities.Answer;
import entities.QComment;
import entities.Question;
import entities.Tag;
import entities.User;

public interface FrockOverflowDao {
	
	List <Question> createQuestion(Question q, User u, String s);
	
	Question getQuestion(int id);
	
	List<Question> getAllQuestions();
	
	List<Question> getAllPostedQuestions();
	
	List<Question> getAllAnsweredQuestions();
	
	List<Question> getAllResolvedQuestions();
	
	List<Question> getQuestionsByUser(User u);

	List<Question> getQuestionByTag(String tag);
	
	Question getMostRecentQuestion();
	
	void removeQuestion(int id);
	
	Question postAnswer(Answer a, User user, int q);
	
	void commentOnAnswer(AComment c, int userId, int answerId);
	
	void commentOnQuestion(QComment c, int userId, int questionId);

	Question acceptAnswer(int id);

	List<Answer> getAnswersByQuestionId(int questionId);
	
	void removeAnswer(int id);

	User createUser(User u);

	User getUser(String email, String password);
	
	User editUser(User u); 
	
	void removeUser(int id);

	List<Tag> getTags();
	
	void voteUp (int answerId, int userId); 
	
	void voteDown (int answerId, int userId); 
	
	User logOut(User u); 
 

}
