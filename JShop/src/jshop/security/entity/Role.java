package jshop.security.entity;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="Roles")
public class Role {
	@Id
	String id;
	String name;
	
	@OneToMany(mappedBy="role")
	Collection<Permission> permissions;
	
	@OneToMany(mappedBy="role")
	Collection<UserRole> userRoles;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Collection<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(Collection<Permission> permissions) {
		this.permissions = permissions;
	}

	public Collection<UserRole> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(Collection<UserRole> userRoles) {
		this.userRoles = userRoles;
	}
}
