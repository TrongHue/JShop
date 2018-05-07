package jshop.security.entity;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="Users")
public class User {
	@Id
	String id;
	String password;
	String email;
	
	@OneToMany(mappedBy="user")
	Collection<UserRole> userInRoles;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Collection<UserRole> getUserInRoles() {
		return userInRoles;
	}

	public void setUserInRoles(Collection<UserRole> userInRoles) {
		this.userInRoles = userInRoles;
	}
}
