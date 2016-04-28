package Test;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.Question;
import entities.User;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("frockoverflowdb");
		EntityManager em = emf.createEntityManager();
		
		em.getTransaction().begin();
		User u = em.find(User.class, 1002);
		Question a = new Question();
		String sb = "What is the default value of float and double datatype in Java?";
		a.setBody(sb);
		a.setTimestamp(new Date());
		System.out.println(u);
		a.setUser(u);
		em.persist(a);
		em.getTransaction().commit();
		
		
		em.close();
		emf.close();
	}

}
