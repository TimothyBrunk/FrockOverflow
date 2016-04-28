package entities;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity

public class Answer {
	@Id
	private int id;
	private int userId;
	private String body;
	private String timestamp;

	
	public Answer(){}


	public int getUserId() {
		return userId;
	}


	public void setUser_id(int userId) {
		this.userId = userId;
	}


	public String getBody() {
		return body;
	}


	public void setBody(String body) {
		this.body = body;
	}


	public String getTimestamp() {
		return timestamp;
	}


	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}


	public int getId() {
		return id;
	}


	@Override
	public String toString() {
		return "Answer= " + id + ", user_id=" + userId + ", body=" + body + ", timestamp=" + timestamp + "]";
	}
	
	
}
