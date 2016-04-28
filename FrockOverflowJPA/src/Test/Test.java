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
		User u =  new User();
		u.setFirstName("Brenton");
		u.setLastName("Gumucio");
		u.setEmail("brenton.gumucio@gmail.com");
		u.setDisplayName("BGGumucio");
		u.setDateCreated(new Date());
		u.setType(1);
		em.persist(u);
		em.getTransaction().commit();
		em.close();
		emf.close();
	}

}
