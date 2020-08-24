package com.profteam.bookgarden.controller;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.dto.request.LoginRequestDto;
import com.profteam.bookgarden.dto.request.OrderRequestDto;
import com.profteam.bookgarden.dto.request.PageRequestDto;
import com.profteam.bookgarden.dto.request.RegisterRequestDto;
import com.profteam.bookgarden.dto.request.UpdateUserInfoRequestDto;
import com.profteam.bookgarden.service.OrderService;
import com.profteam.bookgarden.service.UserService;
import com.profteam.bookgarden.utils.CommonUtil;
import com.profteam.bookgarden.utils.ResponseUtil;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@Valid @RequestBody LoginRequestDto request) {
        return new ResponseEntity<>(ResponseUtil.createResponse(userService.login(request),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity<Map<String, Object>> register(@Valid @RequestBody RegisterRequestDto request) {
        return new ResponseEntity<>(
                ResponseUtil.createResponse(userService.register(request), CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)),
                HttpStatus.OK);
    }

    @GetMapping("/find-by-username")
    public ResponseEntity<Map<String, Object>> findByUsername(@RequestParam String username) {
        return new ResponseEntity<>(ResponseUtil.createResponse(userService.findByUsername(username),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
    }

    @PostMapping("/update-info")
    public ResponseEntity<Map<String, Object>> updateInfo(@Valid @RequestBody UpdateUserInfoRequestDto request) {
        return new ResponseEntity<>(ResponseUtil.createResponse(userService.updateInfo(request),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
    }

    @PostMapping("/order-history")
    public ResponseEntity<Map<String, Object>> getOrderHistory(@Valid @RequestBody PageRequestDto pageRequest) {
        return new ResponseEntity<>(ResponseUtil.createResponse(orderService.getListOrderHistory(pageRequest),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
    }

    @PostMapping("/order")
    public ResponseEntity<Map<String, Object>> order(@Valid @RequestBody OrderRequestDto request) {
        return new ResponseEntity<>(ResponseUtil.createResponse(orderService.order(request),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
    }
    
	@PostMapping("/cancel-order")
	public ResponseEntity<Map<String, Object>> cancelOrder(@RequestParam(required = true) Long orderId) {
		return new ResponseEntity<>(ResponseUtil.createResponse(orderService.cancelOrder(orderId),
				CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_NORMAL)), HttpStatus.OK);
	}

}
