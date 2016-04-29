package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.FrockOverflowDao;
import entities.Question;

@Controller
public class FrockOverflowController {
	 @Autowired
	    private FrockOverflowDao frockoverflowdao;
	    
		@RequestMapping("GetQuestionByID.do")
		public ModelAndView getQuestion(@RequestParam("id")int id){
			Question q = frockoverflowdao.getQuestion(id); 
			ModelAndView mv = new ModelAndView();
			mv.setViewName("results.jsp");
			mv.addObject("question", q); 
			return mv;
		}
}
