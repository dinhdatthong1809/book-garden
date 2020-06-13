package com.profteam.bookgarden.dom;

import lombok.*;
import lombok.experimental.SuperBuilder;
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
@SuperBuilder
public class BookLostDetail implements Serializable {
    
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
