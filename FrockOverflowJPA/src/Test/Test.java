package Test;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.User;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("frockoverflowdb");
		EntityManager em = emf.createEntityManager();
		
		String query = "SELECT u FROM User u";
		User u = em.createQuery(query, User.class).getSingleResult();
		System.out.println(u);
		em.close();
		emf.close();
	}

}
