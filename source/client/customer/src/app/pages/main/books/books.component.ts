import {Component, OnInit} from '@angular/core';
import {BookService} from "src/app/services/book.service";
import {BookListDto} from "src/app/dto/book-list-dto";
import {Observable} from "rxjs";
import {FormBuilder, FormGroup} from "@angular/forms";
import {BookListCriteriaDto} from "src/app/dto/book-list-criteria-dto";

@Component({
    selector: 'app-books',
    templateUrl: './books.component.html',
    styleUrls: ['./books.component.css']
})
export class BooksComponent implements OnInit {

    books: Observable<BookListDto[]>;

    filterForm: FormGroup;

    chunk: number = 5;

    page: number = 1;

    totalBook: number = 100;

    bookListCriteriaDto: BookListCriteriaDto = new BookListCriteriaDto();

    constructor(private _bookService: BookService,
                private _formBuilder: FormBuilder) {
    }

    ngOnInit(): void {
        this.loadAsyncData();
        this.initForm();
    }

    private loadAsyncData(): void {
        this.loadBookList();
    }

    private loadBookList() {
        this.books = this._bookService.findChunkWithTitleKeywordAndPriceAndCategory(this.bookListCriteriaDto);
    }

    private initForm(): void {
        this.filterForm = this._formBuilder.group({
            titleKeyword: [null],
            priceFrom: [null],
            priceTo: [null],
            category: [null],
        });
    }

    onSubmit(): void {
        this.loadBookList();
    }

    goToPage(page: number): void {
        this.page = page;
        this.filterInChunkAndPage();
    }

    filterInChunkAndPage(): void {

    }

}
