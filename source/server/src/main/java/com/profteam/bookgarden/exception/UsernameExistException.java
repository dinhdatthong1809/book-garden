package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class UsernameExistException extends AbstractThrowableProblem {

    private static final long serialVersionUID = 1L;

    public UsernameExistException() {
        super(null, "The username is exist", Status.BAD_REQUEST);
    }

    public UsernameExistException(String message) {
        super(null, message, Status.BAD_REQUEST);
    }
}