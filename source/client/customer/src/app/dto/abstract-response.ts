export class Response<T> {
    response: {
        resultData: T[];
        message: string;
        errorCode: number;
        errorData: any;
    };
}

export class PaginationResponse<T> {
    response: {
        resultData: {
            list: T[];
            totalElements: number;
        };
        message: string;
        errorCode: number;
        errorData: any;
    };
}

export function getPaginatedData<T>(paginationResponse: PaginationResponse<T>): T[] {
    return paginationResponse.response.resultData.list;
}

export function getDataList<T>(paginationResponse: Response<T>): T[] {
    return paginationResponse.response.resultData;
}
