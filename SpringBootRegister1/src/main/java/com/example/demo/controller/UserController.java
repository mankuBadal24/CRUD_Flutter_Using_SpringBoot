package com.example.demo.controller;



import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entity.User;
import com.example.demo.services.UserServices;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@RestController
@CrossOrigin// forgot to add this
public class UserController {
    @Autowired
    private UserServices service;

    @PostMapping("/register")
    private ResponseEntity<String> registerUser(@RequestBody User user){
        //save the user
    	
        String msg = service.saveUser(user);
        System.out.println("user-->"+new Gson().toJson(user));
        return new ResponseEntity<String>(msg,HttpStatus.OK);
    }
    
// Display All users
    @GetMapping("/users")
    private ResponseEntity<List<User>> getAllUsers(){
    		
    	List<User> users = service.getAllUsers();
    	 System.out.println("user-->"+new Gson().toJson(users));
    	return new ResponseEntity<List<User>>(users, HttpStatus.OK);
    }
    
// Display user by ID
//    @GetMapping("/users/{id}")
//    private ResponseEntity<?> getUserById(@PathVariable Integer id){
//        Optional<User> userOptional = service.getUserById(id);
//        
//        if (userOptional.isPresent()) {
//            User user = userOptional.get();
//            ObjectMapper mapper = new ObjectMapper();  // Use Jackson instead of Gson
//            try {
//				System.out.println("user-->" + mapper.writeValueAsString(user));
//			} catch (JsonProcessingException e) {
//				e.printStackTrace();
//			}
//            return new ResponseEntity<>(user, HttpStatus.OK);
//        } else {
//            return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
//        }
//    }
    
    @PostMapping("/users/getById")
    private ResponseEntity<?> getUserById(@RequestBody Map<String, Integer> requestBody) {
        Integer id = requestBody.get("id"); 
        Optional<User> userOptional = service.getUserById(id);
        
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            ObjectMapper mapper = new ObjectMapper();  // Use Jackson to log the user details
            try {
                System.out.println("user-->" + mapper.writeValueAsString(user));
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            return new ResponseEntity<>(user, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
        }
    }

// // Update User
//    @PostMapping("/users/update")
//    private ResponseEntity<String> updateUser(@PathVariable Integer id, @RequestBody User user) {
//        String msg = service.updateUser(id, user);
//        System.out.println("user -->" + new Gson().toJson(user));
//        if (msg.equals(" Data Updated")) {
//            return new ResponseEntity<>(msg, HttpStatus.OK);
//        } else {
//            return new ResponseEntity<>(msg, HttpStatus.NOT_FOUND);
//        }
//    }
    
//    update user
    @PostMapping("/users/update")
    private ResponseEntity<String> updateUser(@RequestBody Map<String, Object> requestBody) {
        // Extract the id as an Integer (since requestBody.get() will return an Object)
        Integer id = Integer.parseInt(requestBody.get("id").toString());

        // Extract the user object and map it to the User entity
        ObjectMapper mapper = new ObjectMapper();
        User user = mapper.convertValue(requestBody.get("user"), User.class);

        // Call the service layer to update the user
        String msg = service.updateUser(id, user);
        System.out.println("user -->" + new Gson().toJson(user));

        // Return the response based on whether the update was successful
        if (msg.equals("Data Updated")) {
            return new ResponseEntity<>(msg, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(msg, HttpStatus.NOT_FOUND);
        }
    }

    
////delete user
//    @DeleteMapping("/users/delete/{id}")
//    private ResponseEntity<String> deleteUser(@PathVariable Integer id){
//    	String msg = service.deleteUser(id);
//    	if(msg.equals("data deleted")) {
//    		return new ResponseEntity<>(msg,HttpStatus.OK);
//    	}else {
//    		return new ResponseEntity<>(msg,HttpStatus.NOT_FOUND);
//    	}
//    }
   
//    delete user without id
    @PostMapping("/users/delete")
    private ResponseEntity<String> deleteUser(@RequestBody Map<String, Object> requestBody) {
        // Extract the id from the request body (assuming the ID is being sent as an Integer or String)
        Integer id = Integer.parseInt(requestBody.get("id").toString());

        // Call the service layer to delete the user
        String msg = service.deleteUser(id);
        
        if (msg.equals("User Deleted")) {
            return new ResponseEntity<>(msg, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(msg, HttpStatus.NOT_FOUND);
        }
    }

}






