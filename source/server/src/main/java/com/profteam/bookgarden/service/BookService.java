package com.profteam.bookgarden.service;

import java.util.Optional;

import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.profteam.bookgarden.dom.Book;
import com.profteam.bookgarden.dto.BookDto;
import com.profteam.bookgarden.dto.request.SearchAndFilterBookRequestDto;
import com.profteam.bookgarden.dto.response.SearchAndFilterBookResponseDto;
import com.profteam.bookgarden.mapper.BookMapper;
import com.profteam.bookgarden.repository.BookRepository;
import com.profteam.bookgarden.repository.impl.CustomBookRepository;

@Service
public class BookService {

    @Autowired
    BookRepository bookRepository;

    @Autowired
    CustomBookRepository customBookRepository;

    private final BookMapper bookMapper = Mappers.getMapper(BookMapper.class);

    public BookDto findById(String id) {
        Optional<Book> bookOpt = bookRepository.findById(id);
        if (bookOpt.isPresent()) {
            return bookMapper.toBookDto(bookOpt.get());
        }

        return null;
    }

    public SearchAndFilterBookResponseDto searchAndFilter(SearchAndFilterBookRequestDto request) {
        SearchAndFilterBookResponseDto response = new SearchAndFilterBookResponseDto();

        String title = "%" + request.getTitle() + "%";
        String categoryId = "%" + request.getCategoryId() + "%";

        double minPrice = request.getMinPrice();
        double maxPrice = request.getMaxPrice();

        if (maxPrice == 0) {
            maxPrice = Long.MAX_VALUE;
        }

        Sort sort = Sort.by(Direction.valueOf(request.getOrderBy().getOrderEnum().name()), request.getOrderBy().getField());
        Pageable pageable = PageRequest.of(request.getPage(), request.getSize(), sort);

        Page<Book> pageBooks = bookRepository.findDistinctByTitleLikeAndCategoriesIdLikeAndPriceBetween(title, categoryId,
                minPrice, maxPrice, pageable);

        response.setList(bookMapper.toListBookDto(pageBooks.getContent()));
        response.setTotalElements(pageBooks.getTotalElements());

        return response;
    }

}
