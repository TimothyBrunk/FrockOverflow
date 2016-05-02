package data;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import entities.Answer;
import entities.AnswerStatus;
import entities.Question;
import entities.QuestionStatus;
import entities.Tag;
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
	public List<Question> getQuestionByTag(String tag) {
		List<Question> returnedQuestions = new ArrayList<>();
		List<Tag> usedTags = new ArrayList<>();
		List<Tag> taglist = em.createQuery("SELECT t from Tag t", Tag.class).getResultList();
		for (Tag tag2 : taglist) {
			if (tag.equals(tag2.getBody())){
				usedTags.add(tag2);
			}
		}
		for (Tag tag3 : usedTags) {
			returnedQuestions.add(em.createQuery("SELECT q from Question q join q.tags t where t.id = " + tag3.getId(), Question.class).getSingleResult());
		}
		for (Question tag4 : returnedQuestions) {
			System.out.println(tag4);
		}
		
		return returnedQuestions;
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
		Date date = new Date();
		q.setTimestamp(new Timestamp(date.getTime()));
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
		Date date = new Date();
		a.setTimestamp(new Timestamp(date.getTime()));
		a.setQuestion(question);
		a.setStatus(AnswerStatus.Posted);
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
		q.setStatus(QuestionStatus.Resolved);
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
	public List<Tag> getTags() {
		List<Tag> tags = em.createQuery("SELECT t from Tag t", Tag.class)
				.getResultList();
		return tags;
	}

	@Override
	public User createUser(User u) {
		List<User> returnusers = em.createQuery("SELECT u from User u WHERE email='" + u.getEmail() + "'", User.class).getResultList();
		if (returnusers.size()==0) {
			Date date = new Date();
			u.setDateCreated(new Timestamp(date.getTime()));
			u.setType(1);
			System.out.println(u);
			em.persist(u);
			return u;
		} else {
			User guest = em.find(User.class, 1000);
			return guest;
		}
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
