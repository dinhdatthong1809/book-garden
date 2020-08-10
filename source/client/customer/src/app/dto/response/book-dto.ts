export class BookDto {
    id: string;
    title: string;
    description: string;
    price: number;
    image: string;
    category: Category;
    author: Author;
    publisher: Publisher;
}

class Category {
    id: string;
    categoryTitle: string;
}

class Author {
    id: number;
    fullName: string;
}

class Publisher {
    id: number;
    name: string;
}
