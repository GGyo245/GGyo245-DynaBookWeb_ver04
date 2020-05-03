package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.co.novelweb.VO.DynaBookVO;

public interface DynaBookMapper {

	public ArrayList<DynaBookVO> selectNewBookFromGenre(String genre);

	public DynaBookVO selectBookOne(int booknumber);

	public ArrayList<HashMap<String, Object>> selectBooksFromTitle(Map<String, String> params);

	public int insertDynabook(DynaBookVO book);

	public ArrayList<DynaBookVO> selectBookFromUser(int usernumber);

	public ArrayList<HashMap<String, Object>> selectPopularBooksFromGenre(String genre);

	public int updateDynaBook(DynaBookVO book);

}
