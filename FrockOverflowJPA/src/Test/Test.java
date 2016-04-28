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
		User u = em.find(User.class, 1003);
		Question a = new Question();
		String sb = "1.  int []a = {1,2,3,4,5,6}; \n2.  int i = a.length - 1; \n3.\n4.  while(i>=0){\n5.  System.out.print(a[i]);\n6.  i--;\n7. } \n WHAT IS THE RESULT?";
		a.setBody(sb);
		a.setTimestamp(new Date());
		a.setUser(u);
		em.persist(a);
		em.getTransaction().commit();
		
		
		em.close();
		emf.close();
	}

}
