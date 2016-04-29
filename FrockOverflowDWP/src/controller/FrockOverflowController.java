package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import data.FrockOverflowDao;
import entities.Question;
import entities.User;

@Controller
@SessionAttributes("user")
public class FrockOverflowController {
	 @Autowired
	    private FrockOverflowDao frockoverflowdao;
	 
	 @ModelAttribute("user")
	 public User initUser() {
		 return new User(); 
	 }
	    
		@RequestMapping("GetQuestionByID.do")
		public ModelAndView getQuestion(@RequestParam("id")int id){
			Question q = frockoverflowdao.getQuestion(id); 
			ModelAndView mv = new ModelAndView();
			mv.setViewName("results.jsp");
			mv.addObject("question", q); 
			return mv;
		}
		
		@RequestMapping("CreateQuestion.do")
		public ModelAndView getCreateQuestion(Question question){
			List <Question> c = frockoverflowdao.createQuestion(question); 
			ModelAndView mv = new ModelAndView();
			mv.setViewName("results.jsp");
			mv.addObject("create", c); 
			return mv;
		}
}
