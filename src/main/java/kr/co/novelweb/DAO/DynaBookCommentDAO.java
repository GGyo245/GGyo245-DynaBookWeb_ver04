package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.DynaBookCommentVO;
@Repository
public class DynaBookCommentDAO {

	@Autowired
	SqlSession session;
	
	public ArrayList<HashMap<String, Object>> getComment(HashMap<String, Object> map, int startRecord, int countPerPage){
		ArrayList<HashMap<String, Object>> result = null;
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		try {
			DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
			result = mapper.getComment(map, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int getCommentCount(int bookpartnumber) {
		int result=0;
		
		try {
			DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
			result = mapper.getCommentCount(bookpartnumber);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public ArrayList<HashMap<String, Object>> getCommentByHits(int bookpartnumber){
		ArrayList<HashMap<String, Object>> result = null;
		RowBounds rb = new RowBounds(0, 5);
		try {
			DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
			result = mapper.getCommentByHits(bookpartnumber, rb);
			} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}
	
	public DynaBookCommentVO getCommentOne(int commentnumber) {
		DynaBookCommentVO result = null;
		try {
			DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
			result = mapper.getCommentOne(commentnumber);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public void plusHits(DynaBookCommentVO vo) {
		try {
			DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
			mapper.plusHits(vo);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void insertComment(DynaBookCommentVO vo) {
		try {
			DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
			mapper.insertComment(vo);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void commentDelete(int commentnumber) {
	      try {
	         DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
	         mapper.commentDelete(commentnumber);
	      }catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	
	public void updateComment(DynaBookCommentVO vo) {
		 try {
	         DynaBookCommentMapper mapper = session.getMapper(DynaBookCommentMapper.class);
	         mapper.updateComment(vo);
	      }catch (Exception e) {
	         e.printStackTrace();
	      }
	}
}
