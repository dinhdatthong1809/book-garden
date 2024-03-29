package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class BookNotEnoughException extends AbstractThrowableProblem {

    private static final long serialVersionUID = 1L;

    public BookNotEnoughException(String bookTitle) {
        super(null, "The remaining number of '" + bookTitle + "' is not enough", Status.NOT_FOUND, "1002");
    }

}
