package kr.co.novelweb.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.BookPartVO;

@Repository
public class BookPartDAO {
	
	@Autowired
	SqlSession session;

	public BookPartVO selectBookPartOne(int bookpartnumber) {
		// TODO Auto-generated method stub
		BookPartVO book = null;
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			book = mapper.selectBookPartOne(bookpartnumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return book;
	}

	public ArrayList<BookPartVO> selectBookPart(int selectBookPart) {
		// TODO Auto-generated method stub
		ArrayList<BookPartVO> bookpart = null;
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			bookpart = mapper.selectBookPart(selectBookPart);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return bookpart;
	}
	
	public BookPartVO selectForEpi(BookPartVO vo) {
		System.out.println("dao쪽 vo : " + vo);
		BookPartVO resultVO = new BookPartVO();
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			resultVO = mapper.selectForEpi(vo);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultVO;
	}
	
	public int searchLastPart(int part_booknumber) {
		int result = 0;
		
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			result = mapper.searchLastPart(part_booknumber);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int insertDynaBookpart(BookPartVO part) {	
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			mapper.insertDynaBookpart(part);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return part.getBookpartnumber();
	}
	
	public void bookPartPlusHits(BookPartVO vo) {
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			mapper.bookPartPlusHits(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int updateDynaBookpart(BookPartVO part) {
		// TODO Auto-generated method stub
		int flag = 0;
		try {
			BookPartMapper mapper = session.getMapper(BookPartMapper.class);
			flag = mapper.updateDynaBookpart(part);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
}
