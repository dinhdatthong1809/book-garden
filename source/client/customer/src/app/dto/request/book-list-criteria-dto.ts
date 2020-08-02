import {OrderByDto} from "src/app/dto/order-by-dto";

export class BookListCriteriaDto {

    title: string = "";

    authorId: string = "";

    categoryId: string = "";

    publisherId: string = "";

    minPrice: number = 0;

    maxPrice: number = 0;

    orderBy: OrderByDto = new OrderByDto();

    page: number = 1;

    size: number = 5;

}
