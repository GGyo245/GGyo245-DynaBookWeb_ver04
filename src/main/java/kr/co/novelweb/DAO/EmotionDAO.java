package kr.co.novelweb.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.EmotionVO;

@Repository
public class EmotionDAO {
	
	@Autowired
	SqlSession session;

	public void insertEmotion(EmotionVO emotionVO) {
		// TODO Auto-generated method stub
		try {
			EmotionMapper mapper = session.getMapper(EmotionMapper.class);
			mapper.insertEmotion(emotionVO);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public EmotionVO getEmotion(EmotionVO emotionVO) {
		EmotionVO result=null;
		try {
			EmotionMapper mapper = session.getMapper(EmotionMapper.class);
			result = mapper.getEmotion(emotionVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public void deleteEmotion(int bookpartnumber) {
		// TODO Auto-generated method stub
		try {
			EmotionMapper mapper = session.getMapper(EmotionMapper.class);
			mapper.deleteEmotion(bookpartnumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
}
