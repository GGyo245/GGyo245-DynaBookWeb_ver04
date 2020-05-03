package kr.co.novelweb.Controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.novelweb.DAO.BookPartDAO;
import kr.co.novelweb.DAO.DynaBookDAO;
import kr.co.novelweb.DAO.DynaBookUserDAO;
import kr.co.novelweb.DAO.PurchaseDAO;
import kr.co.novelweb.VO.BookPartVO;
import kr.co.novelweb.VO.DynaBookUserVO;
import kr.co.novelweb.VO.DynaBookVO;
import kr.co.novelweb.VO.PurchaseVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BooksController {
	
	@Autowired
	DynaBookDAO Bdao;
	@Autowired
	BookPartDAO BPdao;
	@Autowired
	DynaBookUserDAO Udao;
	@Autowired
	PurchaseDAO Pdao;
	
	private PurchaseVO purchase = new PurchaseVO();
	
	@GetMapping("/books")
	public String books(int booknumber, Model model, HttpSession session) {
		
		log.info("요청받은 책 :"+booknumber);
		log.info("move to books!");
		
		String email = (String)session.getAttribute("loginId");
		
		DynaBookVO book = Bdao.selectBookOne(booknumber);
		ArrayList<BookPartVO> bookpart = BPdao.selectBookPart(booknumber);
		DynaBookUserVO writer = Udao.selectUserOneFromNumber(book.getBook_usernumber());
		
		if(email != null) {
			DynaBookUserVO user = Udao.selectUserOne(email);
			ArrayList<PurchaseVO> pur = Pdao.slectPurchase(user.getUsernumber());
			model.addAttribute("user", user);
			model.addAttribute("pur", pur);
		}
				
		model.addAttribute("book", book);
		model.addAttribute("bookpart", bookpart);
		model.addAttribute("writer", writer);
		
		  
		return "books";
	}
	
	@RequestMapping(value="/purchaseBook", method = RequestMethod.POST)
	public String purchaseBook(int booknumber, int[] partnumber, int price, HttpSession session, Model model) {
		
		log.info("purchaseBook");
		log.info("구매총액 : "+price+"원 입니다.");
		String email = (String)session.getAttribute("loginId");
		String error = "";
		
		if(email == null) {
			error = "로그인이 필요합니다.";
			model.addAttribute("err", error);
			return "redirect:books?booknumber="+booknumber+"";
		}
		
		DynaBookUserVO userdb = Udao.selectUserOne(email);
		if(userdb.getAccount_balance() < price) {
			error = "소지금이 부족합니다!";
			model.addAttribute("err", error);
			log.info("소지금 부족!");
			return "redirect:books?booknumber="+booknumber+"";
		}else {
			//유저의 구매목록
			ArrayList<PurchaseVO> pur = Pdao.slectPurchase(userdb.getUsernumber());
			
			
			//구매하려는 유저의 db속에 구입한 책들을 검사
			purchase.setPurchase_usernumber(userdb.getUsernumber());
			for(int i = 0; i < partnumber.length; i++) {
				
				for(int j = 0; j < pur.size(); j++) {
					if(partnumber[i] == pur.get(j).getPurchase_bookpartnumber()) {
						error = "이미 구매한 책이 있습니다!";
						model.addAttribute("err", error);
						log.info("구매 한 책이 존재!");
						return "redirect:books?booknumber="+booknumber+"";
					}
				}
			}
			
			//계산
			int newAccount = userdb.getAccount_balance() - price;
			userdb.setAccount_balance(newAccount);
			Udao.updateAccount_balance(userdb);
			
			//위에서 구매한 책들이 있는지 검사하고 insert
			for(int i = 0; i < partnumber.length; i++) {
				purchase.setPurchase_bookpartnumber(partnumber[i]);
				Pdao.insertPurchase(purchase);
			}
			
			//리다이렉트로 mylist 구매로 이동
			return "redirect:/user/mylist";
		}
		
	}
	
}
