import {Component, OnInit} from '@angular/core';
import {Cart, CartItem} from "src/app/dom/cart";
import {CartService} from "src/app/services/cart.service";
import {BookDto} from "src/app/dto/response/book-dto";
import {BookService} from "src/app/services/book.service";
import {getData, Response} from "src/app/dto/abstract-response";
import {BookInCart} from "src/app/dom/book-in-cart";
import {AlertService} from "src/app/services/alert.service";
import {SweetAlertResult} from "sweetalert2";
import {FormBuilder} from "@angular/forms";
import {AuthenticatedService} from "src/app/services/authenticated.service";
import {AppConstants} from "src/app/constants/app-constants";
import {catchError} from "rxjs/operators";
import {throwError} from "rxjs";
import * as HttpStatus from 'http-status-codes';
import {HttpErrorResponse} from "@angular/common/http";
import {UserDto} from "src/app/dto/response/user-dto";
import {ImgService} from "src/app/services/img.service";

@Component({
    selector: 'app-your-cart',
    templateUrl: './your-cart.component.html',
    styleUrls: ['./your-cart.component.css']
})
export class YourCartComponent implements OnInit {

    cart: Cart = new Cart();

    bookInCart: BookInCart[] = [];

    totalPrice: number = 0;

    appConstants = AppConstants;

    user: UserDto = new UserDto();

    constructor(private _cartService: CartService,
                private _alertService: AlertService,
                private _formBuilder: FormBuilder,
                public _authenticatedService: AuthenticatedService,
                private _bookService: BookService,
                private _imgService: ImgService) {

    }

    ngOnInit(): void {
        this.loadAsyncData();
    }

    loadAsyncData(): void {
        this.loadUser();
        this.loadCart();
    }

    loadUser(): void {
        if (this._authenticatedService.isAuthenticated()) {
            this._authenticatedService.getCurrentUser().subscribe((response: Response<UserDto>) => {
                this.user = getData<UserDto>(response);
            });
        }
    }

    loadCart(): void {
        this.cart = this._cartService.getCart();
        this.bookInCart = [];

        let deletedBookIds = [];

        this.cart.items.forEach((item: CartItem) => {
            this._bookService.findOne(item.bookId)
                             .pipe(catchError((error: HttpErrorResponse) => {
                                 if (error.status === HttpStatus.NOT_FOUND) {
                                     deletedBookIds.push(item.bookId);
                                     this._cartService.remove(item.bookId);
                                     this._alertService.warn(`The book with id: ${deletedBookIds} was deleted by our admins`);
                                     return throwError(null);
                                 }
                             }))
                             .subscribe((response: Response<BookDto>) => {
                                 let bookInCart: BookInCart = new BookInCart();
                                 bookInCart.book = getData<BookDto>(response);
                                 bookInCart.amount = item.amount;
                                 this.bookInCart.push(bookInCart);
                                 this.calculateTotalPrice();
                             });
        });
    }

    removeFromCart(book: BookDto): void {
        this._alertService.ask(`You are removing<br>${book.title}`)
                          .then((result: SweetAlertResult) => {
                              if (result.value) {
                                  this._cartService.remove(book.id);
                                  this.loadAsyncData();
                              }
                          });
    }

    validateCart(): boolean {
        for (let i = 0; i < this.bookInCart.length; i++) {
            if (this.bookInCart[i].amount > AppConstants.CART_CAPACITY_PER_ITEM_MAX) {
                return false;
            }
        }

        return true;
    }

    onSubmit(): void {
        if (this.cart.items.length === 0) {
            this._alertService.warn("Your cart is empty");
            return;
        }

        if (this.cart.items.length > AppConstants.CART_CAPACITY_MAX
                || !this.validateCart()) {
            this._alertService.error("The cart was corrupted, so it will be clear, sorry");
            this.clearCart();
            return;
        }

        this.calculateTotalPrice();
        let alertMessage = `Your total is <strong>${Number(this.totalPrice).toLocaleString('en-US')} VND</strong><br>
                            Would you like to create an order now?`;

        this._alertService.ask(alertMessage)
                          .then((result: SweetAlertResult) => {
                              if (result.value) {
                                  this._cartService.checkout(this._cartService.getCart())
                                                   .subscribe(value => {
                                                       this.clearCart();
                                                       this._alertService.success("Thank you for using our service<br>" +
                                                                                  "Please check your <strong><a class='text-decoration-none' href='/your-profile'>order history</a></strong><br>" +
                                                                                  "We will contact you soon");
                                                   });
                              }
                          });
    }

    clearCart(): void {
        this._cartService.clear();
        this.loadAsyncData();
    }

    calculateTotalPrice(): void {
        let result = 0;
        for (let item of this.bookInCart) {
            result += item.book.price * item.amount;
        }

        this.totalPrice = result;
    }

    updateAmount(event: any, id: string): void {
        let newAmount = event.target.value;

        if (newAmount < 1) {
            event.target.value = 1;
            newAmount = 1;
        }

        if (newAmount > AppConstants.CART_CAPACITY_PER_ITEM_MAX) {
            event.target.value = AppConstants.CART_CAPACITY_PER_ITEM_MAX;
            newAmount = AppConstants.CART_CAPACITY_PER_ITEM_MAX;
        }

        this._cartService.updateAmount(id, newAmount);
        this.updateAmountForBookInCart(id, newAmount);
    }

    updateAmountForBookInCart(id: string, newAmount: number): void {
        for (let i = 0; i < this.bookInCart.length; i++) {
            if (this.bookInCart[i].book.id === id) {
                this.bookInCart[i].amount = newAmount;
                this.calculateTotalPrice();
                return;
            }
        }
    }

    getBookImg(image: string): string {
        return this._imgService.getBookImg(image);
    }

    getCartLength(): number {
        return this._cartService.getCartLength();
    }

}
