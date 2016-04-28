package Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import entities.User;

public class TestOverflowDB {
	private EntityManagerFactory emf;
	private EntityManager em;
	
	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("frockoverflowdb");
		em = emf.createEntityManager();
	}

	@Test
	public void testUser() {
		User u = em.find(User.class, 1001);
		assertEquals("Sarah", u.getFirstName());
		assertEquals(1, u.getQuestions().size());
	}
	
	@After
	public void tearDown() throws Exception {
		
	}

}
