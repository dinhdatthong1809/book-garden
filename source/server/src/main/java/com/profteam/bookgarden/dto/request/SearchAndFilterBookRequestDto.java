package com.profteam.bookgarden.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchAndFilterBookRequestDto extends PageRequestDto {

    @JsonProperty
    private String title;

    @JsonProperty
    private String authorId;

    @JsonProperty
    private String categoryId;

    @JsonProperty
    private String publisherId;

    @JsonProperty
    private double minPrice;

    @JsonProperty
    private double maxPrice;

    @JsonProperty
    private OrderBy orderBy;

}
