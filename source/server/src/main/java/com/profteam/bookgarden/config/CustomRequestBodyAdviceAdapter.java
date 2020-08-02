package com.profteam.bookgarden.config;

import com.profteam.bookgarden.service.LoggingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.RequestBodyAdviceAdapter;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Type;

@ControllerAdvice
public class CustomRequestBodyAdviceAdapter extends RequestBodyAdviceAdapter {

    /** The logging service. */
    @Autowired
    LoggingService loggingService;

    /** The http servlet request. */
    @Autowired
    HttpServletRequest httpServletRequest;

    /**
     * Supports.
     *
     * @param methodParameter the method parameter
     * @param type the type
     * @param aClass the a class
     * @return true, if successful
     */
    @Override
    public boolean supports(MethodParameter methodParameter, Type type,
        Class<? extends HttpMessageConverter<?>> aClass) {
        return true;
    }

    /**
     * After body read.
     *
     * @param body the body
     * @param inputMessage the input message
     * @param parameter the parameter
     * @param targetType the target type
     * @param converterType the converter type
     * @return the object
     */
    @Override
    public Object afterBodyRead(Object body, HttpInputMessage inputMessage, MethodParameter parameter, Type targetType,
        Class<? extends HttpMessageConverter<?>> converterType) {

        loggingService.logRequest(httpServletRequest, body);

        return super.afterBodyRead(body, inputMessage, parameter, targetType, converterType);
    }
}
