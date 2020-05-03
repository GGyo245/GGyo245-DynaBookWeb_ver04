package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.novelweb.VO.bookmarkVO;

public interface BookmarkMapper {
	
	
	public int likeUp(bookmarkVO bookmark);
	
	public int likeDel(bookmarkVO bookmark);
	
	public bookmarkVO getBookmark(bookmarkVO bookmark);
	
	public ArrayList<HashMap<String, Object>> selectBookMark(int usernumber);
	
}
