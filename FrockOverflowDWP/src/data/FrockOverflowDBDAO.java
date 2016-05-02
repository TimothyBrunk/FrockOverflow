package data;

import java.security.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import entities.Answer;
import entities.AnswerStatus;
import entities.Question;
import entities.QuestionStatus;
import entities.User;

@Transactional
public class FrockOverflowDBDAO implements FrockOverflowDao {
	@PersistenceContext
	private EntityManager em;

	@Override
	public Question getQuestion(int id) {
		Question q = em.find(Question.class, id);
		em.detach(q);
		return q;
	}

	@Override
	public List<Question> getAllQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q", Question.class).getResultList();
		return ql;
	}

	@Override
	public List<Question> getAllPostedQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q WHERE status='Posted'", Question.class)
				.getResultList();
		return ql;
	}

	@Override
	public List<Question> getAllAnsweredQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q WHERE status='Answered'", Question.class)
				.getResultList();
		return ql;
	}

	@Override
	public List<Question> getAllResolvedQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q WHERE status='Resolved'", Question.class)
				.getResultList();
		return ql;
	}

	@Override
	public List<Question> getQuestionsByUser(User u) {
		List<Question> ql = em.createQuery("Select q from Question q WHERE user.id = " + u.getId(), Question.class)
				.getResultList();
		return ql;
	}

	@Override
	public List<Question> createQuestion(Question q, User u) {
		q.setTimestamp(new Date());
		q.setUser(u);
		q.setStatus(QuestionStatus.Posted);
		em.persist(q);
		List<Question> ql = em.createQuery("Select q from Question q", Question.class).getResultList();
		return ql;
	}

	@Override
	public Question postAnswer(Answer a, User user, int q) {
		Question question = em.find(Question.class, q);
		a.setUser(user);
		a.setTimestamp(new Date());
		a.setQuestion(question);
		question.addAnswer(a);
		em.persist(a);
		System.out.println(a.getUser().getId());
		return question;
	}

	@Override
	public Question acceptAnswer(int id) {
		Answer a = em.find(Answer.class, id);
		a.setStatus(AnswerStatus.Accepted);
		Question q = em.createQuery("SELECT q from Question q WHERE id = " + a.getQuestion().getId(), Question.class)
				.getSingleResult();
		return q;
	}

	@Override
	public List<Answer> getAnswersByQuestionId(int questionId) {
		List<Answer> answers = em.createQuery("SELECT a from Answer a WHERE question.id = " + questionId, Answer.class)
				.getResultList();
		System.out.println(answers.size());
		return answers;
	}

	@Override
	public User createUser(User u) {
		u.setDateCreated(new Date());
		System.out.println(u.getFirstName());
		em.persist(u);
		return u;
	}

	@Override
	public User getUser(String email, String password) {
		User guest = em.createQuery("SELECT u from User u WHERE id = 1000", User.class).getSingleResult();
		try {
			User u = em.createQuery("SELECT u from User u WHERE email = '" + email + "'", User.class).getSingleResult();
			if (u.getPassword().equals(password)) {
				List<Question> userQuestions = em
						.createQuery("SELECT q from Question q WHERE user.id = " + u.getId(), Question.class)
						.getResultList();
				u.setQuestions(userQuestions);
				return u;
			} else {
				return guest;
			}
		} catch (javax.persistence.NoResultException e) {
			System.out.println("No user found. Logging in as guest.");
			return guest;
		}
	}

	
//	@Override
//	public Answer voteUp(int rating) {
//		Answer a = em.find(Answer.class, rating); 
//		a.setRating(rating++); 
//		em.persist(rating);
//		return a;
//	}
//	@Override
//	public Answer voteDown(int rating) {
//		Answer a = em.find(Answer.class, rating); 
//		a.setRating(rating--); 
//		em.persist(rating);
//		return a;
//	}


}
