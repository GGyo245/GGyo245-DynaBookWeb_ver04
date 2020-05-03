package kr.co.novelweb.VO;

import lombok.Data;

@Data
public class DynaBookVO {
	int booknumber;
    String title;
    String penname;
    String subtitle;
    String bookdate;
    String genre;
    String introduce;
    int book_usernumber;
}
