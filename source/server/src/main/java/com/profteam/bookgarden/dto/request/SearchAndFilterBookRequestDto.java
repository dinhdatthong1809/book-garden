package com.profteam.bookgarden.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchAndFilterBookRequestDto extends PageRequestDto {

    String title;

    String authorId;

    String categoryId;

    String publisherId;

    double minPrice;

    double maxPrice;

    OrderBy orderBy;

}
