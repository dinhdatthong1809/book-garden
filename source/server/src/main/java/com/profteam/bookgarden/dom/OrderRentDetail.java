package com.profteam.bookgarden.dom;

import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class OrderRentDetail implements Serializable {
    
    @EmbeddedId
    private OrderRentDetailId orderRentDetailId;
    
    @Column
    private int amount;
    
    @Column
    private Double money;
    
    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class OrderRentDetailId implements Serializable {
    
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "order_rent_id")
        private OrderRent orderRent;
    
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "book_id")
        private Book book;
        
    }
    
}
