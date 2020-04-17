package egovframework.com.cmm.security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

public class CustomJdbcDaoImpl extends JdbcDaoImpl {
	private String groupAuthoritiesByUsernameQuery;
	
	public void setGroupAuthoritiesByUsernameQuery(String queryString) {
        groupAuthoritiesByUsernameQuery = queryString;
    }
	
	@SuppressWarnings("deprecation")
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        List<UserDetails> users = loadUsersByUsername(username);

        if (users.size() == 0) {
        	logger.debug("Query returned no results for user '" + username + "'");

			throw new UsernameNotFoundException(messages.getMessage("EgovJdbcUserDetailsManager.notFound", new Object[] { username }, "Username {0} not found"));
        }

        UserDetails user = (LoginInfo)users.get(0); // contains no GrantedAuthority[]

        Set<GrantedAuthority> dbAuthsSet = new HashSet<GrantedAuthority>();

        if (getEnableAuthorities()) {
            dbAuthsSet.addAll(loadUserAuthorities(user.getUsername()));
        }

        if (getEnableGroups()) {
            dbAuthsSet.addAll(loadGroupAuthorities(user.getUsername()));
        }

        List<GrantedAuthority> dbAuths = new ArrayList<GrantedAuthority>(dbAuthsSet);

        ((LoginInfo) user).setAuthorities(dbAuths);

        if (dbAuths.size() == 0) {
            logger.debug("User '" + username + "' has no authorities and will be treated as 'not found'");
            throw new UsernameNotFoundException(messages.getMessage("EgovJdbcUserDetailsManager.noAuthority", new Object[] { username }, "User {0} has no GrantedAuthority"));
        }

        return user;
    }
	
	@Override
	protected List<UserDetails> loadUsersByUsername(String username) {
        return getJdbcTemplate().query(getUsersByUsernameQuery(), new String[] {username}, new RowMapper<UserDetails>() {
            public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
                String userid = rs.getString(1);
                String pwd = rs.getString(2);
                String name = rs.getString(4);
                
                //이 시점에서는 권한을 조회하지는 않기 때문에 AuthorityUtils.NO_AUTHORITIES를 넣어 권한이 일단은 아무것도 없다고 생각하고 나중에
                //채우는 방식으로 진행하게 된다.
                return new LoginInfo(userid, pwd, name, AuthorityUtils.NO_AUTHORITIES);
            }
        });
    }
	
	@Override
	protected List<GrantedAuthority> loadUserAuthorities(String username) {
		return getJdbcTemplate().query(getAuthoritiesByUsernameQuery(), new String[] {username}, new RowMapper<GrantedAuthority>() {
            public GrantedAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
                String roleName = getRolePrefix() + rs.getString(2);

                return new SimpleGrantedAuthority(roleName);
            }
        });
    }
	
	@Override
	protected List<GrantedAuthority> loadGroupAuthorities(String username) {
		return getJdbcTemplate().query(groupAuthoritiesByUsernameQuery, new String[] {username}, new RowMapper<GrantedAuthority>() {
            public GrantedAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
            	//logger.debug("id = " + rs.getString(1) + " group_name = " +rs.getString(2) +" authority = " +rs.getString(3));
            	
                String roleName = getRolePrefix() + rs.getString(3);

                return new SimpleGrantedAuthority(roleName);
            }
        });
    }
}
