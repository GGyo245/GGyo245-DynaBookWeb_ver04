package kr.co.novelweb.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.novelweb.VO.PurchaseVO;

public interface PurchaseMapper {

	public void insertPurchase(PurchaseVO purchase);

	public ArrayList<PurchaseVO> slectPurchase(int usernumber);

	public ArrayList<HashMap<String, Object>> slectPurchaseHash(int usernumber);

}
