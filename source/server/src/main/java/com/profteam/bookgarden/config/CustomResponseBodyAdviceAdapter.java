package com.profteam.bookgarden.config;

import com.profteam.bookgarden.service.LoggingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class CustomResponseBodyAdviceAdapter implements ResponseBodyAdvice<Object> {

    @Autowired
    LoggingService loggingService;

    /**
     * Supports.
     *
     * @param methodParameter the method parameter
     * @param aClass the a class
     * @return true, if successful
     */
    @Override
    public boolean supports(MethodParameter methodParameter, Class<? extends HttpMessageConverter<?>> aClass) {
        return true;
    }

    /**
     * Before body write.
     *
     * @param o the o
     * @param methodParameter the method parameter
     * @param mediaType the media type
     * @param aClass the a class
     * @param serverHttpRequest the server http request
     * @param serverHttpResponse the server http response
     * @return the object
     */
    @Override
    public Object beforeBodyWrite(Object o, MethodParameter methodParameter, MediaType mediaType,
        Class<? extends HttpMessageConverter<?>> aClass, ServerHttpRequest serverHttpRequest,
        ServerHttpResponse serverHttpResponse) {

        if (serverHttpRequest instanceof ServletServerHttpRequest
            && serverHttpResponse instanceof ServletServerHttpResponse) {
            loggingService.logResponse(((ServletServerHttpRequest) serverHttpRequest).getServletRequest(),
                ((ServletServerHttpResponse) serverHttpResponse).getServletResponse(), o);
        }

        return o;
    }
}
