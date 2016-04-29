package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import data.FrockOverflowDao;
import entities.Question;

public class FrockOverflowController {
	 @Autowired    // Un-comment this section if using Autowiring.
	    private FrockOverflowDao frockoverflowdbdao;
	
		}
}
