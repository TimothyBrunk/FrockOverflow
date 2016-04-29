package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import entities.Answer;
import entities.Question;

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
	


}
