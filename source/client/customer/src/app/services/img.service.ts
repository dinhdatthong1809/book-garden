import {Injectable} from '@angular/core';
import {AppConstants} from "src/app/constants/app-constants";

@Injectable({
    providedIn: 'root'
})
export class ImgService {

    constructor() {
    }

    getBookImg(image: string): string {
        if (!image) {
            return AppConstants.BOOK_IMG_DEFAULT;
        }

        return AppConstants.BOOK_IMG_STORAGE + image;
    }

}
