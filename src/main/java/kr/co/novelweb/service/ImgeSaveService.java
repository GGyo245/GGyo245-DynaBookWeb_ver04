package kr.co.novelweb.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

public class ImgeSaveService {
	
	public static void saveImage(String strUrl, String filename) throws IOException {
			 
        URL url = null;
        InputStream in = null;
        OutputStream out = null;
 
        try {
            url = new URL(strUrl);
            in = url.openStream();
            out = new FileOutputStream("C:/Users/user/git/DynaBookWeb_ver03/src/main/webapp/resources/js/img/"+filename+".jpg"); //해당 서버경로
 
            while(true){
                //이미지를 읽어온다.
                int data = in.read();
                if(data == -1){
                    break;
                }
                //이미지를 쓴다.
                out.write(data);
            }
            in.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(in != null){in.close();}
            if(out != null){out.close();}
        }
    }
		
};
