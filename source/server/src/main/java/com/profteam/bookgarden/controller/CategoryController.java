package com.profteam.bookgarden.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.service.CategoryService;
import com.profteam.bookgarden.utils.CommonUtil;
import com.profteam.bookgarden.utils.ResponseUtil;

@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @GetMapping("/findAll")
    public ResponseEntity<Map<String, Object>> findAll() {
        return new ResponseEntity<>(ResponseUtil.createResponse(categoryService.findAll(),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_SUCCESS)), HttpStatus.OK);
    }
}
