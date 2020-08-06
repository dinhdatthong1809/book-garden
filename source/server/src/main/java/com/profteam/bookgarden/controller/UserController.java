package com.profteam.bookgarden.controller;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.dto.request.LoginRequestDto;
import com.profteam.bookgarden.service.OrderService;
import com.profteam.bookgarden.service.UserService;
import com.profteam.bookgarden.utils.CommonUtil;
import com.profteam.bookgarden.utils.ResponseUtil;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    OrderService orderService;

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@Valid @RequestBody LoginRequestDto request) {

        return new ResponseEntity<>(
                ResponseUtil.createResponse(null, CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)),
                HttpStatus.OK);
    }

    @PostMapping("/login2")
    public ResponseEntity<Map<String, Object>> login() {
        return new ResponseEntity<>(
                ResponseUtil.createResponse(null, CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)),
                HttpStatus.OK);
    }

    @PostMapping("/order-history")
    public ResponseEntity<Map<String, Object>> getOrderHistory() {
        return new ResponseEntity<>(ResponseUtil.createResponse(orderService.getListOrderHistory(),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
    }

}
