export class AppConstants {

    static readonly APP_AUTHOR = {
        name: "Prof team",
        address: "150, Thanh Da Street, HCM City, Vietnam",
        email: "profteam@gmail.com",
        phone: "(090) 6546 948",
        socialLinks: {
            facebook: "https://www.facebook.com/dinh.dat.thong",
            github: "https://github.com/dinhdatthong1809",
            instagram: "https://www.instagram.com/dinh.dat.thong"
        },
        members: {
            haondps07264: {
                name: "Nguyễn Đại Hào",
                facebook: "https://www.facebook.com/DuckyLuckVN"
            },
            thanhllps08444: {
                name: "Lê Long Thành",
                facebook: "https://www.facebook.com/yu.nhox"
            },
            tiendqps08547: {
                name: "Đào Quang Tiến",
                facebook: "https://www.facebook.com/bac.cai.756"
            },
            bienpdps08445: {
                name: "Phạm Duy Biên",
                facebook: "https://www.facebook.com/phamduybien94"
            },
            thongddps08464: {
                name: "Đinh Đat Thông",
                facebook: "https://www.facebook.com/dinh.dat.thong"
            }
        }
    };

    static readonly NUMBER_ONLY_REGEX: RegExp = /^\d+$/;

    static readonly CART_CAPACITY_MAX: number = 10;
    static readonly CART_CAPACITY_PER_ITEM_MAX: number = 7;

    static readonly USERNAME_REGEX: RegExp = /^[a-zA-Z0-9_]+$/;
    static readonly USERNAME_MIN_LENGTH: number = 3;
    static readonly USERNAME_MAX_LENGTH: number = 40;

    static readonly FULLNAME_MIN_LENGTH: number = 1;
    static readonly FULLNAME_MAX_LENGTH: number = 75;

    static readonly PASSWORD_REGEX: RegExp = /^[a-zA-Z0-9\s\u002D\u005F]+$/;
    static readonly PASSWORD_MIN_LENGTH: number = 3;
    static readonly PASSWORD_MAX_LENGTH: number = 40;

    static readonly ADDRESS_MIN_LENGTH: number = 3;
    static readonly ADDRESS_MAX_LENGTH: number = 100;

    static readonly PHONE_NUMBER_MIN_LENGTH: number = 10;
    static readonly PHONE_NUMBER_MAX_LENGTH: number = 13;

    static readonly EMAIL_REGEX: RegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    static readonly EMAIL_MIN_LENGTH: number = 3;
    static readonly EMAIL_MAX_LENGTH: number = 100;

    static readonly TITLE_KEYWORD_MIN_LENGTH: number = 0;
    static readonly TITLE_KEYWORD_MAX_LENGTH: number = 100;

    static readonly PRICE_MIN: number = 0;

    static readonly BOOK_IMG_STORAGE: string = `https://storage.googleapis.com/book-garden.appspot.com/book/`;
    static readonly BOOK_IMG_DEFAULT: string = `assets/images/no-image.png`;
    static readonly USER_IMG_STORAGE: string = `https://storage.googleapis.com/book-garden.appspot.com/book/`;
    static readonly USER_IMG_DEFAULT: string = `assets/images/avatars/default.jpg`;

    static readonly ORDER_STATUS_OPEN: string = `Order placed`;
    static readonly ORDER_STATUS_IN_PROGRESS: string = `Processing`;
    static readonly ORDER_STATUS_IN_SHIPPING: string = `Shipping`;
    static readonly ORDER_STATUS_DONE: string = `Completed`;
    static readonly ORDER_STATUS_REJECT: string = `Cancelled`;

}
