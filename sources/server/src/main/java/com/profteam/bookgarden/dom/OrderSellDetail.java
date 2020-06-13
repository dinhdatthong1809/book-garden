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
public class OrderSellDetail {
    
    @EmbeddedId
    private OrderSellDetailId orderSellDetailId;
    
    @Column
    private int amount;
    
    @Column
    private double price;
    
    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class OrderSellDetailId implements Serializable {
        
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "order_sell_id")
        private OrderSell orderSell;
    
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "book_id")
        private Book book;
        
    }
    
}
