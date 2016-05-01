package entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

@Entity
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private int type;
	@Column(name="display_name")
	private String displayName;
	@Column(name="date_created")
	private Date dateCreated;
	private String password;
	
	@OneToMany(mappedBy="user")
	private List<Question> questions;
	
	@OneToMany(mappedBy="user")
	private List<Answer> answers;
	
	public User(){
		super();
	}
	
	public List<Answer> getAnswers() {
		return answers;
	}

	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}

	public List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}


	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date l) {
		this.dateCreated = l;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public int getId() {
		return id;
	}

	@Override
	public String toString() {
		return "User= " + id + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", type="
				+ type + ", displayName=" + displayName + ", dateCreated=" + dateCreated + ", password=" + password;
	}
	
	

}
