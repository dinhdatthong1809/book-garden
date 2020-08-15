package com.profteam.bookgarden.utils;

import com.profteam.bookgarden.dto.request.PageRequestDto;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

public class PageUtil {
    
    public static Pageable getPageable(PageRequestDto request, Sort sort) {
        return PageRequest.of(Integer.parseInt(request.getPage()) - 1, Integer.parseInt(request.getSize()), sort);
    }
    
}
