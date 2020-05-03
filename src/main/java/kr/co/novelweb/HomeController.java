package kr.co.novelweb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.novelweb.DAO.DynaBookDAO;
import kr.co.novelweb.DAO.DynaBookUserDAO;
import kr.co.novelweb.Security.SecurityUserConfig;
import kr.co.novelweb.VO.DynaBookUserVO;
import kr.co.novelweb.VO.DynaBookVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	@Autowired DynaBookDAO dao;
	@Autowired DynaBookUserDAO Udao;
 	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		log.info("Welcome home!");
		
		
		return "home";
	}
	@GetMapping("/popular")
	public String popular(Model model) {
		
		log.info("move to popular!");
		ArrayList<HashMap<String, Object>> fantasyPopular = dao.selectPopularBooksFromGenre("fantasy");
		ArrayList<HashMap<String, Object>> romancePopular = dao.selectPopularBooksFromGenre("romance");
		ArrayList<HashMap<String, Object>> thrillerPopular = dao.selectPopularBooksFromGenre("thriller");
		
		model.addAttribute("fantasy", fantasyPopular);
		model.addAttribute("romance", romancePopular);
		model.addAttribute("thriller", thrillerPopular);
		
		return "popular";
	}
	@GetMapping("/newBook")
	public String newBook(Model model){
		
		log.info("move to newBook!");
		
		ArrayList<DynaBookVO> fantasyNew = dao.selectNewBookFromGenre("fantasy");
		ArrayList<DynaBookVO> romanceNew = dao.selectNewBookFromGenre("romance");
		ArrayList<DynaBookVO> thrillerNew = dao.selectNewBookFromGenre("thriller");
		
		model.addAttribute("fantasy", fantasyNew);
		model.addAttribute("romance", romanceNew);
		model.addAttribute("thriller", thrillerNew);
		
		return "newBook";
	}
	@GetMapping("/genre")
	public String genre(Model model) {
		
		log.info("move to genre!");
		
		ArrayList<DynaBookVO> fantagyNew = dao.selectNewBookFromGenre("fantasy");
		ArrayList<DynaBookVO> romanceNew = dao.selectNewBookFromGenre("romance");
		ArrayList<DynaBookVO> thrillerNew = dao.selectNewBookFromGenre("thriller");
		
		model.addAttribute("fantagy", fantagyNew);
		model.addAttribute("romance", romanceNew);
		model.addAttribute("thriller", thrillerNew);
		
		return "genre";
	}
	@GetMapping("/loginpage")
	public String loginpage(HttpServletRequest request, Model model) {

		log.info("move to loginpage!!");
		
		Cookie[] cookies = request.getCookies();
		
		String rememberId = null;
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				String name = cookies[i].getName();
				if(name.equals("rid")) {
					log.info("쿠기 확인, 적용");
					rememberId = cookies[i].getValue();
				};
			};
		};
		log.info("저장한 쿠키"+rememberId);
		model.addAttribute("rememberId", rememberId);
		return "loginpage";
	}
	
	@RequestMapping(value="/loginSuccess", method=RequestMethod.GET)
	public String login(HttpSession session, HttpServletResponse response) {
		
		log.info("login 요청 성공");
		
		DynaBookUserVO user = (DynaBookUserVO)SecurityContextHolder.getContext().getAuthentication().getDetails(); 
		
		//유저 권한 부여
		new SecurityUserConfig(user);
		//세션 지정
		session.setAttribute("loginId", user.getEmail());
		session.setAttribute("loginNick", user.getNick());
		
		/*
		if(remember != null && remember.equals("check")) {
			log.info("쿠키 업뎃");
			//쿠키 생성
			Cookie cookie = new Cookie("rid", user.getEmail());
			//유지기간 설정
			cookie.setMaxAge(60*60*24*90);
			response.addCookie(cookie);
		}
		*/
		
		return "home";
	}
	
	@GetMapping("/joinpage")
	public String joinpage() {

		log.info("move to joinpage!");
		
		return "joinpage";
	}
	
	@RequestMapping(value="/join")
	public String join(DynaBookUserVO user) {
		
		log.info("join 요청");
		
		int fg = Udao.insertUser(user);
		
		if(fg != 0) {
			log.info("join 요청 성공");
			return "redirect:/loginpage";
		}else {
			log.info("join 요청 실패");
			return "redirect:/joinpage";
		}
	}
	
	@GetMapping("/fantagy")
	public String fantagy(Model model) {
		
		log.info("move to fantagy!");
		
		ArrayList<DynaBookVO> newBook = dao.selectNewBookFromGenre("fantasy");
		
		model.addAttribute("newBook", newBook);
		
		return "fantagy";
	}
	
	@GetMapping("/romance")
	public String romance(Model model) {
		
		log.info("move to romance!");
		
		ArrayList<DynaBookVO> newBook = dao.selectNewBookFromGenre("romance");
		
		model.addAttribute("newBook", newBook);
		
		return "romance";
	}
	
	@GetMapping("/thriller")
	public String thriller(Model model) {
		
		log.info("move to thriller!");
		
		ArrayList<DynaBookVO> newBook = dao.selectNewBookFromGenre("thriller");
		
		model.addAttribute("newBook", newBook);
		
		return "thriller";
	}
	
	@GetMapping("/search")
	public String search(@RequestParam Map<String, String> params, Model model) {

		log.info("search!");
		log.info("search to "+params.get("title"));
		
		ArrayList<HashMap<String, Object>> book = dao.selectBooksFromTitle(params);
		
		model.addAttribute("book", book);
		model.addAttribute("search", params.get("title"));
		
		return "search";
	}
	
	@RequestMapping(value = "/userAccessDenied" , method = RequestMethod.GET)
	public String userAccessDenied(){
		return "/userAccessDenied";
	}
}
