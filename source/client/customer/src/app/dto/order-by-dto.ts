export class OrderByDto {
    field: string = "title";
    orderEnum: string = "ASC";

    constructor(field, orderEnum) {
        this.field = field;
        this.orderEnum = orderEnum;
    }
}
