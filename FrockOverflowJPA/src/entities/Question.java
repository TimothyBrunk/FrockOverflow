package entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Question {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String body;
	private Date timestamp;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	@OneToMany(mappedBy="question")
	private List<Answer> answers;
	@Enumerated(EnumType.STRING)
	private QuestionStatus status;
	
	public Question(){
		super();
	}
	public QuestionStatus getStatus() {
		return status;
	}

	public void setStatus(QuestionStatus status) {
		this.status = status;
	}

	
	public List<Answer> getAnswers() {
		return answers;
	}
	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}
	
	public void addAnswer(Answer answer) {
		if (!getAnswers().contains(answer)) {
			getAnswers().add(answer);
			if (answer.getQuestion() != null) {
				answer.getQuestion().getAnswers().remove(answer);
			}
		this.setStatus(QuestionStatus.Answered);
		}
	}
	
	public void removeAnswer(Answer answer) {
		if (getAnswers().contains(answer)) {
			getAnswers().remove(answer);
			answer.setQuestion(null);
		}
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	public int getId() {
		return id;
	}

	@Override
	public String toString() {
		return "Question= " + id + ", body=" + body + ", timestamp=" + timestamp;
	}
	
	

}
