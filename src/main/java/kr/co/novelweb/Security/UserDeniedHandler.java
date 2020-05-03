package kr.co.novelweb.Security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserDeniedHandler implements AccessDeniedHandler{

	@Override
	public void handle(HttpServletRequest req, HttpServletResponse res,
			AccessDeniedException ade) throws IOException, ServletException {
		// TODO Auto-generated method stub
		 log.info("Exceiption : {}",ade);
		 log.info("LocalizedMessage : {}",ade.getLocalizedMessage());
		 log.info("Message : {}",ade.getMessage());
		 log.info("StackTrace : {}",ade.getStackTrace());
		  
		 req.setAttribute("errMsg",ade.getMessage());
		 req.getRequestDispatcher("/WEB-INF/views/userAccessDenied.jsp").forward(req, res);

	}

}
