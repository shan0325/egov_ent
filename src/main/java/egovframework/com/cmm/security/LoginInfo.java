package egovframework.com.cmm.security;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;


public class LoginInfo implements UserDetails {

private static final long serialVersionUID = -4086869747130410600L;
	
	private String username; 	 //회원 아이디
	
	private String name;		 //회원 이름
	
	private String password;	 //비밀번호
	
	private String admingrade;
	
	private String telno;
	
	private String email;
	
	private String ip;
	
	private String regdt;
	
	private String reguser;
		
	private String pwdmoddt;
	
	private String salt;
	
	private Set<GrantedAuthority> authorities;
	
	public LoginInfo(String username, String password, String name, Collection<? extends GrantedAuthority> authorities) {
		this.username = username;
		this.password = password;
		this.name = name;
		this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
	}
	
	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAdmingrade() {
		return admingrade;
	}

	public void setAdmingrade(String admingrade) {
		this.admingrade = admingrade;
	}

	public String getTelno() {
		return telno;
	}

	public void setTelno(String telno) {
		this.telno = telno;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getRegdt() {
		return regdt;
	}

	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}

	public String getReguser() {
		return reguser;
	}

	public void setReguser(String reguser) {
		this.reguser = reguser;
	}

	public String getPwdmoddt() {
		return pwdmoddt;
	}

	public void setPwdmoddt(String pwdmoddt) {
		this.pwdmoddt = pwdmoddt;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}
	
	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		
		this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
	}
	
	@Override
	public String getUsername() {
		return username;
	}
	
	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	private static SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities) {
        Assert.notNull(authorities, "Cannot pass a null GrantedAuthority collection");
        // Ensure array iteration order is predictable (as per UserDetails.getAuthorities() contract and SEC-717)
        SortedSet<GrantedAuthority> sortedAuthorities =
            new TreeSet<GrantedAuthority>(new AuthorityComparator());

        for (GrantedAuthority grantedAuthority : authorities) {
            Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
            sortedAuthorities.add(grantedAuthority);
        }

        return sortedAuthorities;
    }
	
	private static class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable {
        private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
        
        public int compare(GrantedAuthority g1, GrantedAuthority g2) {
            // Neither should ever be null as each entry is checked before adding it to the set.
            // If the authority is null, it is a custom authority and should precede others.
            if (g2.getAuthority() == null) {
                return -1;
            }

            if (g1.getAuthority() == null) {
                return 1;
            }

            return g1.getAuthority().compareTo(g2.getAuthority());
        }
    }
	
	@Override
	public int hashCode() {
		
		return (username != null ? username.hashCode() : 0);
	}
	
	@Override
	public boolean equals(Object obj) {
		if(!(obj instanceof LoginInfo)) {
			return false;
		}
		
		LoginInfo other = (LoginInfo) obj;
		if((this.getUsername() == null && other.getUsername() != null) || 
				(this.getUsername() != null && !this.getUsername().equals(other.getUsername()))) {
			return false;
		}
		
		return true;
	}

}
