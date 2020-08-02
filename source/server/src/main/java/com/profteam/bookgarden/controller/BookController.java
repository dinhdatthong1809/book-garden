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
import com.profteam.bookgarden.dto.request.SearchAndFilterBookRequestDto;
import com.profteam.bookgarden.service.BookService;
import com.profteam.bookgarden.utils.CommonUtil;
import com.profteam.bookgarden.utils.ResponseUtil;

@RestController
@RequestMapping("/api/book")
public class BookController {

    @Autowired
    BookService bookService;

//    @PostMapping
//    public List<BookDto> getListBestSeller(@Valid @RequestBody ListBestSellerRequestDto request) {
//        return customBookRepository.getListBestSeller(request);
//    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> findById(@RequestParam String id) {
        return new ResponseEntity<>(ResponseUtil.createResponse(bookService.findById(id),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_SUCCESS)), HttpStatus.OK);
    }

    
    @PostMapping("/search")
    public ResponseEntity<Map<String, Object>> searchAndFillter(@Valid @RequestBody SearchAndFilterBookRequestDto request) {
        return new ResponseEntity<>(ResponseUtil.createResponse(bookService.searchAndFilter(request),
                CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_SUCCESS)), HttpStatus.OK);
    }

}
