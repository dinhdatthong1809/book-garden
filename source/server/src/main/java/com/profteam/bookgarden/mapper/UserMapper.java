package com.profteam.bookgarden.mapper;

import com.profteam.bookgarden.dto.request.RegisterRequestDto;
import com.profteam.bookgarden.dto.request.UpdateUserInfoRequestDto;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.User;
import com.profteam.bookgarden.dto.UserDto;
import com.profteam.bookgarden.dto.response.LoginResponseDto;
import com.profteam.bookgarden.dto.response.RegisterResponseDto;

@Mapper
public interface UserMapper {

    public LoginResponseDto userToLoginResponseDto(User user);

    public User registerRequestDtoToUser(RegisterRequestDto registerRequestDto);

    public User updateUserInfoToUser(UpdateUserInfoRequestDto updateUserInfoRequestDto);

    public RegisterResponseDto registerRequestDtoToUser(User user);

    public UserDto userToUserDto(User user);

}
