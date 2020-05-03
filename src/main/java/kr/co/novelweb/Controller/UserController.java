package kr.co.novelweb.Controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.novelweb.DAO.BookmarkDAO;
import kr.co.novelweb.DAO.DynaBookDAO;
import kr.co.novelweb.DAO.DynaBookUserDAO;
import kr.co.novelweb.DAO.PurchaseDAO;
import kr.co.novelweb.Security.SecurityUserConfig;
import kr.co.novelweb.VO.DynaBookUserVO;
import kr.co.novelweb.VO.DynaBookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	DynaBookUserDAO dao;
	
	@Autowired
	BookmarkDAO BMdao;
	
	@Autowired
	DynaBookDAO Bdao;
	
	@Autowired
	PurchaseDAO Pdao;
	
	/*
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("logout 요청");
		session.removeAttribute("loginId");
		session.removeAttribute("loginNick");
		return "home";
	}
	*/
	
	@RequestMapping(value="/deleteUser", method=RequestMethod.POST)
	public String deleteUser(int usernumber, HttpSession session) {
		
		log.info("deleteUser 요청");
		
		int flag = dao.deleteUser(usernumber);
		
		if(flag != 0 ) {
			session.removeAttribute("loginId");
			session.removeAttribute("loginNick");
			log.info("유저 정보 삭제 완료");
		}else {
			log.info("유저 정보 삭제 실패");
		}
		return "redirect:/";
	}
	
	@GetMapping("/myPage")
	public String myPage(Model model, HttpSession session) {
		
		log.info("move to myPage");
		
		//시큐리티로 인한 세션 설정
		String email = (String)session.getAttribute("loginId");
		if(email == null) {
			DynaBookUserVO user = (DynaBookUserVO)SecurityContextHolder.getContext().getAuthentication().getDetails(); 
			
			//유저 권한 부여
			new SecurityUserConfig(user);
			//세션 지정
			session.setAttribute("loginId", user.getEmail());
			session.setAttribute("loginNick", user.getNick());
			email = user.getEmail();
		}
		
		DynaBookUserVO user = dao.selectUserOne(email);
		model.addAttribute("user", user);
		
		return "myPage";
	}
	@RequestMapping(value="/nickupdate", method = RequestMethod.POST)
	public String nickupdate(DynaBookUserVO user, HttpSession session) {
		
		log.info("새로이 바꿀 nick : "+user.getNick());
		
		int count = 0;
		String email = (String)session.getAttribute("loginId");
		log.info("요청한 ID : " + email);
		user.setEmail(email);
		
		count = dao.updateNick(user);
		
		if(count != 0) {
			log.info("nick 변경 성공");
			session.removeAttribute("loginNick");
			session.setAttribute("loginNick", user.getNick());
		}else {
			log.info("nick 변경 실패");
		}
		
		return "redirect:/user/myPage";
	}
	
	@RequestMapping(value="/PWupdate", method = RequestMethod.POST)
	public String PWupdate(DynaBookUserVO user, String modifyPw, HttpSession session, Model model) {
		
		String email = (String)session.getAttribute("loginId");
		log.info("요청한 ID : " + email);
		log.info("현재 입력한 비밀번호"+user.getPw());
		user.setEmail(email);
		int count = 0;
		
		DynaBookUserVO userdb = dao.selectUserOne(email);
		if(!userdb.getPw().equals(user.getPw())) {
			log.info("비밀번호 불일치");
			model.addAttribute("error", "등록된 비밀번호와 일치하지 않습니다.");
			model.addAttribute("user", userdb);
			return "/myPage";
		}else {
			user.setPw(modifyPw);
			count = dao.updatePW(user);
		}
		
		if(count != 0) {
			log.info("pw 변경 성공");
			return "redirect:/";
		}else {
			log.info("pw 변경 실패");
			model.addAttribute("error", "비밀번호 변경 실패");
			model.addAttribute("user", userdb);
			return "/myPage";
		}
	}
	
	@GetMapping("/mylist")
	public String mylist(HttpSession session) {
		
		log.info("move to myList");
		
		//시큐리티로 인한 세션 설정
		String email = (String)session.getAttribute("loginId");
		if(email == null) {
			DynaBookUserVO user = (DynaBookUserVO)SecurityContextHolder.getContext().getAuthentication().getDetails(); 
			
			//유저 권한 부여
			new SecurityUserConfig(user);
			//세션 지정
			session.setAttribute("loginId", user.getEmail());
			session.setAttribute("loginNick", user.getNick());
			email = user.getEmail();
		}
		
		
		return "mylist";
	}
	
	@RequestMapping(value="/myBookMark", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<HashMap<String, Object>> myBookMark(HttpSession session) {
		
		log.info("Request myBookMark");
		
		String email = (String)session.getAttribute("loginId");
		DynaBookUserVO userdb = dao.selectUserOne(email);
		ArrayList<HashMap<String, Object>> bookmark = BMdao.selectBookMark(userdb.getUsernumber());
		
		return bookmark;
	}
	
	@RequestMapping(value="/myPurchase", method= RequestMethod.POST)
	@ResponseBody
	public ArrayList<HashMap<String, Object>> myPurchase(HttpSession session) {
		
		log.info("Request myBookMark");
		String email = (String)session.getAttribute("loginId");
		DynaBookUserVO userdb = dao.selectUserOne(email);
		ArrayList<HashMap<String, Object>> purchase = Pdao.slectPurchaseHash(userdb.getUsernumber());
		
		return purchase;
	}
	
	@GetMapping("/myWriteBook")
	public String myWriteBook(Model model, HttpSession session) {
		
		log.info("move to myWriteBook");
		
		//시큐리티로 인한 세션 설정
		String email = (String)session.getAttribute("loginId");
		if(email == null) {
			DynaBookUserVO user = (DynaBookUserVO)SecurityContextHolder.getContext().getAuthentication().getDetails(); 
			
			//유저 권한 부여
			new SecurityUserConfig(user);
			//세션 지정
			session.setAttribute("loginId", user.getEmail());
			session.setAttribute("loginNick", user.getNick());
			email = user.getEmail();
		}
		
		DynaBookUserVO userdb = dao.selectUserOne(email);
		ArrayList<DynaBookVO> book = Bdao.selectBookFromUser(userdb.getUsernumber());
		model.addAttribute("book", book);
		
		
		return "mywrite";
	}
	
	@GetMapping("/introduce")
	public String Introduce(HttpSession session) {
		
		log.info("move to Introduce");
		//시큐리티로 인한 세션 설정
		String email = (String)session.getAttribute("loginId");
		if(email == null) {
			DynaBookUserVO user = (DynaBookUserVO)SecurityContextHolder.getContext().getAuthentication().getDetails(); 
			
			//유저 권한 부여
			new SecurityUserConfig(user);
			//세션 지정
			session.setAttribute("loginId", user.getEmail());
			session.setAttribute("loginNick", user.getNick());
			email = user.getEmail();
		}
		
		return "Introduce";
	}
}



