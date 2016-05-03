package entities;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Answer {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String body;
	private Timestamp timestamp;
	private int rating;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	@ManyToOne
	@JoinColumn(name="question_id")
	private Question question;
	@Enumerated(EnumType.STRING)
	@Column(name="answer_status")
	private AnswerStatus status;
	@ManyToMany(mappedBy="answers")
	private List<Vote> votes;
	@OneToMany(mappedBy="answer")
	private List<VoteAssignment> voteAssignments;
	
	public Answer(){
		super();
	}

	public List<VoteAssignment> getVoteAssignments() {
		return voteAssignments;
	}

	public void setVoteAssignments(List<VoteAssignment> voteAssignments) {
		this.voteAssignments = voteAssignments;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public List<Vote> getVotes() {
		return votes;
	}

	public void setVotes(List<Vote> votes) {
		this.votes = votes;
	}


	public AnswerStatus getStatus() {
		return status;
	}

	public void setStatus(AnswerStatus status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	public Question getQuestion() {
		return question;
	}
	
	public void setQuestion(Question question) {
		this.question = question;
	}
	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}
	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public int getId() {
		return id;
	}

	@Override
	public String toString() {
		return "Answer= " + id + ", body=" + body + ", timestamp=" + timestamp + "]";
	}
	
	
}
