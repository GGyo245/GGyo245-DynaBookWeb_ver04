package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.DynaBookVO;

@Repository
public class DynaBookDAO {
	
	@Autowired SqlSession session;
	
	public ArrayList<DynaBookVO> selectNewBookFromGenre(String genre) {
		// TODO Auto-generated method stub
		ArrayList<DynaBookVO> book = null;
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			book = mapper.selectNewBookFromGenre(genre);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return book;
	}

	public DynaBookVO selectBookOne(int booknumber) {
		// TODO Auto-generated method stub
		DynaBookVO book = null;
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			book = mapper.selectBookOne(booknumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return book;
	}

	public ArrayList<HashMap<String, Object>> selectBooksFromTitle(Map<String, String> params) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, Object>> book = null;
		
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			book = mapper.selectBooksFromTitle(params);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return book;
	}
	
	public int insertDynabook(DynaBookVO book) {
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			mapper.insertDynabook(book);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return book.getBooknumber();
	}

	public ArrayList<DynaBookVO> selectBookFromUser(int usernumber) {
		// TODO Auto-generated method stub
		ArrayList<DynaBookVO> book = null;
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			book = mapper.selectBookFromUser(usernumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return book;
	}

	public ArrayList<HashMap<String, Object>> selectPopularBooksFromGenre(String genre) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, Object>> books = null;
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			books = mapper.selectPopularBooksFromGenre(genre);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return books;
	}

	public int updateDynaBook(DynaBookVO book) {
		// TODO Auto-generated method stub
		int flag = 0;
		try {
			DynaBookMapper mapper = session.getMapper(DynaBookMapper.class);
			flag = mapper.updateDynaBook(book);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}

	
}	
