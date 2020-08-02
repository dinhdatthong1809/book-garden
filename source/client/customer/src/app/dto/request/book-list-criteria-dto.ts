export class BookListCriteriaDto {

    titleKeyword: string;

    priceFrom: number;

    priceTo: number;

    category: string = "";

    page: number;

    pageSize: number = 5;

}
