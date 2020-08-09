import {Cart} from "src/app/dom/cart";

export class CartDto {
    cart: Cart;
    userId: number;

    constructor(cart: Cart, userId: number) {
        this.cart = cart;
        this.userId = userId;
    }
}
