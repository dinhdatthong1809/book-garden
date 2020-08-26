export class BookDto {
    id: string;
    title: string;
    description: string;
    introduce: string;
    price: number;
    image: string;
    category: Category = new Category();
    author: Author = new Author();
    publisher: Publisher = new Publisher();
}

class Category {
    id: string;
    categoryTitle: string;
}

class Author {
    id: number;
    fullname: string;
}

class Publisher {
    id: number;
    name: string;
}
