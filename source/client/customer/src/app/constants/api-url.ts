export class ApiUrl {

    static readonly HOST: string = "http://localhost:8088/";
    // static readonly HOST: string = "http://bookstorebackend-env.eba-66zgmwcv.ap-southeast-1.elasticbeanstalk.com/";

    static readonly BOOK: string = `${ApiUrl.HOST}api/book`;
    static readonly BOOK_FILTER: string = `${ApiUrl.HOST}api/book/search`;

    static readonly CATEGORY: string = `${ApiUrl.HOST}api/category`;
    static readonly CATEGORY_FIND_ALL: string = `${ApiUrl.HOST}api/category/findAll`;

    static readonly USER: string = `${ApiUrl.HOST}api/user`;
    static readonly USER_SIGN_UP: string = `${ApiUrl.HOST}api/user/register`;
    static readonly USER_FIND_BY_USERNAME: string = `${ApiUrl.HOST}api/user/find-by-username`;
    static readonly USER_SIGN_IN: string = `${ApiUrl.HOST}api/user/login`;
    static readonly USER_CHECK_OUT: string = `${ApiUrl.HOST}api/user/order`;
    static readonly USER_ORDER: string = `${ApiUrl.HOST}api/user/order-history`;

}
