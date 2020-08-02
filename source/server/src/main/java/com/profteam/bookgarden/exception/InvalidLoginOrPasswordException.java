package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class InvalidLoginOrPasswordException extends AbstractThrowableProblem {

    private static final long serialVersionUID = 1L;

    public InvalidLoginOrPasswordException() {
        super(null, "The login or password is incorrect!", Status.BAD_REQUEST);
    }

    public InvalidLoginOrPasswordException(String message) {
        super(null, message, Status.BAD_REQUEST);
    }
}
