package kr.co.novelweb.DAO;

import kr.co.novelweb.VO.BackGroundVO;

public interface BackGroundMapper {

	public void insertKeyword(BackGroundVO backVO);

	public String selectKeywords(BackGroundVO back);

	public int updateKeyword(BackGroundVO back);

	public void deleteBackGround(int bookpartnumber);

}
