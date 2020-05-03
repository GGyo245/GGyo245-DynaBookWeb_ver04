package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.novelweb.VO.PurchaseVO;

@Repository
public class PurchaseDAO {
	
	@Autowired SqlSession session;
	
	public void insertPurchase(PurchaseVO purchase) {
		// TODO Auto-generated method stub
		try {
			PurchaseMapper mapper = session.getMapper(PurchaseMapper.class);
			mapper.insertPurchase(purchase);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}

	public ArrayList<PurchaseVO> slectPurchase(int usernumber) {
		// TODO Auto-generated method stub
		ArrayList<PurchaseVO> purchase = null;
		try {
			PurchaseMapper mapper = session.getMapper(PurchaseMapper.class);
			purchase = mapper.slectPurchase(usernumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return purchase;
	}

	public ArrayList<HashMap<String, Object>> slectPurchaseHash(int usernumber) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, Object>> purchase = null;
		try {
			PurchaseMapper mapper = session.getMapper(PurchaseMapper.class);
			purchase = mapper.slectPurchaseHash(usernumber);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return purchase;
	}

}
