package Test;

import java.util.Date;

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
		User u = em.find(User.class, 1003);
		
		Question q = new Question();
		String sb = "Where does snow come from, and why can't I make it using this script?";
		q.setBody(sb);
		q.setTimestamp(new Date());
		System.out.println(u);
		q.setUser(u);
		
		em.persist(q);
		
		
//		Question q = em.find(Question.class, 4);
		System.out.println(q.getUser());
		
		Answer a = new Answer();
		a.setBody("Take a nap");
		a.setUser(u);
		a.setQuestion(q);
		
		em.persist(a);
		
		em.remove(q);
		et.commit();
		
//		em.persist(q);
//		em.getTransaction().commit();
		
		
		em.close();
		emf.close();
	}

}
