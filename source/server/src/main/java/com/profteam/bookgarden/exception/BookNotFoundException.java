package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class BookNotFoundException extends AbstractThrowableProblem {

    private static final long serialVersionUID = 1L;

    public BookNotFoundException(String bookId) {
        super(null, "Book with id " + bookId + " not found", Status.BAD_REQUEST, "1000");
    }

}
