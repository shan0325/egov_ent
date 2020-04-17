package egovframework.com.cmm.security;


import org.springframework.security.authentication.encoding.PasswordEncoder;

import egovframework.let.utl.sim.service.EgovFileScrty;

public class CustomPasswordEncoder implements PasswordEncoder {

	@Override
	public String encodePassword(String rawPass, Object salt) {
		byte[] salts = null;
		try {
			if(salt != null) {
				salts = salt.toString().getBytes();
			}
			return EgovFileScrty.encryptPassword(rawPass, salts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
		try {
			return EgovFileScrty.checkPassword(rawPass, encPass, salt.toString().getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
