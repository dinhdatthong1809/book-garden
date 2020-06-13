package com.profteam.bookgarden.dom;

import lombok.*;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class OrderRentDetail {
    
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
