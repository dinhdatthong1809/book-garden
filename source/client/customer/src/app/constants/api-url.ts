export class ApiUrl {

    static readonly BOOK: string = "http://localhost:8088/api/book";
    static readonly BOOK_FILTER: string = "http://localhost:8088/api/book/search";

    static readonly CATEGORY: string = "http://localhost:8088/api/category";
    static readonly CATEGORY_FIND_ALL: string = "http://localhost:8088/api/category/findAll";

    static readonly USER: string = "http://localhost:8088/api/user";
    static readonly USER_SIGN_UP: string = "http://localhost:8088/api/user/register";
    static readonly USER_SIGN_IN: string = "http://localhost:8088/api/user/login";
    static readonly USER_CHECK_OUT: string = "http://localhost:8088/api/user/order";
    static readonly USER_ORDER: string = "http://localhost:8088/api/user/order-history";

}
