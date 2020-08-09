package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class InvalidUsernameOrPasswordException extends AbstractThrowableProblem {

    private static final long serialVersionUID = 1L;

    public InvalidUsernameOrPasswordException() {
        super(null, "The username or password is incorrect!", Status.BAD_REQUEST);
    }

    public InvalidUsernameOrPasswordException(String message) {
        super(null, message, Status.BAD_REQUEST);
    }
}
