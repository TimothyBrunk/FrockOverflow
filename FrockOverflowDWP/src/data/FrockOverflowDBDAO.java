package data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import entities.Question;

@Transactional
public class FrockOverflowDBDAO implements FrockOverflowDao {
	@PersistenceContext
	private EntityManager em;
	
	public Question getQuestion(int id){
		Question q = em.find(Question.class, id);
		em.detach(q);
		return q;
		
	}



}