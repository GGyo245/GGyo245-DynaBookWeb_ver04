package kr.co.novelweb.VO;

import lombok.Data;

@Data
public class DynaBookCommentVO {

	private int commentnumber;
	private String usercomment;
	private int hits;
	private String commentdate;
	private int comment_bookpartnumber;
	private int comment_usernumber;
}
