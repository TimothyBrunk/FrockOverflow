package entities;

public class User {
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String type;
	private String displayName;
	private String dateCreated;
	private String password;
	private String securityQuestion;
	private String securityAnswer;
	
	public User(){}

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSecurityQuestion() {
		return securityQuestion;
	}

	public void setSecurityQuestion(String securityQuestion) {
		this.securityQuestion = securityQuestion;
	}

	public String getSecurityAnswer() {
		return securityAnswer;
	}

	public void setSecurityAnswer(String securityAnswer) {
		this.securityAnswer = securityAnswer;
	}

	public int getId() {
		return id;
	}

	@Override
	public String toString() {
		return "User= " + id + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", type="
				+ type + ", displayName=" + displayName + ", dateCreated=" + dateCreated + ", password=" + password
				+ ", securityQuestion=" + securityQuestion + ", securityAnswer=" + securityAnswer;
	}
	
	

}
