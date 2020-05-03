package kr.co.novelweb.Controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ibm.watson.natural_language_understanding.v1.model.AnalysisResults;
import com.ibm.watson.natural_language_understanding.v1.model.EmotionResult;

import kr.co.novelweb.service.FileService;
import kr.co.novelweb.service.IBMService;
import kr.co.novelweb.DAO.BackGroundDAO;
import kr.co.novelweb.DAO.BookPartDAO;
import kr.co.novelweb.DAO.DynaBookDAO;
import kr.co.novelweb.DAO.DynaBookUserDAO;
import kr.co.novelweb.DAO.EmotionDAO;
import kr.co.novelweb.Security.SecurityUserConfig;
import kr.co.novelweb.VO.BackGroundVO;
import kr.co.novelweb.VO.BookPartVO;
import kr.co.novelweb.VO.DynaBookUserVO;
import kr.co.novelweb.VO.DynaBookVO;
import kr.co.novelweb.VO.EmotionVO;
import kr.co.novelweb.service.TranslateText;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class DynaBookpartController {
	
	@Autowired BookPartDAO dao;
	@Autowired EmotionDAO edao;
	@Autowired BackGroundDAO bdao;
	@Autowired DynaBookDAO Bdao;
	@Autowired DynaBookUserDAO Udao;
	
	private EmotionVO emotionVO;
	private BackGroundVO backVO;
	
	
	@GetMapping("/uploadEpisode")
	public String uploadEpisode(@RequestParam(value="booknumber",defaultValue="-1") int booknumber ,Model model,HttpSession session) {
		
		log.info("move to uploadEpisode!");
		if(booknumber == -1) {
			log.info("책 정보를 불러올 수 없습니다. 잘못된 접근");
			return "home";
		}
		
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
		
		DynaBookUserVO userdb = Udao.selectUserOne(email);
		DynaBookVO book = Bdao.selectBookOne(booknumber);
		
		if(userdb.getUsernumber() != book.getBook_usernumber()) {
			log.info("작성자와 세션이 일치하지 않습니다. 잘못된 접근");
			return "home";
		}else {
			model.addAttribute("book", book);
			
			log.info("작성자와 세션이 일치!");
			return "uploadEpisode";
		}
		
	}
	
	@GetMapping("/modifyEpisode")
	public String modifyEpisode(@RequestParam(value="bookpartnumber",defaultValue="-1")int bookpartnumber, Model model, HttpSession session) {
		
		log.info("move to modifyEpisode!");
		
		if(bookpartnumber == -1) {
			log.info("책 정보를 불러올 수 없습니다. 잘못된 접근");
			return "home";
		}
		
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
		
		DynaBookUserVO userdb = Udao.selectUserOne(email);
		
		BookPartVO part = dao.selectBookPartOne(bookpartnumber);
		DynaBookVO book = Bdao.selectBookOne(part.getPart_booknumber());
		
		if(book.getBook_usernumber() != userdb.getUsernumber()) {
			//작성자와 로그인한 사람이 다름(불허)
			log.info("이 책의 작성자가 아닙니다. 잘못된 접근");
			return "redirect:/";
		}else {
			model.addAttribute("bookpart", part);
			model.addAttribute("book", book);
			
			return "modifyEpisode";
		}
		
	}
	
	@RequestMapping(value = "insertDynaBookpart", method=RequestMethod.POST)
	public String insertDynaBookpart(BookPartVO part) {
		
		//한글 영어로 변환 결과 변수
		String result = "";
		//배경 정보 추출 시 체크 변수
		String bgck = "";
		
		IBMService ibm = new IBMService();
		EmotionResult emotion;
		AnalysisResults backemotion;
		emotionVO = new EmotionVO();
		backVO = new BackGroundVO();
		StringBuffer keyword = new StringBuffer();
		
		log.info("insert Episode!");
		
		//등록과 동시에 키 받아오기
		int key = dao.insertDynaBookpart(part);
		
		System.out.println("key값 : " + key);
		
		String[] ary = part.getText().split("</p>");
		
		log.info("p태그 수 : "+ary.length);
		
		for(int i = 0; i < ary.length; i++) {
			ary[i] = ary[i].replace("<p>", "");
			ary[i] = ary[i].replace("&nbsp;", "");
			ary[i] = ary[i].replace("&lt;", "");
			ary[i] = ary[i].replace("&gt;", "");
			ary[i] = ary[i].replace("<br>", "");
		}
		
		log.info("총 페이지 수 : "+(ary.length / 15 + 1));
		
		// 15개씩 자르고 페이지 만들기
		for(int i = 0; i < (ary.length / 15) ; i++) {
			
			log.info(i+"번째 페이지 작성중");
			for(int j = i * 15 ; j < (i+1)*15 ; j++){
				result += ary[j];
			}
			
			log.info(i+"번째 페이지 값 : "+result);
			//api 요청 보내고 해당 정보를 db에 저장 (감정 정보 저장)
			try {
				result = TranslateText.translateText(result);
				log.info("영어로 변환 : "+result);
				emotion = ibm.Targetemotion(result);
				System.out.println(i+"번째 페이지 감정 : "+emotion.getDocument().getEmotion());
				
				emotionVO.setAnger(emotion.getDocument().getEmotion().getAnger().toString());
				emotionVO.setDisgust(emotion.getDocument().getEmotion().getDisgust().toString());
				emotionVO.setFear(emotion.getDocument().getEmotion().getFear().toString());
				emotionVO.setJoy(emotion.getDocument().getEmotion().getJoy().toString());
				emotionVO.setSadness(emotion.getDocument().getEmotion().getSadness().toString());
				//페이지 넘버 저장
				emotionVO.setPagenumber(i);
				
				//북파트 정보 저장 필요
				emotionVO.setEmotion_bookpartnumber(key);
				
				//
				
				edao.insertEmotion(emotionVO);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//배경 키워드 추출
			backemotion = ibm.textAnalyze(result);
			//타입들을 체크 (사람이나, 수치, 수량을 나타내는 단어들 bgck에저장)
			for(int k = 0; k < backemotion.getEntities().size(); k++) {
				
				if(backemotion.getEntities().get(k).getType().equals("Person") ||
					backemotion.getEntities().get(k).getType().equals("Quantity")) {
					
					bgck += backemotion.getEntities().get(k).getText();
					
				}
			}
			//해당 키워드가 위 포문에서 나왔는지 확인 후 db에 페이지 정보와 같이 저장
			for(int k = 0 ; k < backemotion.getKeywords().size(); k++) {
				
				//위에서 받은 사람 이름이나 시간을 걸러낸다.
				if( bgck.indexOf(backemotion.getKeywords().get(k).getText()) == -1) {
					
					//특정 단어들이 나오면 거른다 people time 등등
					if(backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("people") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("time") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("woman") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("word") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("friend") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("man") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("corner") == -1 &&
						backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("guy") == -1
						) {
						
						//키워드 저장
						keyword.append(backemotion.getKeywords().get(k).getText()+"\\");
					}
					
				}
			}
			//북파트 넘버 저장 로직 필요
			backVO.setBackground_bookpartnumber(key);
			//키워드 종합해서 저장
			backVO.setKeyword(keyword.toString());
			//페이지 저장
			backVO.setPagenumber(i);
			//db에 저장
			bdao.insertKeyword(backVO);
			
			
			//초기화 로직
			result = "";
			backVO = null;
			emotionVO = null;
			backVO = new BackGroundVO();
			emotionVO = new EmotionVO();
			keyword.setLength(0);
		}
		
		
		// 나머지 페이지 처리 for문 (이곳에 배경 정보도 넣을지 추후에 결정)
		log.info("마지막 페이지 작성중");
		for(int i = 0; i < ary.length % 15; i++) {
			result += ary[i+((ary.length / 15 )* 15)];
		}
		//api 요청 보내고 해당 정보를 db에 저장
		log.info("마지막 페이지 값 : "+result);
		try {
			result = TranslateText.translateText(result);
			log.info("영어로 변환 : "+result);
			emotion = ibm.Targetemotion(result);
			System.out.println("마지막 페이지 감정 : "+emotion.getDocument().getEmotion());
			emotionVO.setAnger(emotion.getDocument().getEmotion().getAnger().toString());
			emotionVO.setDisgust(emotion.getDocument().getEmotion().getDisgust().toString());
			emotionVO.setFear(emotion.getDocument().getEmotion().getFear().toString());
			emotionVO.setJoy(emotion.getDocument().getEmotion().getJoy().toString());
			emotionVO.setSadness(emotion.getDocument().getEmotion().getSadness().toString());
			emotionVO.setPagenumber(ary.length / 15);
			emotionVO.setEmotion_bookpartnumber(key);
			
			edao.insertEmotion(emotionVO);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			emotionVO = null;
			
		return "redirect:books?booknumber="+part.getPart_booknumber()+"";
	}
	
	@RequestMapping(value="/updateDynabookpart", method = RequestMethod.POST)
	public String updateDynabookpart(BookPartVO part) {
		
		log.info("update episode");
		log.info("입력받은 part 정보 : "+part);
		
		BookPartVO dbpart = dao.selectBookPartOne(part.getBookpartnumber());
		
		int flag = 0;
		flag = dao.updateDynaBookpart(part);
		
		if(flag == 0) {
			log.info("업데이트 실패");
		}else {
			log.info("업데이트 성공");
			//백그라운드, 이모션 정보 삭제후 다시 insert (수정 후 페이지 정보가 달라지므로 update는 무리)
			edao.deleteEmotion(dbpart.getBookpartnumber());
			bdao.deleteBackGround(dbpart.getBookpartnumber());
			
			int key = dbpart.getBookpartnumber();
			IBMService ibm = new IBMService();
			AnalysisResults backemotion;
			EmotionResult emotion;
			emotionVO = new EmotionVO();
			backVO = new BackGroundVO();
			StringBuffer keyword = new StringBuffer();
			//한글 영어로 변환 결과 변수
			String result = "";
			//배경 정보 추출 시 체크 변수
			String bgck = "";
			String[] ary = part.getText().split("</p>");
			
			log.info("p태그 수 : "+ary.length);
			
			for(int i = 0; i < ary.length; i++) {
				ary[i] = ary[i].replace("<p>", "");
				ary[i] = ary[i].replace("&nbsp;", "");
				ary[i] = ary[i].replace("&lt;", "");
				ary[i] = ary[i].replace("&gt;", "");
				ary[i] = ary[i].replace("<br>", "");
			}
			
			log.info("총 페이지 수 : "+(ary.length / 15 + 1));
			
			// 15개씩 자르고 페이지 만들기
			for(int i = 0; i < (ary.length / 15) ; i++) {
				
				log.info(i+"번째 페이지 작성중");
				for(int j = i * 15 ; j < (i+1)*15 ; j++){
					result += ary[j];
				}
				
				log.info(i+"번째 페이지 값 : "+result);
				//api 요청 보내고 해당 정보를 db에 저장 (감정 정보 저장)
				try {
					result = TranslateText.translateText(result);
					log.info("영어로 변환 : "+result);
					emotion = ibm.Targetemotion(result);
					System.out.println(i+"번째 페이지 감정 : "+emotion.getDocument().getEmotion());
					
					emotionVO.setAnger(emotion.getDocument().getEmotion().getAnger().toString());
					emotionVO.setDisgust(emotion.getDocument().getEmotion().getDisgust().toString());
					emotionVO.setFear(emotion.getDocument().getEmotion().getFear().toString());
					emotionVO.setJoy(emotion.getDocument().getEmotion().getJoy().toString());
					emotionVO.setSadness(emotion.getDocument().getEmotion().getSadness().toString());
					//페이지 넘버 저장
					emotionVO.setPagenumber(i);
					
					//북파트 정보 저장 필요
					emotionVO.setEmotion_bookpartnumber(key);
					
					//
					
					edao.insertEmotion(emotionVO);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//배경 키워드 추출
				backemotion = ibm.textAnalyze(result);
				//타입들을 체크 (사람이나, 수치, 수량을 나타내는 단어들 bgck에저장)
				for(int k = 0; k < backemotion.getEntities().size(); k++) {
					
					if(backemotion.getEntities().get(k).getType().equals("Person") ||
						backemotion.getEntities().get(k).getType().equals("Quantity")) {
						
						bgck += backemotion.getEntities().get(k).getText();
						
					}
				}
				//해당 키워드가 위 포문에서 나왔는지 확인 후 db에 페이지 정보와 같이 저장
				for(int k = 0 ; k < backemotion.getKeywords().size(); k++) {
					
					//위에서 받은 사람 이름이나 시간을 걸러낸다.
					if( bgck.indexOf(backemotion.getKeywords().get(k).getText()) == -1) {
						
						//특정 단어들이 나오면 거른다 people time 등등
						if(backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("people") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("time") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("woman") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("word") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("friend") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("man") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("corner") == -1 &&
							backemotion.getKeywords().get(k).getText().toLowerCase().indexOf("guy") == -1
							) {
							
							//키워드 저장
							keyword.append(backemotion.getKeywords().get(k).getText()+"\\");
						}
						
					}
				}
				//북파트 넘버 저장 로직 필요
				backVO.setBackground_bookpartnumber(key);
				//키워드 종합해서 저장
				backVO.setKeyword(keyword.toString());
				//페이지 저장
				backVO.setPagenumber(i);
				//db에 저장
				bdao.insertKeyword(backVO);
				
				
				//초기화 로직
				result = "";
				backVO = null;
				emotionVO = null;
				backVO = new BackGroundVO();
				emotionVO = new EmotionVO();
				keyword.setLength(0);
			}
			
			
			// 나머지 페이지 처리 for문 (이곳에 배경 정보도 넣을지 추후에 결정)
			log.info("마지막 페이지 작성중");
			for(int i = 0; i < ary.length % 15; i++) {
				result += ary[i+((ary.length / 15 )* 15)];
			}
			//api 요청 보내고 해당 정보를 db에 저장
			log.info("마지막 페이지 값 : "+result);
			try {
				result = TranslateText.translateText(result);
				log.info("영어로 변환 : "+result);
				emotion = ibm.Targetemotion(result);
				System.out.println("마지막 페이지 감정 : "+emotion.getDocument().getEmotion());
				emotionVO.setAnger(emotion.getDocument().getEmotion().getAnger().toString());
				emotionVO.setDisgust(emotion.getDocument().getEmotion().getDisgust().toString());
				emotionVO.setFear(emotion.getDocument().getEmotion().getFear().toString());
				emotionVO.setJoy(emotion.getDocument().getEmotion().getJoy().toString());
				emotionVO.setSadness(emotion.getDocument().getEmotion().getSadness().toString());
				emotionVO.setPagenumber(ary.length / 15);
				emotionVO.setEmotion_bookpartnumber(key);
				
				edao.insertEmotion(emotionVO);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				emotionVO = null;
			
		}
		
		return "redirect:books?booknumber="+dbpart.getPart_booknumber()+"";
	}
	
}
