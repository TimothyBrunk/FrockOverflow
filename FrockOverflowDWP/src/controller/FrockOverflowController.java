package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import data.DBUtilities;
import data.FrockOverflowDao;
import entities.AComment;
import entities.Answer;
import entities.QComment;
import entities.Question;
import entities.Tag;
import entities.User;

@Controller
@SessionAttributes({"user", "tags"})
public class FrockOverflowController {
	@Autowired
	private FrockOverflowDao frockoverflowdao;
	
	//initializes a guest user upon navigating to the site
	@ModelAttribute("user")
	public User initUser() {
		return frockoverflowdao.getUser("anything", "anything"); 
	}
	
	//Grabs all the tags/keywords in the database
	@ModelAttribute("tags")
	public List<Tag> initTags(){
		List <Tag> tags = frockoverflowdao.getTags();
		return tags;
	}
	
	//This is our main search by questions method. It is called by all of the "View"
	//questions in the nav bar
	@RequestMapping("search.do")
	public ModelAndView searchQuestions(@ModelAttribute("user") User login, @RequestParam("submit") String searchBy) {
		List<Question> qList = new ArrayList<>();
		switch(searchBy) {
		case "View All Questions":
			qList = frockoverflowdao.getAllQuestions();
			break;
		case "View All Posted Questions":
			qList = frockoverflowdao.getAllPostedQuestions();
			break;
		case "View All Answered Questions":
			qList = frockoverflowdao.getAllAnsweredQuestions();
			break;
		case "View All Resolved Questions":
			qList = frockoverflowdao.getAllResolvedQuestions();
			break;
		case "View All My Questions":
			qList = frockoverflowdao.getQuestionsByUser(login);
			break;	
		}
		ModelAndView mv = new ModelAndView("results.jsp", "updatedQuestionList", qList);
		if (qList.size() == 0) mv.addObject("message", "No Questions Found");
		return mv;
		
	}
	//This method initializes the website and loads questions
	@RequestMapping("index.do")
	public ModelAndView initialLoad() {
		Question mostrecent = frockoverflowdao.getMostRecentQuestion();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp");
		mv.addObject("question", mostrecent); 
		return mv;
	}

	//This method searches the database for questions related to multiple searched tags
	@RequestMapping("searchByTag.do")
	public ModelAndView getQuestionsByTag(@RequestParam("searchTags") String tagString) {
		String[] tagarr = tagString.split(" ");
		List<Question> qList = frockoverflowdao.getQuestionByTag(tagarr[0]);
		ModelAndView mv = new ModelAndView("results.jsp", "updatedQuestionList", qList);
		if (qList.size() == 0) mv.addObject("message", "No Questions Found");
		return mv;
	}
	
	//This method searches the database for questions related to a searched tag
	@RequestMapping("searchBySingleTag.do")
	public ModelAndView getQuestionsBySingleTag(@RequestParam("tag") String tag) {
		List<Question> qList = frockoverflowdao.getQuestionByTag(tag);
		ModelAndView mv = new ModelAndView("results.jsp", "updatedQuestionList", qList);
		if (qList.size() == 0) mv.addObject("message", "No Questions Found");
		return mv;
	}
	
	//Returns question by id
	@RequestMapping("getQuestionByID.do")
	public ModelAndView getQuestion(@ModelAttribute("user") User user, @RequestParam("id") int id) {
		Question q = frockoverflowdao.getQuestion(id);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		mv.addObject("question", q);
		mv.addObject("user", user);
		return mv;
	}
	//Creates question 
	@RequestMapping("createQuestion.do")
	public ModelAndView getCreateQuestion(Question question, @ModelAttribute("user") User user,
			@ModelAttribute("tags") List<Tag> tags,
			@RequestParam("keywords") String keywords) {
		ModelAndView mv = new ModelAndView();
		question.setBody(DBUtilities.massageInputText(question.getBody()));
		frockoverflowdao.createQuestion(question, user, keywords);
		Question q = frockoverflowdao.getQuestion(question.getId());
		List<Question> qList = new ArrayList<>();
		qList.add(q);
		tags = frockoverflowdao.getTags();
		mv.setViewName("results.jsp");
		mv.addObject("updatedQuestionList", qList);
		mv.addObject("tags", tags);
		return mv;
	}
	
	//Removes question from db
	@RequestMapping("removeQuestion.do")
	public ModelAndView removeQuestion(@RequestParam("question_id") int id) {
		ModelAndView mv = new ModelAndView("results.jsp", "message", "The Question has been deleted");
		frockoverflowdao.removeQuestion(id);
		List<Question> questions = frockoverflowdao.getAllQuestions();
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}
	
	//Posts answer to question
	@RequestMapping("postAnswer.do")
	public ModelAndView postAnswer(Answer a, @ModelAttribute("user") User user,
			@RequestParam("question_id") int q) {
		a.setBody(DBUtilities.massageInputText(a.getBody()));
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		List<Question> qList = new ArrayList<>();
		frockoverflowdao.postAnswer(a, user, q);
		Question question = frockoverflowdao.getQuestion(a.getQuestion().getId());
		qList.add(question);
		mv.addObject("updatedQuestionList", qList);
		return mv;
	}
	
	//Admin method to accept answer
	@RequestMapping("acceptAnswer.do")
	public ModelAndView acceptAnswer(@RequestParam("answer_id") int id) {
		Question q = frockoverflowdao.acceptAnswer(id);
		ModelAndView mv = new ModelAndView("results.jsp", "acceptedAnswerQuestion", q);
		List<Question> questions = new ArrayList<>();
		questions.add(q);
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}
	
