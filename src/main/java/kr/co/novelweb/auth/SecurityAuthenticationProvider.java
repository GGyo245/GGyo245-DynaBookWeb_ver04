/**
 * 
 */
package kr.co.novelweb.auth;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import kr.co.novelweb.DAO.DynaBookUserMapper;
import kr.co.novelweb.VO.DynaBookUserVO;

@Component
public class SecurityAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(SecurityAuthenticationProvider.class);
	
	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		WebApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
		
		sqlSession = (SqlSession) ctx.getBean("sqlSession");
		
		List<GrantedAuthority> roles = new ArrayList<>();
		
		String user_id = (String)authentication.getPrincipal();
		String user_pw	= (String)authentication.getCredentials();
		
		DynaBookUserMapper mapper = sqlSession.getMapper(DynaBookUserMapper.class);
		
		DynaBookUserVO userInfo = new DynaBookUserVO();
		userInfo.setEmail(user_id);
		
		DynaBookUserVO user = mapper.selectUserOne(userInfo.getEmail());
		
		logger.info("일치하는 ID를 확인합니다.");
		if(user != null) {
			
			//탈퇴한계정 확인
			if(user.getAuthority().equals("delete")) {
				logger.info("탈퇴한 계정");
				throw new BadCredentialsException("탈퇴한 계정입니다.", new BadCredentialsException("계정 오류"));
			}
			
			//회원 비밀번호 체크
			if(!(user_pw.equals(user.getPw()))){
				logger.info("사용자 비밀번호가 틀립니다.");
				throw new BadCredentialsException("이메일 또는 비밀번호를 다시 확인해주세요.", new BadCredentialsException("비밀번호 오류"));
			}else{
				//회원 권한 부여
				
				roles.add(new SimpleGrantedAuthority("ROLE_"+user.getAuthority()));
				UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);
				result.setDetails(user);
				return result;
			}
			
		}else {
			logger.info("DB에 존재하지 않는 ID");
			throw new BadCredentialsException("이메일 또는 비밀번호를 다시 확인해주세요.", new BadCredentialsException("ID 오류"));
		}
		
	}
}
