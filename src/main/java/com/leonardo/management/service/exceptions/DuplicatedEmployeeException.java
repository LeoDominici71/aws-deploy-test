package com.leonardo.management.service.exceptions;

public class DuplicatedEmployeeException extends RuntimeException {
   
	private static final long serialVersionUID = 1L;

	public DuplicatedEmployeeException(String message) {
        super(message);
    }
}