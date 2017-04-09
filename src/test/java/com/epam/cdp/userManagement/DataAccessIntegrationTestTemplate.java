package com.epam.cdp.userManagement;

import static org.junit.Assert.*;

import java.util.Collections;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabase;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;

import com.epam.cdp.userManagement.UserManagementApp;
import com.epam.cdp.userManagement.dao.EntityRepository;
import com.epam.cdp.userManagement.dao.GroupRepository;
import com.epam.cdp.userManagement.dao.UserRepository;
import com.epam.cdp.userManagement.dao.helper.UserRowMapper;
import com.epam.cdp.userManagement.model.Address;
import com.epam.cdp.userManagement.model.Group;
import com.epam.cdp.userManagement.model.Permission;
import com.epam.cdp.userManagement.model.User;

@RunWith(SpringRunner.class)
@SpringBootTest(classes=UserManagementApp.class)
public class DataAccessIntegrationTestTemplate {
	@Autowired
    private UserRepository userRepository;
	@Autowired
	private EntityRepository<Address> addressRepositiry;
	@Autowired
	private GroupRepository groupRepo;
	@Autowired
	private EntityRepository<Permission> permRepo;
	
	@Test
    public void findAllUsers() {
        List<User> users = userRepository.getAll();
        assertNotNull(users);
        assertTrue(!users.isEmpty());
    }
	
	@Test
    public void findUsers() {
        User users = userRepository.getById(1);
        assertNotNull(users);
        assertTrue(users.getAddress() != null);
    }
	
	/*@Test
    public void assignPermissions() {
       userRepository.assignPermissions(1, new long[]{1, 2});
       // assertNotNull(users);
        //assertTrue(users.getAddress() != null);
    }*/

	
	@Test
    public void findAllAddress() {
        List<Address> address = addressRepositiry.getAll();
        assertNotNull(address);
        assertTrue(!address.isEmpty());
    }
	
	@Test
    public void findAddress() {
        Address address = addressRepositiry.getById(1);
        assertNotNull(address);
        assertTrue(address.getId() == 1);
    }
	
	@Test
    public void addAddress() {
		Address addr = new Address("City", "Street", 1, 2);
        long addressId = addressRepositiry.create(addr);
       assertTrue(addressId != 0);
    }
	
	@Test
    public void updateAddress() {
		Address addr = addressRepositiry.getById(1);
		String oldStreet = addr.getStreet();
		addr.setStreet("New Street");
        long affestedRows = addressRepositiry.update(addr);
       assertTrue(affestedRows == 1);
       Address updatedAddr = addressRepositiry.getById(1);
       assertTrue(updatedAddr.getStreet().equals("New Street"));
    }
	
	@Test
    public void findAllGroups() {
        List<Group> groups = groupRepo.getAll();
        assertNotNull(groups);
        assertTrue(!groups.isEmpty());
    }
	
	@Test
    public void findGroup() {
        Group group = groupRepo.getById(1);
        assertNotNull(group);
    }
	
	@Test
    public void findAllPermissions() {
        List<Permission> permissions = permRepo.getAll();
        assertNotNull(permissions);
        assertTrue(!permissions.isEmpty());
    }
	
	@Test
    public void findPermission() {
		Permission perm = permRepo.getById(1);
        assertNotNull(perm);
    }
}
