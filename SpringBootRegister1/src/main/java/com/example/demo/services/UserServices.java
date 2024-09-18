package com.example.demo.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.User;
import com.example.demo.repo.UserRepo;



@Service
public class UserServices {

    @Autowired
    private UserRepo repo;

    public String saveUser(User user) {

    	
        repo.save(user);
        
        return "User registered Successfully";
    }

	public List<User> getAllUsers() {
	return	repo.findAll();
	}

	

	public Optional<User> getUserById(Integer id) {
	
		return repo.findById(id);
	}

	public String updateUser(Integer id, User user) {
		Optional<User> existUser = repo.findById(id);
		if(existUser.isPresent()) {
			User updateUser = existUser.get();
			updateUser.setName(user.getName());
			updateUser.setEmail(user.getEmail());
			updateUser.setAddress(user.getAddress());
			updateUser.setMobile(user.getMobile());
			repo.save(updateUser);
			return " Data Updated";
		}else {
			return "User not Found";
		}	
	}

	public String deleteUser(Integer id) {
		Optional<User> user = repo.findById(id);
		if(user.isPresent()) {
			repo.deleteById(id);
			return "data deleted";
		}else {
			return "user not found";
		}
	}
}

