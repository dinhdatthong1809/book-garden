import {Component, OnInit} from '@angular/core';
import {BookService} from "src/app/services/book.service";
import {ActivatedRoute, Router} from "@angular/router";
import {getData, Response} from "src/app/dto/abstract-response";
import {BookDto} from "src/app/dto/response/book-dto";
import {BookInCart} from "src/app/dom/book-in-cart";
import {AppConstants} from "src/app/constants/app-constants";
import {ImgService} from "src/app/services/img.service";

@Component({
    selector: 'app-book-detail',
    templateUrl: './book-detail.component.html',
    styleUrls: ['./book-detail.component.css']
})
export class BookDetailComponent implements OnInit {

    book: BookDto = new BookDto();

    constructor(private _bookService: BookService,
                private _route: ActivatedRoute,
                private _imgService: ImgService) {
    }

    ngOnInit(): void {
        this.findBook();
    }

    findBook(): void {
        this._bookService.findDetail(this._route.snapshot.params.id)
                         .subscribe((response: Response<BookDto>) => {
                             this.book = getData<BookDto>(response);
                         });
    }

    getBookImg(image: string): string {
        return this._imgService.getBookImg(image);
    }
}
