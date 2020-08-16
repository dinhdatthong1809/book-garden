package com.profteam.bookgarden.service;

import java.util.Optional;

import com.profteam.bookgarden.exception.BookNotFoundException;
import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.profteam.bookgarden.dom.Book;
import com.profteam.bookgarden.dto.BookDto;
import com.profteam.bookgarden.dto.request.SearchAndFilterBookRequestDto;
import com.profteam.bookgarden.dto.response.SearchAndFilterBookResponseDto;
import com.profteam.bookgarden.mapper.BookMapper;
import com.profteam.bookgarden.repository.BookRepository;
import com.profteam.bookgarden.utils.PageUtil;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Throwable.class)
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    private final BookMapper bookMapper = Mappers.getMapper(BookMapper.class);

    public BookDto findById(String id) {
        Optional<Book> bookOpt = bookRepository.findById(id);
        if (bookOpt.isPresent()) {
            return bookMapper.toBookDto(bookOpt.get());
        } else {
            throw new BookNotFoundException(id);
        }
    }

    public SearchAndFilterBookResponseDto searchAndFilter(SearchAndFilterBookRequestDto request) {
        SearchAndFilterBookResponseDto response = new SearchAndFilterBookResponseDto();

        double minPrice = request.getMinPrice();
        double maxPrice = request.getMaxPrice();

        if (maxPrice == 0) {
            maxPrice = Long.MAX_VALUE;
        }

        Sort sort = request.getOrderBy().getSort();
        Pageable pageable = PageUtil.getPageable(request, sort);

        Page<Book> pageBooks = bookRepository.findDistinctByTitleContainsAndCategoryIdContainsAndPriceBetween(request.getTitle(), request.getCategoryId(), minPrice, maxPrice, pageable);

        response.setList(bookMapper.toListBookDto(pageBooks.getContent()));
        response.setTotalElements(pageBooks.getTotalElements());

        return response;
    }

    public double getBookPrice(String bookId) {
        Optional<Book> bookOpt = bookRepository.findById(bookId);

        if (bookOpt.isPresent()) {
            return bookOpt.get().getPrice();
        } else {
            return 0;
        }

    }

}
