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
import entities.Answer;
import entities.Question;

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
		assertEquals(1, u.getAnswers().size());
	}
	
	@Test
	public void testQuestion() {
		Question q = em.find(Question.class, 1);
		assertEquals(1001, q.getUser().getId());
		assertEquals(1, q.getAnswers().size());
	}
	
	@Test
	public void testAnswer() {
		Answer a = em.find(Answer.class, 1);
		assertEquals(1002, a.getUser().getId());
		assertEquals("Try turning the machine \"on\"", a.getBody());
	}

	@After
	public void tearDown() throws Exception {
		
	}

}
