package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.bookmarkVO;

@Repository
public class BookmarkDAO {
	@Autowired
	SqlSession session;
	
	
	public int likeUp(bookmarkVO bookmark) {
		int result = 0;
		
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			result = mapper.likeUp(bookmark);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public int likeDel(bookmarkVO bookmark) {
		int result = 0;
		
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			result = mapper.likeDel(bookmark);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public bookmarkVO getBookmark(bookmarkVO bookmark) {
		bookmarkVO vo = new bookmarkVO();
		
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			vo = mapper.getBookmark(bookmark);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}


	public ArrayList<HashMap<String, Object>> selectBookMark(int usernumber) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, Object>> bookmark = null;
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			bookmark = mapper.selectBookMark(usernumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return bookmark;
	}
	
}
