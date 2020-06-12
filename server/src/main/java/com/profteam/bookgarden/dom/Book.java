package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Book extends AbstractEntity {
    
    @Column
    @Size(max = 50)
    private String code;
    
    @Column
    @NotNull
    @NotBlank
    @Size(max = 100)
    private String title;
    
    @Column
    @Min(1)
    private Integer pageNum;
    
    @Column
    @Min(0)
    private Integer amount;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "publisher_id")
    private Publisher publisher;
    
    @Column
    @Min(0)
    private Integer releaseYear;
    
    @Column
    @Min(0)
    private Double sellPrice;
    
    @Column
    @Size(max = 256)
    private String image;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bookshelf_id")
    private Bookshelf bookshelf;
    
    @Column
    private Boolean rentable;
    
    @Column
    private Boolean buyable;
    
    @Column
    @Min(0)
    private Double rentPrice;
    
    @Column
    @Size(max = 256)
    private String description;
    
    @Column
    @Size(max = 256)
    private String introduce;
    
    @Column
    private LocalDate createdDate;
    
    @OneToMany(mappedBy = "bookCategoryId.book")
    private List<BookCategory> bookCategories = new ArrayList<>();
    
    @OneToMany(mappedBy = "bookAuthorId.book")
    private List<BookAuthor> bookAuthors = new ArrayList<>();
    
    @OneToMany(mappedBy = "bookPublisherId.book")
    private List<BookPublisher> bookPublishers = new ArrayList<>();

}
