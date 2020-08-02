package com.profteam.bookgarden.validator.notnull;

import javax.validation.ConstraintValidatorContext;
import org.hibernate.validator.constraintvalidation.HibernateConstraintValidator;
import com.profteam.bookgarden.constants.Constants;

/**
 * The Class NotNullValidator.
 * 
 */
public class NotNullValidator implements HibernateConstraintValidator<NotNull, String> {

    /**
     * Checks if is valid.
     *
     * @param value   the value
     * @param context the context
     * @return true, if is valid
     */
    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value != null && !Constants.CONST_STR_BLANK.equals(value.trim())) {
            return true;
        }
        return false;
    }

}
