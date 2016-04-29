package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import data.FrockOverflowDao;
import entities.Question;

public class FrockOverflowController {
	 @Autowired    // Un-comment this section if using Autowiring.
	    private FrockOverflowDao frockoverflowdao;
	    
		@RequestMapping("GetQuestionByID.do")
		public ModelAndView getQuestion(int id){
			Question q = frockoverflowdao.getQuestion(id); 
			ModelAndView mv = new ModelAndView();
			mv.setViewName("result.jsp");
			mv.addObject("question", q); 
			return mv;
		}
}
