export class AbstractResponse<T> {

    response: Response<T>;

}

class Response<T> {

    resultData: T;

    message: string;

    errorCode: number;

    errorData: any;

}

class PaginationResponse<T> {

    list: T[];

    size: number;

}
