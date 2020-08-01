export class AppConstants {

    static readonly NUMBER_ONLY_REGEX: RegExp = /^(0|[1-9]\d*)?$/;

    static readonly USERNAME_REGEX: RegExp = /^[a-zA-Z0-9_]+$/;
    static readonly USERNAME_MIN_LENGTH: number = 3;
    static readonly USERNAME_MAX_LENGTH: number = 40;

    static readonly PASSWORD_REGEX: RegExp = /^[a-zA-Z0-9\s\u002D\u005F]+$/;
    static readonly PASSWORD_MIN_LENGTH: number = 5;
    static readonly PASSWORD_MAX_LENGTH: number = 40;

    static readonly EMAIL_REGEX: RegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    static readonly EMAIL_MIN_LENGTH: number = 3;
    static readonly EMAIL_MAX_LENGTH: number = 100;

}
