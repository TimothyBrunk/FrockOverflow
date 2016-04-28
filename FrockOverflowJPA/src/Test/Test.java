package Test;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.User;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("frockoverflowdb");
		EntityManager em = emf.createEntityManager();
		
		em.getTransaction().begin();
		User u =  em.find(User.class, 1003);
		u.setPassword("brenton");
		em.getTransaction().commit();
		
		
		em.close();
		emf.close();
	}

}
