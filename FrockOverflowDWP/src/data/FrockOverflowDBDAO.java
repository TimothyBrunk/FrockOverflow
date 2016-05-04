package data;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import entities.AComment;
import entities.Answer;
import entities.AnswerStatus;
import entities.QComment;
import entities.Question;
import entities.QuestionStatus;
import entities.Tag;
import entities.TagAssignment;
import entities.User;
import entities.Vote;
import entities.VoteAssignment;

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
//		List<Question> returnedQuestions = new ArrayList<>();
		Tag matchTag = em
				.createQuery("SELECT t from Tag t join fetch t.questions WHERE t.body = '" + tag + "' order by timestamp desc", Tag.class)
				.getSingleResult();
		return matchTag.getQuestions();
	}

	@Override
	public List<Question> getAllQuestions() {
		int pageNumber = 1;
		int pageSize = 10;
		List<Question> ql = em.createQuery("Select q from Question q order by timestamp desc", Question.class)
				.setFirstResult((pageNumber-1) * pageSize).setMaxResults(pageSize).getResultList();
		return ql;
	}

	@Override
	public List<Question> getAllPostedQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q WHERE status='Posted' order by timestamp desc", Question.class)
				.setMaxResults(20).getResultList();
		return ql;
	}

	@Override
	public List<Question> getAllAnsweredQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q WHERE status='Answered' order by timestamp desc", Question.class)
				.setMaxResults(20).getResultList();
		return ql;
	}

	@Override
	public List<Question> getAllResolvedQuestions() {
		List<Question> ql = em.createQuery("Select q from Question q WHERE status='Resolved' order by timestamp desc", Question.class)
				.setMaxResults(20).getResultList();
		return ql;
	}

	@Override
	public List<Question> getQuestionsByUser(User u) {
		List<Question> ql = em.createQuery("Select q from Question q WHERE user.id = " + u.getId(), Question.class)
				.setMaxResults(20).getResultList();
		return ql;
	}

	@Override
	public List<Question> createQuestion(Question q, User u, String keywords) {
		Date date = new Date();
		q.setTimestamp(new Timestamp(date.getTime()));
		q.setUser(u);
		q.setStatus(QuestionStatus.Posted);
		em.persist(q);
		String[] tokens = keywords.split(" ");
		List<Tag> usedTags = getTags();
		if (!tokens[0].equals("")) {
		for (String t : tokens) {
			Tag tag = new Tag();
			tag.setBody(t.trim());
			boolean match = false;
			int tagId = 0;
			for (Tag t2 : usedTags) {
				if (t2.getBody().equalsIgnoreCase(t.trim())) {
					match = true;
					tagId = t2.getId();
					System.out.println(t2.getBody() + " " + t);
					break;
				}
			}
			TagAssignment ta = new TagAssignment();
			ta.setQuestion(q);
			if (!match) {
				em.persist(tag);
			} else {
				tag = em.find(Tag.class, tagId);
			}
			ta.setTag(tag);
			em.persist(ta);
		}
		} // End of if
		List<Question> ql = em.createQuery("Select q from Question q WHERE id="+ q.getId(), Question.class).getResultList();
		return ql;
	}
	
	@Override
	public void removeQuestion(@RequestParam("id") int id) {
		Question questionToRemove = em.find(Question.class, id);
		for (TagAssignment t : questionToRemove.getTagAssignments()) {
			em.remove(t);
		}
		for (Answer a : questionToRemove.getAnswers()) {
			em.remove(a);
		}
		for (QComment c : questionToRemove.getComments()) {
			em.remove(c);
		}
		em.remove(questionToRemove);
	}

	@Override
	public List<Question> postAnswer(Answer a, User user, int q) {
		Question question = em.find(Question.class, q);
		a.setUser(user);
		Date date = new Date();
		a.setTimestamp(new Timestamp(date.getTime()));
		a.setQuestion(question);
		a.setStatus(AnswerStatus.Posted);
		question.addAnswer(a);
		em.persist(a);
		List<Question> ql = em.createQuery("Select q from Question q WHERE id="+ q, Question.class).getResultList();
		return ql;
	}
	
	@Override
	public void commentOnAnswer(AComment c, int userId, int answerId) {
		User u = em.find(User.class, userId);
		Answer a = em.find(Answer.class, answerId);
		Date date = new Date();
		c.setTimestamp(new Timestamp(date.getTime()));
		c.setUser(u);
		c.setAnswer(a);
		a.getComments().add(c);
		em.persist(c);
	}
	
	@Override
	public void commentOnQuestion(QComment c, int userId, int questionId){
		User u = em.find(User.class, userId);
		Question q = em.find(Question.class, questionId);
		Date date = new Date();
		c.setTimestamp(new Timestamp(date.getTime()));
		c.setUser(u);
		c.setQuestion(q);
		q.getComments().add(c);
		em.persist(c);
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
	public void removeAnswer(int id) {
		Answer answerToRemove = em.find(Answer.class, id);
		for (VoteAssignment v : answerToRemove.getVoteAssignments()) {
			em.remove(v);
		}
		for (AComment c : answerToRemove.getComments()) {
			em.remove(c);
		}
		em.remove(answerToRemove);
	}

	@Override
	public List<Tag> getTags() {
		List<Tag> tags = em.createQuery("SELECT t from Tag t", Tag.class).getResultList();
		return tags;
	}

	@Override
	public User createUser(User u) {
		List<User> returnusers = em.createQuery("SELECT u from User u WHERE email='" + u.getEmail() + "'", User.class)
				.getResultList();
		if (returnusers.size() == 0) {
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

	@Override
	public User editUser(User u) {
		User guest = em.createQuery("SELECT u from User u WHERE id = 1000", User.class).getSingleResult();
		User update = em.find(User.class, u.getId());
		if (u.getPassword().equals(update.getPassword())) {
			update.setFirstName(u.getFirstName());
			update.setLastName(u.getLastName());
			update.setDisplayName(u.getDisplayName());
			update.setEmail(u.getEmail());
			return update;
		} else {
			return guest;
		}
	}
	
	@Override
	public void removeUser(int id) {
		User userToRemove = em.createQuery("SELECT u from User u join fetch u.questions join fetch u.answers WHERE id ="+ id, User.class).getSingleResult();
		for (Answer a : userToRemove.getAnswers()) {
			removeAnswer(a.getId());
		}
		for (Question q : userToRemove.getQuestions()) {
			removeQuestion(q.getId());
		}
		em.remove(userToRemove);
	}
	
	@Override
	public Question getMostRecentQuestion() {
		Integer mostrecent = (Integer) em.createQuery("Select max(q.id) FROM Question q").getSingleResult();
		Question mostrecentquestion = em.find(Question.class, mostrecent);
		System.out.println(mostrecent);
		System.out.println("In DAO");
		return mostrecentquestion;
	}


	
	@Override
	public void voteUp(int answerId, int userId) {
		Answer a = em.find(Answer.class, answerId);
		User u = em.find(User.class, userId);
		Vote v = em.find(Vote.class, 1);
		List<VoteAssignment> va = em.createQuery("SELECT v from VoteAssignment v WHERE v.answer.id = " + answerId + " AND v.user.id = " + userId, VoteAssignment.class).getResultList();
		if (va.isEmpty()) {
			VoteAssignment voteAssign = new VoteAssignment();
			voteAssign.setAnswer(a);
			voteAssign.setUser(u);
			voteAssign.setVote(v);
			em.persist(voteAssign);
			a.setRating(a.getRating()+v.getValue());
		}
	}
	
	@Override
	public void voteDown(int answerId, int userId) {
		Answer a = em.find(Answer.class, answerId);
		User u = em.find(User.class, userId);
		Vote v = em.find(Vote.class, 2);
		List<VoteAssignment> va = em.createQuery("SELECT v from VoteAssignment v WHERE v.answer.id = " + answerId + " AND v.user.id = " + userId, VoteAssignment.class).getResultList();
		if (va.isEmpty()) {
			VoteAssignment voteAssign = new VoteAssignment();
			voteAssign.setAnswer(a);
			voteAssign.setUser(u);
			voteAssign.setVote(v);
			em.persist(voteAssign);
			a.setRating(a.getRating()+v.getValue());
		}
	}
	@Override
	public User logOut(User u) {
		User guest = em.createQuery("SELECT u from User u WHERE id = 1000", User.class).getSingleResult();
		return guest;
	} 
	@Override
	public List<User> getAllUsers() {
		List<User> users = em.createQuery("Select u from User u ", User.class)
				.getResultList();
		return users;
	}

	// @Override
	// public Answer voteUp(int rating) {
	// Answer a = em.find(Answer.class, rating);
	// a.setRating(rating++);
	// em.persist(rating);
	// return a;
	// }
	// @Override
	// public Answer voteDown(int rating) {
	// Answer a = em.find(Answer.class, rating);
	// a.setRating(rating--);
	// em.persist(rating);
	// return a;
	// }

}
