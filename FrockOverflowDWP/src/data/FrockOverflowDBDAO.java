package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import entities.Answer;
import entities.Question;
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
	public List<Question> createQuestion(Question q){
		em.persist(q);
		List<Question> ql = em.createQuery("Select q from Question q", Question.class).getResultList();
		
		return ql;	
	}
	
	@Override
	public Answer postAnswer(Answer a){
		em.persist(a);
		return a;
	}
	@Override
	public User createUser(User u){
		return u;
	}
	@Override
	public User getUser(String email, String password){
		User u = em.createQuery("SELECT u from User u WHERE email = " + email, User.class).getSingleResult();
		User guest = em.createQuery("SELECT u from User WHERE id = 1000", User.class).getSingleResult();
		if(u.getPassword().equals(password)){
			return u;
		}
		else{
			return guest;
		}
	}


}
