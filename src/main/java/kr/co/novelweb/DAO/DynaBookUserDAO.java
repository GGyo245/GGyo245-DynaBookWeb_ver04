package kr.co.novelweb.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.DynaBookUserVO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class DynaBookUserDAO {
	
	@Autowired 
	SqlSession session;

	public int insertUser(DynaBookUserVO user) {
		// TODO Auto-generated method stub
		int fg = 0;
		
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			fg = mapper.insertUser(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return fg;
	}

	public DynaBookUserVO selectUserOne(String email) {
		// TODO Auto-generated method stub
		DynaBookUserVO userdb = null;
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			userdb = mapper.selectUserOne(email);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return userdb;
	}

	public int updateNick(DynaBookUserVO user) {
		// TODO Auto-generated method stub
		int count = 0;
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			count = mapper.updateNick(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return count;
	}

	public int updatePW(DynaBookUserVO user) {
		// TODO Auto-generated method stub
		int count = 0;
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			count = mapper.updatePW(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return count;
	}

	public DynaBookUserVO selectUserOneFromNumber(int book_usernumber) {
		// TODO Auto-generated method stub
		DynaBookUserVO userdb = null;
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			userdb = mapper.selectUserOneFromNumber(book_usernumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return userdb;
	}

	public void updateAccount_balance(DynaBookUserVO userdb) {
		// TODO Auto-generated method stub
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			mapper.updateAccount_balance(userdb);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public int deleteUser(int usernumber) {
		// TODO Auto-generated method stub
		int flag = 0;
		try {
			DynaBookUserMapper mapper = session.getMapper(DynaBookUserMapper.class);
			flag = mapper.deleteUser(usernumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
}
	
