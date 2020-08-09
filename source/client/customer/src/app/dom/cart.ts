export class Cart {
    items: CartItem[] = [];
}

export class CartItem {
    bookId: string;
    amount: number;
    price: number;

    constructor(bookId: string, amount: number, price: number) {
        this.bookId = bookId;
        this.amount = amount;
        this.price = price;
    }
}
