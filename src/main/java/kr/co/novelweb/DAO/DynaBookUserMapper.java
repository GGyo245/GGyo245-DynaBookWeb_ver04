package kr.co.novelweb.DAO;

import kr.co.novelweb.VO.DynaBookUserVO;

public interface DynaBookUserMapper {

	public int insertUser(DynaBookUserVO user);

	public DynaBookUserVO selectUserOne(String email);

	public int updateNick(DynaBookUserVO user);

	public int updatePW(DynaBookUserVO user);

	public DynaBookUserVO selectUserOneFromNumber(int book_usernumber);

	public void updateAccount_balance(DynaBookUserVO userdb);

	public int deleteUser(int usernumber);
	
}
