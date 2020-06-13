package com.profteam.bookgarden.dom;

import lombok.*;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.constraints.Min;
import java.io.Serializable;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BookLostDetail {
    
    @EmbeddedId
    private BookLostDetailId bookLostDetailId;
    
    @Column
    @Min(1)
    private int amount;
    
    @Column
    private Double cost;
    
    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class BookLostDetailId implements Serializable {
    
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "book_lost_id")
        private BookLost bookLost;
        
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "book_id")
        private Book book;
        
    }
    
}
