package kr.co.novelweb.DAO;

import kr.co.novelweb.VO.EmotionVO;

public interface EmotionMapper {

	public void insertEmotion(EmotionVO emotionVO);

	public EmotionVO getEmotion(EmotionVO emotionVO);

	public void deleteEmotion(int bookpartnumber);

}
