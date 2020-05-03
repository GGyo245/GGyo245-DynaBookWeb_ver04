package kr.co.novelweb.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.novelweb.DAO.DynaBookDAO;
import kr.co.novelweb.DAO.DynaBookUserDAO;
import kr.co.novelweb.Security.SecurityUserConfig;
import kr.co.novelweb.VO.DynaBookUserVO;
import kr.co.novelweb.VO.DynaBookVO;
import kr.co.novelweb.service.FileService;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class DynaBookController {
	
	@Autowired DynaBookDAO dao;
	
	@Autowired DynaBookUserDAO Udao;
	
	private final String uploadPath = "C:\\Users\\user\\git\\DynaBookWeb_ver03\\src\\main\\webapp\\resources\\css\\img\\TitleImg"; 
	
	@GetMapping("/uploadNovel")
	public String uploadNovel(HttpSession session) {

		log.info("move to uploadNovel!");
		
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
		
		return "uploadNovel";
	}
	
	@GetMapping("/modifyNovel")
	public String modifyNovel(@RequestParam(value="booknumber",defaultValue = "-1")int booknumber, Model model, HttpSession session) {
		
		log.info("modifyNovel!");
		
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
		
		if(booknumber == -1) {
			log.info("책 정보를 불러올 수 없습니다. 잘못된 접근");
			return "home";
		}
		
		DynaBookVO book = dao.selectBookOne(booknumber);
		DynaBookUserVO writer = Udao.selectUserOneFromNumber(book.getBook_usernumber());
		
		if(!email.equals(writer.getEmail())) {
			//작성자와 로그인한 사람이 다름(불허)
			log.info("이 책의 작성자가 아닙니다. 잘못된 접근");
			return "redirect:/";
			
		}else {
			//책의 작성자와 로그인한 사람이 같음(허용) 
			model.addAttribute("book", book);
			
			return "modifyNovel";
		}
		
	}
	
	@RequestMapping(value = "/insertDynabook", method=RequestMethod.POST)
	public String insertDynaBook(DynaBookVO book, MultipartFile upload, HttpSession session) {
		
		log.info("insertDynabook");
		
		String email = (String)session.getAttribute("loginId");
		DynaBookUserVO userdb = Udao.selectUserOne(email);
		book.setBook_usernumber(userdb.getUsernumber());
		
		int key = dao.insertDynabook(book);
		
		//파일 유무 확인
		if(!upload.isEmpty()) {
			//물리적으로 저장 (파일이 적용 안될시 업로드Path 설정확인 혹은 ctrl + F5)
			FileService.saveFile(upload, key, uploadPath);
		}
		
		return "redirect:/user/myWriteBook";
	}
	
	@RequestMapping(value="/updateDynabook", method = RequestMethod.POST)
	public String updateBook(DynaBookVO book, MultipartFile upload, HttpSession session) {
		
		int flag = 0;
		String email = (String)session.getAttribute("loginId");
		DynaBookUserVO user = Udao.selectUserOne(email);
		//책에 세션에 들어온 유저 넘버를 넘겨 작성자가 확실한지 한 번 더 검사
		book.setBook_usernumber(user.getUsernumber());
		
		flag = dao.updateDynaBook(book);
		
		if(flag == 0) {
			log.info("업데이트 실패");
		}else {
			log.info("업데이트 성공");
			if(!upload.isEmpty()) {
				//물리적으로 저장 (파일이 적용 안될시 업로드Path 설정확인)
				FileService.saveFile(upload, book.getBooknumber(), uploadPath);
			}
		}
		
		
		return "redirect:/user/myWriteBook"; 
	}
	
}
