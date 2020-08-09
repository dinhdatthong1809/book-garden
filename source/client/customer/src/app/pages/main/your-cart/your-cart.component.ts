import {Component, OnInit} from '@angular/core';
import {Cart, CartItem} from "src/app/dom/cart";
import {CartService} from "src/app/services/cart.service";
import {BookDto} from "src/app/dto/response/book-dto";
import {BookService} from "src/app/services/book.service";
import {getData, Response} from "src/app/dto/abstract-response";
import {BookInCart} from "src/app/dom/book-in-cart";
import {AlertService} from "src/app/services/alert.service";
import {SweetAlertResult} from "sweetalert2";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {AppConstants} from "src/app/constants/app-constants";
import {CartDto} from "src/app/dto/request/cart-dto";

@Component({
    selector: 'app-your-cart',
    templateUrl: './your-cart.component.html',
    styleUrls: ['./your-cart.component.css']
})
export class YourCartComponent implements OnInit {

    cart: Cart;

    bookInCart: BookInCart[] = [];

    totalPrice: number = 0;

    user = {
        id: 1,
        name: "Thong",
        address: "150, Thanh Da Street, HCM City, Vietnam",
        email: "thong1809@gmail.com",
        phone: "0906546948",
    }

    constructor(private _cartService: CartService,
                private _alertService: AlertService,
                private _formBuilder: FormBuilder,
                private _bookService: BookService) {

    }

    ngOnInit(): void {
        this.loadCart();
    }

    loadCart(): void {
        this.cart = this._cartService.getCart();
        this.bookInCart = [];

        this.cart.items.forEach((item: CartItem) => {
            this._bookService.findOne(item.id)
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
                                  this.loadCart();
                              }
                          });
    }

    onSubmit(): void {
        this.calculateTotalPrice();
        let alertMessage = `Thank you for using our service<br>
                            Your total is <strong>${this.totalPrice} VND</strong><br>
                            We will contact you soon, please stay alerted`;

        this._alertService.ask(alertMessage)
                          .then((result: SweetAlertResult) => {
                              if (result.value) {
                                  let cartDto: CartDto = new CartDto(this.cart, this.user.id);
                                  console.log(JSON.stringify(cartDto));

                                  this.clearCart();
                                  this.loadCart();
                              }
                          });
    }

    clearCart(): void {
        this._cartService.clear();
    }

    calculateTotalPrice() {
        this.totalPrice = 0;

        for (let item of this.bookInCart) {
            this.totalPrice += item.book.price * item.amount;
        }
    }

}
