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

	@ModelAttribute("user")
	public User initUser() {
		return new User();
	}
	@ModelAttribute("tags")
	public List<Tag> initTags(){
		List <Tag> tags = frockoverflowdao.getTags();
		return tags;
	}
	

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
	
	@RequestMapping("index.do")
	public ModelAndView initialLoad() {
		Question mostrecent = frockoverflowdao.getMostRecentQuestion();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp");
		mv.addObject("question", mostrecent); 
		return mv;
	}

	
	@RequestMapping("searchByTag.do")
	public ModelAndView getQuestionsByTag(@RequestParam("searchTags") String tagString) {
		String[] tagarr = tagString.split(" ");
		System.out.println(tagarr[0]);
		List<Question> qList = frockoverflowdao.getQuestionByTag(tagarr[0]);
		ModelAndView mv = new ModelAndView("results.jsp", "updatedQuestionList", qList);
		if (qList.size() == 0) mv.addObject("message", "No Questions Found");
		return mv;
	}
	
	@RequestMapping("searchBySingleTag.do")
	public ModelAndView getQuestionsBySingleTag(@RequestParam("tag") String tag) {
		List<Question> qList = frockoverflowdao.getQuestionByTag(tag);
		ModelAndView mv = new ModelAndView("results.jsp", "updatedQuestionList", qList);
		if (qList.size() == 0) mv.addObject("message", "No Questions Found");
		return mv;
	}
	
	@RequestMapping("getQuestionByID.do")
	public ModelAndView getQuestion(@ModelAttribute("user") User user, @RequestParam("id") int id) {
		Question q = frockoverflowdao.getQuestion(id);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		mv.addObject("question", q);
		mv.addObject("user", user);
		return mv;
	}

	@RequestMapping("createQuestion.do")
	public ModelAndView getCreateQuestion(Question question, @ModelAttribute("user") User user,
			@ModelAttribute("tags") List<Tag> tags,
			@RequestParam("keywords") String keywords) {
		ModelAndView mv = new ModelAndView();
		List<Question> updatedQuestionList = frockoverflowdao.createQuestion(question, user, keywords);
		tags = frockoverflowdao.getTags();
		mv.setViewName("results.jsp");
		mv.addObject("updatedQuestionList", updatedQuestionList);
		mv.addObject("tags", tags);
		return mv;
	}
	
	@RequestMapping("removeQuestion.do")
	public ModelAndView removeQuestion(int id) {
		ModelAndView mv = new ModelAndView("results.jsp", "message", "The Question has been deleted");
		frockoverflowdao.removeQuestion(id);
		List<Question> questions = frockoverflowdao.getAllQuestions();
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}

	@RequestMapping("postAnswer.do")
	public ModelAndView postAnswer(Answer a, @ModelAttribute("user") User user,
			@RequestParam("question_id") int q) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		
//		List<Answer> answers = frockoverflowdao.getAnswersByQuestionId(question.getId());
//		for(Answer ans : answers) {
//			System.out.println(ans.getBody());
//		}
		List<Question> qList = frockoverflowdao.postAnswer(a, user, q);
//		mv.addObject("answersByQ", answers);
		mv.addObject("updatedQuestionList", qList);
		return mv;
	}
	
	@RequestMapping("acceptAnswer.do")
	public ModelAndView acceptAnswer(@RequestParam("answer_id") int id) {
		Question q = frockoverflowdao.acceptAnswer(id);
		ModelAndView mv = new ModelAndView("results.jsp", "acceptedAnswerQuestion", q);
		List<Question> questions = new ArrayList<>();
		questions.add(q);
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}
	
//	@RequestMapping("getAnswers.do")
//	public ModelAndView getAnswers(int id) {
//		List<Answer> answers = frockoverflowdao.getAnswersByQuestionId(id);
//		Question q = frockoverflowdao.getQuestion(id);
//		ModelAndView mv = new ModelAndView("results.jsp", "answersByQ", answers);
//		mv.addObject("answeredQuestion", q);
//		return mv;
//	}
	
	@RequestMapping("removeAnswer.do")
	public ModelAndView removeAnswer(@RequestParam("answer_id") int id) {
		ModelAndView mv = new ModelAndView("results.jsp", "message", "The Answer has been deleted");
		Question q = frockoverflowdao.removeAnswer(id);
		List<Question> questions = new ArrayList<>();
		questions.add(q);
		mv.addObject("updatedQuestionList", questions);
		return mv;
	}

	@RequestMapping("addUser.do")
	public ModelAndView createUser(/*@Valid*/ User u/*, BindingResult result*/) {
		User userToAdd = new User();
		userToAdd.setEmail(u.getEmail());
		userToAdd.setPassword(u.getPassword());
		userToAdd.setFirstName(u.getFirstName());
		userToAdd.setLastName(u.getLastName());
		userToAdd.setDisplayName(u.getDisplayName());
//		if(result.hasErrors()){
//			ModelAndView mv = new ModelAndView();
//			mv.setViewName("results.jsp");
//			String returned = "FORM VALIDATED BRO"; 
//			mv.addObject("create", returned);
//			return mv;
//		}
		User user = frockoverflowdao.createUser(userToAdd);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		mv.addObject("user", user);
		return mv;
	}
	@RequestMapping("getUser.do")
	public ModelAndView getUser(@ModelAttribute("user") User login, @RequestParam("email") String email,
			@RequestParam("password") String password) {
		ModelAndView mv = new ModelAndView();
		login = frockoverflowdao.getUser(email, password);
		List<Question> userQuestions = frockoverflowdao.getQuestionsByUser(login);
		System.out.println(login);
		mv.setViewName("results.jsp");
		mv.addObject("user", login);
		mv.addObject("userQuestions", userQuestions);
		mv.addObject("updatedQuestionList", frockoverflowdao.getAllQuestions());
		return mv;
	}
	@RequestMapping("getMostRecentQuestion.do")
	public ModelAndView getMostRecentQuestion() {
		Question mostrecent = frockoverflowdao.getMostRecentQuestion();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp");
		mv.addObject("question", mostrecent); 
		return mv;
	}
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
	@RequestMapping("gotoeditprofile.do")
	public ModelAndView goToEdit(@ModelAttribute("user") User u){
		ModelAndView mv = new ModelAndView("profile.jsp", "user", u);
		return mv;	
	}
	@RequestMapping("logOut.do")
	public ModelAndView logOut(User u){
	User user = frockoverflowdao.logOut(u);
	ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp");
		mv.addObject("user", user);
	return mv;
	}
	
//	Tim started the methods below before realizing he should probably talk to the team first. 
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
}
