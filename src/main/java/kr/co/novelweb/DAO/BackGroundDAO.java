package kr.co.novelweb.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.BackGroundVO;

@Repository
public class BackGroundDAO {
	@Autowired
	SqlSession session;

	public void insertKeyword(BackGroundVO backVO) {
		// TODO Auto-generated method stub
		try {
			BackGroundMapper mapper = session.getMapper(BackGroundMapper.class);
			mapper.insertKeyword(backVO);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public String selectKeywords(BackGroundVO back) {
		// TODO Auto-generated method stub
		String keywords = "";
		try {
			BackGroundMapper mapper = session.getMapper(BackGroundMapper.class);
			keywords = mapper.selectKeywords(back);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return keywords;
	}

	public int updateKeyword(BackGroundVO back) {
		// TODO Auto-generated method stub
		int count = 0;
		try {
			BackGroundMapper mapper = session.getMapper(BackGroundMapper.class);
			count = mapper.updateKeyword(back);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return count;
	}

	public void deleteBackGround(int bookpartnumber) {
		// TODO Auto-generated method stub
		try {
			BackGroundMapper mapper = session.getMapper(BackGroundMapper.class);
			mapper.deleteBackGround(bookpartnumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	
}
