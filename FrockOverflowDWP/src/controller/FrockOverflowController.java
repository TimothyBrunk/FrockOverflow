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
import entities.Answer;
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
	
	@RequestMapping("searchByTag.do")
	public ModelAndView getQuestionsByTag(@RequestParam("searchTags") String tagString) {
		String[] tagarr = tagString.split(" ");
		System.out.println(tagarr[0]);
		List<Question> qList = frockoverflowdao.getQuestionByTag(tagarr[0]);
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
			@RequestParam("keywords") String keywords) {
		List<Question> updatedQuestionList = frockoverflowdao.createQuestion(question, user, keywords);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		mv.addObject("updatedQuestionList", updatedQuestionList);
		return mv;
	}

	@RequestMapping("postAnswer.do")
	public ModelAndView postAnswer(Answer a, @ModelAttribute("user") User user,
			@RequestParam("question_id") int q) {
		Question question = frockoverflowdao.postAnswer(a, user, q);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("results.jsp");
		
		List<Answer> answers = frockoverflowdao.getAnswersByQuestionId(question.getId());
		for(Answer ans : answers) {
			System.out.println(ans.getBody());
		}
		mv.addObject("answersByQ", answers);
		mv.addObject("answeredQuestion", question);
		return mv;
	}
	
	@RequestMapping("acceptAnswer.do")
	public ModelAndView acceptAnswer(@RequestParam("answer_id") int id) {
		Question q = frockoverflowdao.acceptAnswer(id);
		ModelAndView mv = new ModelAndView("results.jsp", "acceptedAnswerQuestion", q);
		List<Answer> answers = frockoverflowdao.getAnswersByQuestionId(q.getId());
		for(Answer ans : answers) {
			System.out.println(ans.getBody());
		}
		mv.addObject("answersByQ", answers);
		return mv;
	}
	
	@RequestMapping("getAnswers.do")
	public ModelAndView getAnswers(int id) {
		List<Answer> answers = frockoverflowdao.getAnswersByQuestionId(id);
		Question q = frockoverflowdao.getQuestion(id);
		ModelAndView mv = new ModelAndView("results.jsp", "answersByQ", answers);
		mv.addObject("answeredQuestion", q);
		return mv;
	}

	@RequestMapping("addUser.do")
	public ModelAndView createUser(/*@Valid*/ User u/*, BindingResult result*/) {
//		if(result.hasErrors()){
//			ModelAndView mv = new ModelAndView();
//			mv.setViewName("results.jsp");
//			String returned = "FORM VALIDATED BRO"; 
//			mv.addObject("create", returned);
//			return mv;
//		}
		User user = frockoverflowdao.createUser(u);
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
//	@RequestMapping("voteUp.do")
//	public ModelAndView  voteUp (int rating){
//		
//		ModelAndView mv = new ModelAndView();
//		mv.setViewName("results.jsp");
//		mv.addObject("updatedQuestionList", updatedQuestionList);
//		return mv;
//	}
//	@RequestMapping("voteDown.do")
//	public ModelAndView  voteDown(int rating){
//		
//		ModelAndView mv = new ModelAndView();
//		mv.setViewName("results.jsp");
//		mv.addObject("updatedQuestionList", updatedQuestionList);
//		return mv;
//	}

}
