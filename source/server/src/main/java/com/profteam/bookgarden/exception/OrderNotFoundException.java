package com.profteam.bookgarden.exception;

import org.zalando.problem.AbstractThrowableProblem;
import org.zalando.problem.Status;

public class OrderNotFoundException extends AbstractThrowableProblem {

	private static final long serialVersionUID = 1L;

	public OrderNotFoundException() {
		super(null, "Order not found", Status.NOT_FOUND, "1004");
	}

}