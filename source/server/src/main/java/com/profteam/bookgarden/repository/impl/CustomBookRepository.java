package com.profteam.bookgarden.repository.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.Tuple;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.profteam.bookgarden.dto.BookDto;
import com.profteam.bookgarden.dto.CategoryDto;
import com.profteam.bookgarden.dto.request.ListBestSellerRequestDto;
import com.profteam.bookgarden.dto.request.OrderBy;
import com.profteam.bookgarden.dto.request.SearchAndFilterBookRequestDto;
import com.profteam.bookgarden.dto.response.SearchAndFilterBookResponseDto;
import com.profteam.bookgarden.utils.StringUtil;

@Repository
public class CustomBookRepository {

    @Autowired
    EntityManager entityManager;

//    @SuppressWarnings("unchecked")
//    public List<BookDto> getListBestSeller(ListBestSellerRequestDto request) {
//        List<BookDto> listBook = new ArrayList<>();
//
//        StringBuilder sql = new StringBuilder();
//        sql.append("SELECT                                         ");
//        sql.append("        b.code              AS          code        ,");
//        sql.append("        b.title             AS          title       ,");
//        sql.append("        b.sell_price        AS          sellPrice   ,");
//        sql.append("        b.image             AS          image       ");
//        sql.append("FROM    BOOK b                                      ");
//        sql.append("LEFT JOIN                                           ");
//        sql.append(
//                "        (SELECT b.id AS id, SUM(o.amount) as amount FROM BOOK b JOIN ORDER_SELL_DETAIL o ON b.id = o.book_id GROUP BY b.id) temp ");
//        sql.append("ON      b.id = temp.id                              ");
//        sql.append("ORDER BY temp.amount DESC ");
//        sql.append("offset 0 rows FETCH NEXT :size ROWS ONLY");
//
//        Query query = entityManager.createNativeQuery(sql.toString(), Tuple.class);
//        query.setFirstResult(0);
//        query.setMaxResults(request.getSize());
//
//        List<Tuple> list = query.getResultList();
//        list.stream().forEach(tuple -> {
//            BookDto bookDto = new BookDto();
//            bookDto.setTitle((String) tuple.get("title"));
//            bookDto.setPrice(Double.valueOf(String.valueOf(tuple.get("sellPrice"))));
//            bookDto.setImage((String) tuple.get("image"));
//
//            listBook.add(bookDto);
//        });
//
//        return listBook;
//    }
//
//    @SuppressWarnings("unchecked")
//    public SearchAndFilterBookResponseDto searchAndFilterBook(SearchAndFilterBookRequestDto request) {
//        SearchAndFilterBookResponseDto response = new SearchAndFilterBookResponseDto();
//        int size = 0;
//        List<BookDto> listBook = new ArrayList<>();
//
//        StringBuilder sql = new StringBuilder();
//        sql.append(
//                "SELECT  b.id, b.title, b.amount, b.sell_price, b.image, pb.name as publisher, book_category.name as category ");
//        sql.append("FROM    BOOK b ");
//        sql.append("        JOIN PUBLISHER pb ON b.publisher_id = pb.id ");
//        sql.append(
//                "        JOIN (SELECT bc.book_id, c.name FROM CATEGORY c JOIN BOOK_CATEGORY bc ON bc.category_id = c.id WHERE c.id = :categoryId OR :categoryId IS NULL) book_category ON b.id = book_category.book_id ");
//        sql.append(
//                "        JOIN (SELECT ba.book_id, a.full_name FROM AUTHOR a JOIN BOOK_AUTHOR ba ON ba.book_id = a.id WHERE a.id = :authorId OR :authorId IS NULL) book_author ON b.id = book_author.book_id ");
//        sql.append("WHERE   pb.id = :publisherId OR :publisherId IS NULL ");
//        sql.append("  AND   b.title like :title ");
//        sql.append("ORDER  BY b.id ASC ");
//
//        if (request.getOrderBy() != null && !StringUtil.isNullOrEmpty(request.getOrderBy().getField())) {
//            OrderBy orderBy = request.getOrderBy();
//            sql.append("ORDER BY " + orderBy.getField() + " " + orderBy.getOrderEnum());
//        }
//
//        Query query = entityManager.createNativeQuery(sql.toString(), Tuple.class);
//        query.setParameter("categoryId", request.getCategoryId());
//        query.setParameter("authorId", request.getAuthorId());
//        query.setParameter("publisherId", request.getPublisherId());
//        if (request.getTitle() != null) {
//            query.setParameter("title", "%" + request.getTitle() + "%");
//        } else {
//            query.setParameter("title", "%");
//        }
//
//        size = query.getResultList().size();
//
//        query.setFirstResult(request.getPage());
//        query.setMaxResults(request.getSize());
//
//        List<Tuple> listTuple = query.getResultList();
//        if (!listTuple.isEmpty()) {
//            listBook.add(createNew(listTuple.get(0)));
//            for (int i = 1; i < listTuple.size(); i++) {
//                if (listTuple.get(i - 1).get("id") == listTuple.get(i).get("id")) {
//                    BookDto bookDto = listBook.get(listBook.size() - 1);
//                    listBook.set(listBook.size() - 1, appendInfo(bookDto, listTuple.get(i)));
//                } else {
//                    listBook.add(createNew(listTuple.get(i)));
//                }
//            }
//        }
//
//        response.setList(listBook);
//        response.setTotalElements(size);
//        return response;
//    }
//
//    private BookDto createNew(Tuple tuple) {
//        BookDto bookDto = new BookDto();
//
//        bookDto.setId(tuple.get("id").toString());
//        bookDto.setTitle((String) tuple.get("title"));
//        bookDto.setPrice(Double.valueOf(tuple.get("sell_price").toString()));
//        bookDto.setImage((String) tuple.get("image"));
//        
//        List<CategoryDto> categories = new ArrayList<>();
//        categories.add(new CategoryDto((String)tuple.get("id"), (String) tuple.get("category")));
//        bookDto.setCategories(categories);
//
//        return bookDto;
//    }
//
//    private BookDto appendInfo(BookDto bookDto, Tuple tuple) {
//        List<CategoryDto> categories = bookDto.getCategories();
//        categories.add(new CategoryDto((String)tuple.get("id"), (String) tuple.get("category")));
//
//        return bookDto;
//    }
}
