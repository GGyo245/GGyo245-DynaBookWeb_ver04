package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import kr.co.novelweb.VO.DynaBookCommentVO;

public interface DynaBookCommentMapper {

	public ArrayList<HashMap<String, Object>> getComment(HashMap<String, Object> map, RowBounds rb);
	public int getCommentCount(int bookpartnumber);
	public ArrayList<HashMap<String, Object>> getCommentByHits(int bookpartnumber, RowBounds rb);
	public DynaBookCommentVO getCommentOne(int commentnumber);
	public void plusHits(DynaBookCommentVO vo);
	public void insertComment(DynaBookCommentVO vo);
	public void commentDelete(int commentnumber);
	public void updateComment(DynaBookCommentVO vo);
}
