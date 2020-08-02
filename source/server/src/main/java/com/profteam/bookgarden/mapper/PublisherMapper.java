package com.profteam.bookgarden.mapper;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.Publisher;
import com.profteam.bookgarden.dto.PublisherDto;

@Mapper
public interface PublisherMapper {

    PublisherDto toPublisherDto(Publisher publisher);

}
