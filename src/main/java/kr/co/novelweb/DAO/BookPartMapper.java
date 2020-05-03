package kr.co.novelweb.DAO;

import java.util.ArrayList;

import kr.co.novelweb.VO.BookPartVO;

public interface BookPartMapper {

	public BookPartVO selectBookPartOne(int bookpartnumber);

	public ArrayList<BookPartVO> selectBookPart(int selectBookPart);
	
	public BookPartVO selectForEpi(BookPartVO vo);
	
	public int searchLastPart(int part_booknumber);

	public int insertDynaBookpart(BookPartVO part);

	public void bookPartPlusHits(BookPartVO vo);

	public int updateDynaBookpart(BookPartVO part);
	
}
