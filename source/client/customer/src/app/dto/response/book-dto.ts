export class BookDto {
    id: number;
    title: string;
    description: string;
    price: number;
    image: string;
    categories: Categories[];
    authors: Authors[];
    publisher: Publisher;
}

class Categories {
    id: string;
    categoryTitle: string;
}

class Authors {
    id: number;
    fullName: string;
}

class Publisher {
    id: number;
    name: string;
}