import {Injectable} from '@angular/core';
import {Cart, CartItem} from "src/app/dom/cart";
import {LocalStorageKeys} from "src/app/constants/local-storage-keys";
import {AbstractService} from "src/app/services/abstract.service";
import {Observable} from "rxjs";
import {ApiUrl} from "src/app/constants/api-url";
import {catchError} from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class CartService extends AbstractService {

    private cart: Cart = this.getCart();

    add(id: string, price: number): void {
        for (let item of this.cart.items) {
            if (item.bookId === id) {
                item.amount++;
                this.saveCart();
                return;
            }
        }

        this.cart.items.push(new CartItem(id, 1, price));
        this.saveCart();
    }

    remove(id: string): void {
        for (let i = 0; i < this.cart.items.length; i++) {
            if (this.cart.items[i].bookId === id) {
                this.cart.items.splice(i, 1);
                this.saveCart();
                return;
            }
        }
    }

    clear(): void {
        this.cart = new Cart();
        this.saveCart();
    }

    saveCart(): void {
        localStorage.setItem(LocalStorageKeys.CART, JSON.stringify(this.cart));
    }

    getCart(): Cart {
        if (localStorage.getItem(LocalStorageKeys.CART)) {
            let cart = JSON.parse(localStorage.getItem(LocalStorageKeys.CART));
            return <Cart> cart;
        }

        return new Cart();
    }

    checkout(cart: Cart): Observable<any> {
        return super.post<Cart, any>(ApiUrl.USER_CHECK_OUT, cart, true)
                    .pipe(catchError(super.handleError));
    }

}
