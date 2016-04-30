package Test;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import entities.Answer;
import entities.Question;
import entities.User;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("frockoverflowdb");
		EntityManager em = emf.createEntityManager();
		
		EntityTransaction et = em.getTransaction();
		et.begin();
		User u = em.createQuery("SELECT u from User u WHERE email = 'sarah.lobser@gmail.com'", User.class).getSingleResult();
		System.out.println(u.getId() + "");
		List<Question> userQuestions = em.createQuery("SELECT q from Question q WHERE user.id = 10", Question.class).getResultList();
		System.out.println(userQuestions.size());
		System.out.println(userQuestions);
//		et.commit();
		
//		em.persist(q);
//		em.getTransaction().commit();
		
		
		em.close();
		emf.close();
	}

}
