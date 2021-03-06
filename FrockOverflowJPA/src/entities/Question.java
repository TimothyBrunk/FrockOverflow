package entities;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;

@Entity
public class Question {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String body;
	private Timestamp timestamp;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	@OneToMany(mappedBy="question", fetch=FetchType.EAGER)
	@OrderBy("timestamp DESC")
	private List<Answer> answers;
	@Enumerated(EnumType.STRING)
	private QuestionStatus status;
	@ManyToMany(mappedBy="questions", fetch=FetchType.EAGER)
	private List<Tag> tags;
	@OneToMany(mappedBy="question")
	private List<TagAssignment> tagAssignments;
	@OneToMany(mappedBy="question", fetch=FetchType.EAGER)
	@OrderBy("timestamp DESC")
	private List<QComment> comments;
	
	public Question(){
		super();
	}
	
	public List<QComment> getComments() {
		return comments;
	}

	public void setComments(List<QComment> comments) {
		this.comments = comments;
	}

	public List<Tag> getTags() {
		return tags;
	}

	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
	
	public void addTag(Tag tag) {
		System.out.println("In add tag method");
		this.tags.add(tag);
		System.out.println("Added tag?");
	}

	public List<TagAssignment> getTagAssignments() {
		return tagAssignments;
	}

	public void setTagAssignments(List<TagAssignment> tagAssignments) {
		this.tagAssignments = tagAssignments;
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

	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp l) {
		this.timestamp = l;
	}

	public int getId() {
		return id;
	}

	@Override
	public String toString() {
		return "Question= " + id + ", body=" + body + ", timestamp=" + timestamp + ", first tag=" + getTags();
	}
	
	

}