	//Admin method to remove answer
	@RequestMapping("removeAnswer.do")
	public ModelAndView removeAnswer(@RequestParam("remove_answer_id") int id) {
		ModelAndView mv = new ModelAndView("results.jsp", "message", "The Answer has been deleted");
		Question q = frockoverflowdao.removeAnswer(id);
		List<Question> questions = new ArrayList<>();
		questions.add(q);
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}
	
	//Adds user to db
	@RequestMapping("addUser.do")
	public ModelAndView createUser(/*@Valid*/ User u/*, BindingResult result*/) {
		User userToAdd = new User();
		userToAdd.setEmail(u.getEmail());
		userToAdd.setPassword(u.getPassword());
		userToAdd.setFirstName(u.getFirstName());
		userToAdd.setLastName(u.getLastName());
		userToAdd.setDisplayName(u.getDisplayName());
		User user = frockoverflowdao.createUser(userToAdd);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		mv.addObject("user", user);
		return mv;
	}
	
	//Returns specific user after log-in
	@RequestMapping("getUser.do")
	public ModelAndView getUser(@ModelAttribute("user") User login, @RequestParam("email") String email,
			@RequestParam("password") String password) {
		ModelAndView mv = new ModelAndView();
		login = frockoverflowdao.getUser(email, password);
		List<Question> userQuestions = frockoverflowdao.getQuestionsByUser(login);
		mv.setViewName("index.do");
		mv.addObject("user", login);
		mv.addObject("userQuestions", userQuestions);
		mv.addObject("updatedQuestionList", frockoverflowdao.getAllQuestions());
		return mv;
	}
	
	//gets the most recent question
	@RequestMapping("getMostRecentQuestion.do")
	public ModelAndView getMostRecentQuestion() {
		Question mostrecent = frockoverflowdao.getMostRecentQuestion();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp");
		mv.addObject("question", mostrecent); 
		return mv;
	}
	
	//Edits profile
	@RequestMapping("editprofile.do")
	public ModelAndView editProfile(User u){
	User user = frockoverflowdao.editUser(u);
	ModelAndView mv = new ModelAndView();
	if(user.getId() == 1000){
		mv.addObject( "invalid", "Invalid Password");
	}
		mv.setViewName("results.jsp");
		mv.addObject("user", user);
	return mv;
}
	//Navigates to edit profile
	@RequestMapping("gotoeditprofile.do")
	public ModelAndView goToEdit(@ModelAttribute("user") User u){
		ModelAndView mv = new ModelAndView("profile.jsp", "user", u);
		return mv;	
	}
	
	//Logs out and returns guest user
	@RequestMapping("logOut.do")
	public ModelAndView logOut(User u){
	User user = frockoverflowdao.logOut(u);
	ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp");
		mv.addObject("user", user);
	return mv;
	}
	
	//Votes a question up
	@RequestMapping("voteUp.do")
	public ModelAndView  voteUp (int answerId, @ModelAttribute("user") User user){
		Question question = frockoverflowdao.voteUp(answerId, user.getId());
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		List<Question> questions = new ArrayList<>();
		questions.add(question);
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}
	
	//Votes a question down
	@RequestMapping("voteDown.do")
	public ModelAndView  voteDown(int answerId, @ModelAttribute("user") User user){
		Question question = frockoverflowdao.voteDown(answerId, user.getId());
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		List<Question> questions = new ArrayList<>();
		questions.add(question);
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}
	
	//Adds a comment to the question
	@RequestMapping("commentOnQuestion.do")
	public ModelAndView addCommentToQuestion (@ModelAttribute("user") User user, 
			@RequestParam("question_id") int q, QComment c) {
		ModelAndView mv = new ModelAndView("results.jsp", "message", "comment posted");
		Question question = frockoverflowdao.commentOnQuestion(c, user.getId(), q);
		List<Question> questions = new ArrayList<>();
		questions.add(question);
		mv.addObject("updatedQuestionList", questions);
		return mv;
		
	}
	
	//Adds a comment to answers
	@RequestMapping("commentOnAnswer.do")
	public ModelAndView addCommentToAnswer (@ModelAttribute("user") User user, 
			@RequestParam("answer_id") int a, AComment c) {
		Question question = frockoverflowdao.commentOnAnswer(c, user.getId(), a);
		ModelAndView mv = new ModelAndView("results.jsp", "message", "comment posted");
		List<Question> questions = new ArrayList<>();
		questions.add(question);
		mv.addObject("updatedQuestionList", questions);
		return mv;
		
	}
	
	//Removes user *METHOD DOESNT GET USED*
	@RequestMapping("removeUser.do")
	public ModelAndView removeUser(int id){
	frockoverflowdao.removeUser(id);
	List <User> users = frockoverflowdao.getAllUsers(); 
	ModelAndView mv = new ModelAndView();
	mv.setViewName("admin.jsp");
	mv.addObject("users", users); 
	return mv; 
	
	}
	
	//Returns all users
	@RequestMapping("getAllUsers.do")
	public ModelAndView getAllUsers(){
		List <User> users = frockoverflowdao.getAllUsers(); 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin.jsp");
		mv.addObject("users", users); 
		return mv; 
		
	}
	
	//Deactivates User
	@RequestMapping("deactivateUser.do")
	public ModelAndView  deactivateUser (int  id, int userType){
		frockoverflowdao.deactivateUser(id, userType); 
		List <User> users = frockoverflowdao.getAllUsers(); 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin.jsp");
		mv.addObject("users", users); 
		return mv;
	}
	
	//Activates User
	@RequestMapping("activateUser.do")
	public ModelAndView  activateUser (int  id, int userType){
		frockoverflowdao.activateUser(id, userType); 
		List <User> users = frockoverflowdao.getAllUsers(); 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin.jsp");
		mv.addObject("users", users); 
		return mv;
	}
}
