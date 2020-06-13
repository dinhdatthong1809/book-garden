package com.profteam.bookgarden.i18n;

public enum I18nMessages {
    
    API_NOT_FOUND("apiNotFound"),

    DATE_OF_DEATH_MUST_BE_AFTER_DATE_OF_BIRTH("dateOfDeathMustBeAfterDateOfBirth"),
    
    MALFORMED_JSON_REQUEST("malformedJsonRequest"),
    
    SOMETHING_BAD_HAPPENED("somethingBadHappened"),
    
    THIS_PROJECT_WAS_UPDATED_BY_AN_OTHER_USER_PLEASE_REFRESH_PAGE("thisProjectWasUpdatedByAnotherUserPleaseRefreshPage");
    
    private final String key;
    
    I18nMessages(String key) {
        this.key = key;
    }
    
    public String getKey() {
        return this.key;
    }
    
}
