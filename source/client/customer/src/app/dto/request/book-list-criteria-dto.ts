import {OrderByDto} from "src/app/dto/order-by-dto";

export class BookListCriteriaDto {

    title: string = "";

    authorId: string = "";

    categoryId: string = "";

    publisherId: string = "";

    minPrice: number;

    maxPrice: number;

    orderBy: OrderByDto = new OrderByDto("title", "ASC");

    page: number = 1;

    size: number = 5;

}
