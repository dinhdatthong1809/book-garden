export class UserOrderDto {
    id: number;
    dateCreated: string;
    orderDetails: OrderDetailsDto[];
    totalAmount: number;
}

class OrderDetailsDto {
    amount: number;
    price: number;
    book: OrderBookDto
}

class OrderBookDto {
    id: string;
    title: string;
}
