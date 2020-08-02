package com.profteam.bookgarden.mapper;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.User;
import com.profteam.bookgarden.dto.response.LoginResponseDto;

@Mapper
public interface UserMapper {

    public LoginResponseDto userToLoginResponseDto(User user);

}
