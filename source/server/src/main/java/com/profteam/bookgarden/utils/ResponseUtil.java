package com.profteam.bookgarden.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.profteam.bookgarden.constants.Constants;
import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.dto.ResponseDto;

public class ResponseUtil {

    public static ResponseDto createResponseSuccess(Object data) {
        ResponseDto responseDto = new ResponseDto();

        responseDto.setMessage(CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_SUCCESS));
        responseDto.setResultData(data);

        return responseDto;
    }

    public static Map<String, Object> createResponse(Object data, String message) {
        Map<String, Object> response = new HashMap<>();

        ResponseDto resultData = new ResponseDto();
        resultData.setResultData(data);
        resultData.setMessage(message);
        response.put(Constants.CONST_RESPONSE, resultData);

        return response;
    }

    public static ResponseDto createResponseError(List<?> data) {

        ResponseDto ResponseDto = new ResponseDto();
        ResponseDto.setErrorData(data);
        return ResponseDto;
    }

    public static ResponseDto createResponseErrorHandle(String message) {
        ResponseDto response = new ResponseDto();
        response.setMessage(message);
        return response;
    }

    public static Map<String, Object> createResponseError(String message) {
        Map<String, Object> response = new HashMap<>();
        ResponseDto resultData = new ResponseDto();
        resultData.setMessage(message);
        response.put(Constants.CONST_RESPONSE, resultData);
        return response;
    }
}
