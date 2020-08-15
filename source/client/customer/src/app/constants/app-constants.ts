import {Validators} from "@angular/forms";

export class AppConstants {

    static readonly APP_AUTHOR = {
        name: "Prof team",
        address: "150, Thanh Da Street, HCM City, Vietnam",
        passwordConfirm: "profteam@gmail.com",
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

    static readonly NUMBER_ONLY_REGEX: RegExp = /^(0|[1-9]\d*)?$/;

    static readonly CART_CAPACITY_MAX: number = 10;
    static readonly CART_CAPACITY_PER_ITEM_MAX: number = 7;

    static readonly USERNAME_REGEX: RegExp = /^[a-zA-Z0-9_]+$/;
    static readonly USERNAME_MIN_LENGTH: number = 3;
    static readonly USERNAME_MAX_LENGTH: number = 40;

    static readonly PASSWORD_REGEX: RegExp = /^[a-zA-Z0-9\s\u002D\u005F]+$/;
    static readonly PASSWORD_MIN_LENGTH: number = 3;
    static readonly PASSWORD_MAX_LENGTH: number = 40;

    static readonly EMAIL_REGEX: RegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    static readonly EMAIL_MIN_LENGTH: number = 3;
    static readonly EMAIL_MAX_LENGTH: number = 100;

    static readonly TITLE_KEYWORD_MIN_LENGTH: number = 0;
    static readonly TITLE_KEYWORD_MAX_LENGTH: number = 100;

    static readonly PRICE_MIN: number = 0;

}
