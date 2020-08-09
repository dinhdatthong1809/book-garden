package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class BookPriceNotCorrectException extends AbstractThrowableProblem {

    private static final long serialVersionUID = 1L;

    public BookPriceNotCorrectException(String bookId) {
        super(null, "Book price with id " + bookId + " not correct", Status.BAD_REQUEST, "1001");
    }

}
