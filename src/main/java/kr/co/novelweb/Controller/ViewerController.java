package kr.co.novelweb.Controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.novelweb.service.PageNavigator;

import kr.co.novelweb.DAO.BackGroundDAO;
import kr.co.novelweb.DAO.BookPartDAO;
import kr.co.novelweb.DAO.BookmarkDAO;
import kr.co.novelweb.DAO.DynaBookCommentDAO;
import kr.co.novelweb.DAO.DynaBookDAO;
import kr.co.novelweb.DAO.DynaBookUserDAO;
import kr.co.novelweb.DAO.EmotionDAO;
import kr.co.novelweb.VO.BackGroundVO;
import kr.co.novelweb.VO.BookPartVO;
import kr.co.novelweb.VO.DynaBookCommentVO;
import kr.co.novelweb.VO.DynaBookUserVO;
import kr.co.novelweb.VO.DynaBookVO;
import kr.co.novelweb.VO.EmotionVO;
import kr.co.novelweb.VO.bookmarkVO;
import kr.co.novelweb.service.ImgeSaveService;
import kr.co.novelweb.service.JsonReader;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ViewerController {
	//paging 처리
	private final int countPerPage=5;
	private final int pagePerGroup = 5;
	
	@Autowired
	DynaBookUserDAO Userdao;
	@Autowired
	BookPartDAO BPdao;
	@Autowired
	BookmarkDAO BMdao;
	@Autowired
	DynaBookDAO DBdao;
	@Autowired
	BackGroundDAO BGdao;
	@Autowired
	EmotionDAO EMdao;
	@Autowired
	DynaBookCommentDAO CMdao;
	
	@ResponseBody
	@RequestMapping(value="likeFunction", method=RequestMethod.POST)
	public int likeFunction(bookmarkVO bookmark, HttpSession session) {
		log.info("move to likeFunction!");
		
		int result = 0;
		
		DynaBookUserVO vo = Userdao.selectUserOne((String)session.getAttribute("loginId"));
		System.out.println(vo);
		int userNumber = vo.getUsernumber();
		System.out.println(userNumber);
		bookmark.setBookmark_userNumber(userNumber);
		System.out.println(bookmark);
		
		result = BMdao.likeUp(bookmark);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="unlikeFunction", method=RequestMethod.POST)
	public int unlikeFunction(bookmarkVO bookmark, HttpSession session) {
		int result = 0;
		DynaBookUserVO vo = Userdao.selectUserOne((String)session.getAttribute("loginId"));
		bookmark.setBookmark_userNumber(vo.getUsernumber());
		result = BMdao.likeDel(bookmark);
		
		return result;
	}
	
	@RequestMapping(value="nextPart", method=RequestMethod.GET)
	public String nextPart(BookPartVO vo, Model model) {
		log.info("move to nextPart!");
		
		vo.setEpisode(vo.getEpisode()+1);
		System.out.println("vo : " + vo);
		
		
		
		BookPartVO newVO = BPdao.selectForEpi(vo);
		System.out.println("newVO : " + newVO);
		DynaBookVO book = DBdao.selectBookOne(newVO.getPart_booknumber());
		
		model.addAttribute("bookpart", newVO);
		model.addAttribute("book", book);
		
		return "viewer";
	}
	
	
	@RequestMapping(value="prePart", method=RequestMethod.GET)
	public String prePart(BookPartVO vo, Model model) {
		log.info("move to prePart!");
		
		vo.setEpisode(vo.getEpisode()-1);
		System.out.println("vo : " + vo);
		
		
		
		BookPartVO newVO = BPdao.selectForEpi(vo);
		System.out.println("newVO : " + newVO);
		DynaBookVO book = DBdao.selectBookOne(newVO.getPart_booknumber());
		
		model.addAttribute("bookpart", newVO);
		model.addAttribute("book", book);
		
		return "viewer";
	}
	
	@ResponseBody
	@RequestMapping(value="searchLastPart", method=RequestMethod.POST)
	public int searchLastPart(int part_booknumber) {
		int result = 0;
		result = BPdao.searchLastPart(part_booknumber);
		
		return result;
	}
	
	@GetMapping("/viewer")
	public String viewer(Model model, HttpSession session, BookPartVO vo) {
		
		log.info("move to viewer!");
		
		System.out.println(vo);
		DynaBookVO book = DBdao.selectBookOne(vo.getPart_booknumber());
		BookPartVO bookpart = BPdao.selectBookPartOne(vo.getBookpartnumber());
		DynaBookUserVO user = Userdao.selectUserOne((String)session.getAttribute("loginId"));
		bookmarkVO bookmark_param = new bookmarkVO();
		bookmark_param.setBookmark_userNumber(user.getUsernumber());
		bookmark_param.setBookmark_bookPartNumber(bookpart.getBookpartnumber());
		
		bookmarkVO bookmark = BMdao.getBookmark(bookmark_param);
		System.out.println(bookmark);
		
		
		if(bookmark == null) {
			bookmark = new bookmarkVO();
			System.out.println("if문 안 vo" + bookmark);
			model.addAttribute("bookmark", bookmark);
		}else {
			System.out.println("else문 안 vo" + bookmark);
			model.addAttribute("bookmark", bookmark);
		}
		
		ArrayList<HashMap<String, Object>> comment = CMdao.getCommentByHits(bookpart.getBookpartnumber());
		BPdao.bookPartPlusHits(bookpart);
		
		System.out.println("book : " + book );
		model.addAttribute("comment", comment);
		model.addAttribute("book", book);
		model.addAttribute("bookpart", bookpart);
		
		return "viewer";
	}
	
	@RequestMapping(value="moveComment", method=RequestMethod.GET)
	public String moveComment(@RequestParam(value="currentPage", defaultValue = "1") int currentPage
							  , Model model
							  , BookPartVO vo) {
		int bookpartnumber = vo.getBookpartnumber();
		int booknumber = vo.getPart_booknumber();
		System.out.println( "booknumber : " + booknumber);
		
		int totalCount = CMdao.getCommentCount(bookpartnumber);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalCount);
		int startRecord = navi.getStartRecord();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("comment_bookpartnumber", bookpartnumber);
		ArrayList<HashMap<String, Object>> comment_list = CMdao.getComment(map,startRecord ,countPerPage);
		
		if(comment_list.size()==0 || comment_list == null) {
			model.addAttribute("comment", null);
		}else {
			model.addAttribute("comment", comment_list);
		}
		model.addAttribute("navi", navi);
		model.addAttribute("bookpartnumber", vo.getBookpartnumber() );
		model.addAttribute("part_booknumber", vo.getPart_booknumber());
		model.addAttribute("count", totalCount);
		return "comment";
	}
	
	@RequestMapping(value="insertCommentForm", method=RequestMethod.GET)
	public String insertCommentForm(Model model, int bookpartnumber) {
		
		
		model.addAttribute("bookpartnumber", bookpartnumber);
		
		
		return "insertCommentForm";
	}
	
	@RequestMapping(value="insertComment", method=RequestMethod.GET)
	public String insertComment(RedirectAttributes redirect, DynaBookCommentVO comment, HttpSession session) {
		
		DynaBookUserVO user = Userdao.selectUserOne((String)session.getAttribute("loginId"));
		comment.setComment_usernumber(user.getUsernumber());
		
		CMdao.insertComment(comment);
		
		redirect.addAttribute("bookpartnumber", comment.getComment_bookpartnumber());
		return "redirect:moveComment";
	}
	
	@RequestMapping(value="commentDelete", method=RequestMethod.GET)
	public String commentDelete(RedirectAttributes redirect,int commentnumber, int part_booknumber, int bookpartnumber) {
		CMdao.commentDelete(commentnumber);
		
		redirect.addAttribute("part_booknumber", part_booknumber );
		redirect.addAttribute("bookpartnumber", bookpartnumber);
		return "redirect:moveComment";
	}
	
	
	@RequestMapping(value="updateCommentForm", method=RequestMethod.GET)
	public String updateCommentForm(Model model, DynaBookCommentVO comment, BookPartVO bookpart) {
		
		model.addAttribute("comment", comment);
		model.addAttribute("bookpart" , bookpart);
		return "updateCommentForm";
	}
	
	@RequestMapping(value="updateComment", method=RequestMethod.GET)
	public String updateComment(RedirectAttributes redirect, DynaBookCommentVO comment, BookPartVO bookpart) {
		
		CMdao.updateComment(comment);
		
		redirect.addAttribute("part_booknumber", bookpart.getPart_booknumber() );
		redirect.addAttribute("bookpartnumber", bookpart.getBookpartnumber());
		
		
		return "redirect:moveComment";
	}
	
	
	@ResponseBody
	@RequestMapping(value="hitsFunction", method=RequestMethod.POST)
	public int hitsFunction(int commentnumber) {
		
		DynaBookCommentVO vo = CMdao.getCommentOne(commentnumber);
		CMdao.plusHits(vo);
		
		int result = vo.getHits()+1;
		
		
		return result;
	}
	

	
	@ResponseBody
	@RequestMapping(value="getMusic", method=RequestMethod.POST)
	public String getMusic(EmotionVO vo, String genre) {
		System.out.println("이모션 vo : " + vo);
		String result="";
		log.info("받아온 vo"+vo.getEmotion_bookpartnumber());
		EmotionVO emotion = EMdao.getEmotion(vo);
		String emo;
		String val;
		float anger = Float.parseFloat(emotion.getAnger());
		float sadness = Float.parseFloat(emotion.getSadness());
		float disgust = Float.parseFloat(emotion.getDisgust());
		float joy = Float.parseFloat(emotion.getJoy());
		float fear = Float.parseFloat(emotion.getFear());
		
		float[] arr = {anger, sadness, disgust, joy, fear};
		float max = 0;
		for (int i = 0; i < arr.length ; i++) {
			if(max<arr[i]) {
				max = arr[i];
			}
		}
		
		if(max == anger){
			emo = "anger";
		}else if(max == sadness) {
			emo = "sad";
		}else if(max == disgust) {
			emo = "disgusting";
		}else if(max == joy) {
			emo = "joy";
		}else {
			emo = "fear";
		}
		
		if(max<0.5) {
			val = "1";
		}else if(max<0.6) {
			val = "2";
			
		}else if(max<0.7) {
			val="3";
		}else if(max<0.8) {
			val="4";
		}else {
			val="5";
		}
		
		result = "resources/" + genre + "/" + emo + "/" + emo + "" + val + ".mp3" ;
		
		
		return result;
	}
	
	@RequestMapping(value="/getBackground", method=RequestMethod.POST)
	@ResponseBody
	public String getBackground(BackGroundVO back) {
		
		String keywords = BGdao.selectKeywords(back);
		File dbfile = new File("C:\\Users\\user\\git\\DynaBookWeb_ver03\\src\\main\\webapp\\resources\\js\\img\\"+keywords+".jpg");
		boolean dbflag = false;
		log.info("search to "+keywords);
		
		//널 여부 판단
		if(keywords == null) {
			log.info("keywords is null! return null");
			return "basic";
		}
		
		// 파일 존재 여부 판단
	    if (dbfile.isFile()) {
	      log.info("File is not Empty");
	      dbflag = false;
	    }
	    else {
	      log.info("File is Empty");
	      dbflag = true;
	    }
	    if(dbflag) {
	    	boolean flag = false;
			String result = "";
			String answer = "";
			int count = 0;
			int max = 0;
			String now = "";
			String keyword = "";
			StringBuffer sample = new StringBuffer();
			log.info("db에서 가저온 keywrds : "+keywords);
			
			StringTokenizer tokens = new StringTokenizer(keywords,"\\");
			for(int i = 0; tokens.hasMoreElements(); i++) {
				
				sample.append(tokens.nextToken().trim().replace(" ", ""));
				answer = JsonReader.callURL(sample.toString());
				
				now = answer.substring(answer.indexOf("total")+7, answer.indexOf(","));
				
				if(Integer.parseInt(now.trim()) > max) {
					max = Integer.parseInt(now);
					keyword = sample.toString();
					result = answer;
				}
				//버퍼 초기화
				sample.setLength(0);
			}
			/*
			System.out.println("결과 값 : " + result);
			System.out.println("키워드 값 : " + keyword);
			System.out.println("다운로드 url : " + result.substring(result.indexOf("download")+11, result.indexOf("/download")+9));
			*/
			//해당 페이지, 해당 북파트의 키워드 수정
			log.info("update Keyword : "+keyword);
			back.setKeyword(keyword);
			count = BGdao.updateKeyword(back);
			
			//파일 존재 여부 체크위한 뷰 생성
			File f = new File("C:\\Users\\user\\git\\DynaBookWeb_ver03\\src\\main\\webapp\\resources\\js\\img\\"+keyword+".jpg");

		    // 파일 존재 여부 판단
		    if (f.isFile()) {
		      log.info("File is not Empty");
		      flag = false;
		    }
		    else {
		      log.info("File is Empty");
		      flag = true;
		    }
		    //없는 파일일 시 저장
			if(flag) {
				try {
					ImgeSaveService.saveImage(result.substring(result.indexOf("download")+11, result.indexOf("/download")+9), keyword);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					log.info("이미지 저장에 실패하였습니다.");
				}
			}
			return keyword;
	    }else {
	    	return keywords;
	    }
	}
	
}
