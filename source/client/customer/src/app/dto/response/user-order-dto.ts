export class UserOrderDto {
    dateCreated: string;
    id: number;
    orderDetails: OrderDetailsDto[] = [];
    status: string;
    totalAmount: number;
}

class OrderDetailsDto {
    amount: number;
    price: number;
    book: OrderBookDto = new OrderBookDto();
}

class OrderBookDto {
    id: string;
    title: string;
}
