export class Cart {
    items: CartItem[] = [];
}

export class CartItem {
    id: string;
    amount: number;
    price: number;

    constructor(id: string, amount: number, price: number) {
        this.id = id;
        this.amount = amount;
        this.price = price;
    }
}
