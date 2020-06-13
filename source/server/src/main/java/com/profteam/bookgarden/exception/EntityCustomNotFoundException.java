package com.profteam.bookgarden.exception;

public class EntityCustomNotFoundException extends RuntimeException {
    
    public EntityCustomNotFoundException(Number id, Class clazz) {
        super(clazz.getSimpleName() + " not found with id: " + id);
    }
    
}
