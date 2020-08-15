package com.profteam.bookgarden.validator.pattern;

import javax.validation.ConstraintValidatorContext;
import javax.validation.metadata.ConstraintDescriptor;

import org.hibernate.validator.constraintvalidation.HibernateConstraintValidator;
import org.hibernate.validator.constraintvalidation.HibernateConstraintValidatorInitializationContext;

import com.profteam.bookgarden.constants.Constants;

public class PatternValidator implements HibernateConstraintValidator<Pattern, String> {

    private String pattern;

    @Override
    public void initialize(ConstraintDescriptor<Pattern> constraintDescriptor,
            HibernateConstraintValidatorInitializationContext initializationContext) {
        this.pattern = (String) constraintDescriptor.getAttributes().get(Constants.CONST_STR_PATTERN);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        java.util.regex.Pattern pat = java.util.regex.Pattern.compile(this.pattern);
        String text = "";
        if (value != null && !value.isEmpty()) {
            text = value + ";";
            if (!pat.matcher(text).matches()) {
                return false;
            }
        }
        return true;
    }
}
