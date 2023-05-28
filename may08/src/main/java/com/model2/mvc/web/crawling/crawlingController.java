package com.model2.mvc.web.crawling;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.service.domain.Player;
import com.model2.mvc.service.domain.Product;

@Controller
@RequestMapping("/crawling/*")
public class crawlingController {

	public crawlingController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="player", method=RequestMethod.GET)
	public String getPlayer() {
		
		System.out.println("호우세레머니");
		Player player = new Player();
		System.out.println(player); 
		System.out.println("호우세레머니");
		
		return "666";
	}

}