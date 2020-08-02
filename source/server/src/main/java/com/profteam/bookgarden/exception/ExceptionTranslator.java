package com.profteam.bookgarden.exception;

import com.profteam.bookgarden.constants.Constants;
import com.profteam.bookgarden.utils.ResponseUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.NativeWebRequest;
import org.zalando.problem.Problem;
import org.zalando.problem.ProblemBuilder;
import org.zalando.problem.spring.web.advice.ProblemHandling;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Controller advice to translate the server side exceptions to client-friendly json structures.
 * The error response follows RFC7807 - Problem Details for HTTP APIs (https://tools.ietf.org/html/rfc7807).
 */
@ControllerAdvice
public class ExceptionTranslator implements ProblemHandling {

    public ExceptionTranslator() {
        super();
    }
    
    @Override
    public ResponseEntity<Problem> process(@Nullable ResponseEntity<Problem> entity, NativeWebRequest request) {
        if (entity == null) {
            return entity;
        }
        Problem problem = entity.getBody();
        ProblemBuilder builder = Problem.builder();
        builder.with(Constants.CONST_RESPONSE, ResponseUtil.createResponseErrorHandle(problem.getTitle()));

        return new ResponseEntity<>(builder.build(), entity.getHeaders(), entity.getStatusCode());
    }

    @Override
    public ResponseEntity<Problem> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, @Nonnull NativeWebRequest request) {
        BindingResult result = ex.getBindingResult();
        List<FieldErrorVM> fieldErrors = result.getFieldErrors().stream()
            .map(f -> new FieldErrorVM( f.getField(), f.getDefaultMessage()))
            .collect(Collectors.toList());

        ProblemBuilder builder = Problem.builder();
        builder.with(Constants.CONST_RESPONSE, ResponseUtil.createResponseError(fieldErrors));
        return new ResponseEntity<>(builder.build(), new HttpHeaders(), HttpStatus.BAD_REQUEST);
    }
    
    @Override
    public ResponseEntity<Problem> handleConstraintViolation(ConstraintViolationException exception,
            NativeWebRequest request) {
        Set<ConstraintViolation<?>> result = exception.getConstraintViolations();
        List<FieldErrorVM> fieldErrors = result.stream()
            .map(f -> new FieldErrorVM( f.getPropertyPath().toString().split("\\.")[1], f.getMessage()))
            .collect(Collectors.toList());

        ProblemBuilder builder = Problem.builder();
        builder.with(Constants.CONST_RESPONSE, ResponseUtil.createResponseError(fieldErrors));
        return new ResponseEntity<>(builder.build(), new HttpHeaders(), HttpStatus.BAD_REQUEST);
    }

}