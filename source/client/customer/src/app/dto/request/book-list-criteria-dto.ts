export class BookListCriteriaDto {

    titleKeyword: string;

    priceFrom: number;

    priceTo: number;

    category: string;

    // page: number = 1;
    //
    // chunk: number = 5;

    page: number;

    pageSize: number = 5;

}
