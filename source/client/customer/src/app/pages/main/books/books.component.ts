import {Component, OnInit} from '@angular/core';
import {BookService} from "src/app/services/book.service";
import {BookDto} from "src/app/dto/response/book-dto";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {BookListCriteriaDto} from "src/app/dto/request/book-list-criteria-dto";
import {AppConstants} from "src/app/constants/app-constants";
import {getData, getPaginatedData, getPaginatedTotalElements, PaginationResponse, Response} from "src/app/dto/abstract-response";
import {LocalStorageKeys} from "src/app/constants/local-storage-keys";
import {CategoryService} from "src/app/services/category.service";
import {CategoryDto} from "src/app/dto/response/category-dto";
import {CartService} from "src/app/services/cart.service";
import {ToastrService} from "ngx-toastr";
import {ImgService} from "src/app/services/img.service";

@Component({
    selector: 'app-books',
    templateUrl: './books.component.html',
    styleUrls: ['./books.component.css']
})
export class BooksComponent implements OnInit {

    appConstants = AppConstants;

    books: BookDto[] = [];

    categories: CategoryDto[];

    filterForm: FormGroup;

    submitted: boolean = false;

    page: number = 1;

    totalBook: number = 0;

    pageSizes: number[] = [5, 10, 15];

    bookListCriteriaDto: BookListCriteriaDto = new BookListCriteriaDto();

    constructor(private _bookService: BookService,
                private _categoryService: CategoryService,
                private _cartService: CartService,
                private _toastrService: ToastrService,
                private _formBuilder: FormBuilder,
                private _imgService: ImgService) {
    }

    ngOnInit(): void {
        this.initForm();
        this.loadAsyncData();
    }

    private loadAsyncData(): void {
        this.loadBookList();
        this.loadAllCategories();
    }

    private loadBookList(): void {
        if (localStorage.getItem(LocalStorageKeys.TITLE_KEYWORD)
                && !this.bookListCriteriaDto.title
                && this.submitted == false) {
            this.bookListCriteriaDto.title = localStorage.getItem(LocalStorageKeys.TITLE_KEYWORD);
            localStorage.setItem(LocalStorageKeys.TITLE_KEYWORD, "")
        }

        this._bookService.findChunkWithTitleKeywordAndPriceAndCategory(this.bookListCriteriaDto)
                         .subscribe((paginationResponse: PaginationResponse<BookDto[]>) => {
                             this.books = getPaginatedData<BookDto[]>(paginationResponse);
                             this.totalBook = getPaginatedTotalElements(paginationResponse);
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
        this.bookListCriteriaDto.page = page;
        this.loadAsyncData();
    }

    addToCart(book: BookDto): void {
        if (this._cartService.reachMaxItem(book.id)) {
            this._toastrService.warning(`You can only buy ${AppConstants.CART_CAPACITY_PER_ITEM_MAX} per type of book`);
            return;
        }

        if (this._cartService.reachMax() && !this._cartService.contains(book.id)) {
            this._toastrService.warning(`You can not add more than ${AppConstants.CART_CAPACITY_MAX} types of book in cart`);
            return;
        }

        this._cartService.add(book.id, book.price);
        this._toastrService.success("Added to your cart");
    }

    changePageSize(): void {
        this.loadAsyncData();
    }

    getBookImg(image: string): string {
        return this._imgService.getBookImg(image);
    }

}
