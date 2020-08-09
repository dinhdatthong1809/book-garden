package com.profteam.bookgarden.mapper;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.User;
import com.profteam.bookgarden.dto.UserDto;
import com.profteam.bookgarden.dto.response.LoginResponseDto;

@Mapper
public interface UserMapper {

    public LoginResponseDto userToLoginResponseDto(User user);

    public UserDto userToUserDto(User user);

}
