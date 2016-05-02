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
public class Tag {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String body;
	@ManyToMany
	@JoinTable(name="tag_assignment",
			joinColumns = @JoinColumn(name="tag_id"),
			inverseJoinColumns = @JoinColumn(
					name= "question_id"))
	private List<Question> questions;
	
	
	
	
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public int getId() {
		return id;
	}
	
	
}
