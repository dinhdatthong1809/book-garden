import {Component, OnInit} from '@angular/core';
import {BookService} from "src/app/services/book.service";
import {BookDto} from "src/app/dto/response/book-dto";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {BookListCriteriaDto} from "src/app/dto/request/book-list-criteria-dto";
import {AppConstants} from "src/app/constants/app-constants";
import {getData, getPaginatedData, PaginationResponse, Response} from "src/app/dto/abstract-response";
import {LocalStorageKeys} from "src/app/constants/local-storage-keys";
import {CategoryService} from "src/app/services/category.service";
import {CategoryDto} from "src/app/dto/response/category-dto";
import {CartService} from "src/app/services/cart.service";
import {ToastrService} from "ngx-toastr";

@Component({
    selector: 'app-books',
    templateUrl: './books.component.html',
    styleUrls: ['./books.component.css']
})
export class BooksComponent implements OnInit {

    appConstants = AppConstants;

    books: BookDto[];

    categories: CategoryDto[];

    filterForm: FormGroup;

    submitted: boolean = false;

    page: number = 1;

    totalBook: number;

    bookListCriteriaDto: BookListCriteriaDto = new BookListCriteriaDto();

    constructor(private _bookService: BookService,
                private _categoryService: CategoryService,
                private _cartService: CartService,
                private _toastrService: ToastrService,
                private _formBuilder: FormBuilder) {
    }

    ngOnInit(): void {
        this.initForm();
        this.loadAsyncData();
    }

    private loadAsyncData(): void {
        this.loadBookList();
        this.loadAllCategories();
    }

    private loadBookList() {
        if (localStorage.getItem(LocalStorageKeys.TITLE_KEYWORD)
                && !this.bookListCriteriaDto.title
                && this.submitted == false) {
            this.bookListCriteriaDto.title = localStorage.getItem(LocalStorageKeys.TITLE_KEYWORD);
            localStorage.setItem(LocalStorageKeys.TITLE_KEYWORD, "")
        }

        this._bookService.findChunkWithTitleKeywordAndPriceAndCategory(this.bookListCriteriaDto)
                         .subscribe((value: PaginationResponse<BookDto[]>) => {
                             this.books = getPaginatedData<BookDto[]>(value);
                             this.totalBook = this.books.length;
                         });
    }

    private loadAllCategories() {
        this._categoryService.findAll()
                             .subscribe((value: Response<CategoryDto[]>) => {
                                 this.categories = getData<CategoryDto[]>(value);
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

    addToCart(book: BookDto): void {
        this._cartService.add(book.id, book.price);
        this._toastrService.success('Added to your cart');
    }
}
