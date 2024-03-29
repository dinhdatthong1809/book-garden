package com.profteam.bookgarden.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.profteam.bookgarden.dom.Book;

@Repository
public interface BookRepository extends JpaRepository<Book, String> {

	Page<Book> findDistinctByTitleContainsAndCategoryIdContainsAndPriceBetweenAndAmountGreaterThan(String title,
			String categoryId, double minPrice, double maxPrice, int amount, Pageable pageable);

	Page<Book> findDistinctByTitleLikeAndCategoryIdLike(String title, String categoryId, double minPrice,
			double maxPrice, Pageable pageable);

}
