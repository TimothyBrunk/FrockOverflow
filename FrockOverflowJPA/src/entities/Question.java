package entities;

public class Question {
	private int id;
	private int user_id;
	private String body;
	private String timestamp;
	
	public Question(){}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
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
		return "Question= " + id + ", user_id=" + user_id + ", body=" + body + ", timestamp=" + timestamp;
	}
	
	

}
