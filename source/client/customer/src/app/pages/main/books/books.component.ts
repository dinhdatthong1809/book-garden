import {Component, OnInit} from '@angular/core';
import {BookService} from "src/app/services/book.service";
import {BookListDto} from "src/app/dto/response/book-list-dto";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {BookListCriteriaDto} from "src/app/dto/request/book-list-criteria-dto";
import {AppConstants} from "src/app/constants/app-constants";
import {getDataList, PaginationResponse} from "src/app/dto/abstract-response";
import {SessionKeys} from "src/app/constants/session-keys";

@Component({
    selector: 'app-books',
    templateUrl: './books.component.html',
    styleUrls: ['./books.component.css']
})
export class BooksComponent implements OnInit {

    appConstants = AppConstants;

    books: BookListDto[];

    filterForm: FormGroup;

    submitted: boolean = false;

    page: number = 1;

    totalBook: number = 100;

    bookListCriteriaDto: BookListCriteriaDto = new BookListCriteriaDto();

    constructor(private _bookService: BookService,
                private _formBuilder: FormBuilder) {
    }

    ngOnInit(): void {
        this.initForm();
        this.loadAsyncData();
    }

    private loadAsyncData(): void {
        this.loadBookList();
    }

    private loadBookList() {
        if (sessionStorage.getItem(SessionKeys.TITLE_KEYWORD) && !this.bookListCriteriaDto.title) {
            this.bookListCriteriaDto.title = sessionStorage.getItem(SessionKeys.TITLE_KEYWORD);
        }

        this._bookService.findChunkWithTitleKeywordAndPriceAndCategory(this.bookListCriteriaDto)
                         .subscribe((value: PaginationResponse<BookListDto>) => {
                             this.books = getDataList<BookListDto>(value);
                         });
    }

    private initForm(): void {
        this.filterForm = this._formBuilder.group({
            title: [null, [
                Validators.maxLength(AppConstants.TITLE_KEYWORD_MAX_LENGTH),
            ]],
            minPrice: [null, [
                Validators.min(AppConstants.PRICE_MIN),
            ]],
            maxPrice: [null, [
                Validators.min(AppConstants.PRICE_MIN),
            ]],
            categoryId: [""],
        });
    }

    onSubmit(): void {
        this.submitted = true;

        if (this.filterForm.invalid) {
            return;
        }

        this.loadBookList();
    }

    get getForm() {
        return this.filterForm.controls;
    }

    goToPage(page: number): void {
        this.page = page;
        this.filterInChunkAndPage();
    }

    filterInChunkAndPage(): void {

    }

}
