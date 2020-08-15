package com.profteam.bookgarden.mapper;

import com.profteam.bookgarden.dto.request.RegisterRequestDto;
import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.User;
import com.profteam.bookgarden.dto.UserDto;
import com.profteam.bookgarden.dto.response.LoginResponseDto;

@Mapper
public interface UserMapper {

    public LoginResponseDto userToLoginResponseDto(User user);
    
    public User registerRequestDtoToUser(RegisterRequestDto registerRequestDto);
    
    public UserDto userToUserDto(User user);

}
