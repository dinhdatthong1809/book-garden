package com.profteam.bookgarden.service;

import java.nio.charset.StandardCharsets;
import java.util.Optional;

import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.profteam.bookgarden.dom.User;
import com.profteam.bookgarden.dto.UserDto;
import com.profteam.bookgarden.dto.request.LoginRequestDto;
import com.profteam.bookgarden.dto.request.RegisterRequestDto;
import com.profteam.bookgarden.dto.request.UpdateUserInfoRequestDto;
import com.profteam.bookgarden.dto.response.LoginResponseDto;
import com.profteam.bookgarden.exception.InvalidUsernameOrPasswordException;
import com.profteam.bookgarden.exception.UsernameExistException;
import com.profteam.bookgarden.mapper.UserMapper;
import com.profteam.bookgarden.repository.UserRepository;

import at.favre.lib.crypto.bcrypt.BCrypt;

@Service
@Transactional(rollbackFor = Throwable.class)
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Value("${security.salt16Bytes}")
    private String salt16Bytes;

    private final UserMapper userMapper = Mappers.getMapper(UserMapper.class);

    public LoginResponseDto login(LoginRequestDto requestDto) {
        User userOpt = userRepository.findByUsernameAndPassword(requestDto.getUsername(), encryptPassword(requestDto.getPassword()))
                                     .orElseThrow(InvalidUsernameOrPasswordException::new);
        return userMapper.userToLoginResponseDto(userOpt);
    }

    public UserDto register(RegisterRequestDto requestDto) {
        Optional<User> userExist = userRepository.findByUsername(requestDto.getUsername());
        if (userExist.isPresent()) {
            throw new UsernameExistException();
        }
        requestDto.setPassword(encryptPassword(requestDto.getPassword()));
        User newUser = userMapper.registerRequestDtoToUser(requestDto);
        newUser.setIsactive(true);
        User user = userRepository.save(newUser);

        return userMapper.userToUserDto(user);
    }

    public Optional<User> findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, encryptPassword(password));
    }

    public UserDto findByUsername(String username) {
        return userMapper.userToUserDto(userRepository.findByUsername(username).orElse(null));
    }

    private String encryptPassword(String password) {
        byte[] pass = BCrypt.withDefaults().hash(6, salt16Bytes.getBytes(), password.getBytes(StandardCharsets.UTF_8));
        return new String(pass, StandardCharsets.UTF_8);
    }

	public UserDto updateInfo(UpdateUserInfoRequestDto request) {
		User user = userMapper.updateUserInfoToUser(request);
		return userMapper.userToUserDto(user);
	}

}
