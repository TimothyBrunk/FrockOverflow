package entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Vote {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private int value;
	@ManyToMany
	@JoinTable(name="vote_assignment",
			joinColumns = @JoinColumn(name="vote_id"),
			inverseJoinColumns = @JoinColumn(
					name= "answer_id"))
	private List<Question> answers;
	
	@ManyToMany
	@JoinTable(name="vote_assignment",
	joinColumns = @JoinColumn(name="vote_id"),
	inverseJoinColumns = @JoinColumn(
			name= "user_id"))
	private List<User> users;
	
	public Vote() {
		super();
	}

	public int getId() {
		return id;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public List<Question> getAnswers() {
		return answers;
	}

	public void setAnswers(List<Question> answers) {
		this.answers = answers;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

}
