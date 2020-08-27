import {OrderByDto} from "../order-by-dto";

export class OrderListCriteriaDto {

    page: number = 1;

    size: number = 5;

    orderBy: OrderByDto = new OrderByDto("id", "DESC");

}
