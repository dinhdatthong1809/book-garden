import {Injectable} from '@angular/core';
import {Cart, CartItem} from "src/app/dom/cart";
import {LocalStorageKeys} from "src/app/constants/local-storage-keys";

@Injectable({
    providedIn: 'root'
})
export class CartService {

    private cart: Cart = this.getCart();

    constructor() {

    }

    add(id: string, price: number): void {
        for (let item of this.cart.items) {
            if (item.id === id) {
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
            if (this.cart.items[i].id === id) {
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

}
