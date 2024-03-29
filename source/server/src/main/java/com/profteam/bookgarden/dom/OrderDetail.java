
package com.profteam.bookgarden.dom;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class OrderDetail {

    @EmbeddedId
    private Pk pk = new Pk();

    private int amount;

    private double price;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("bookId")
    private Book book;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @MapsId("orderId")
    private Order order;

    @Embeddable
    @Getter
    @Setter
    public static class Pk implements Serializable{

        private static final long serialVersionUID = 1L;

        private String bookId;

        private Long orderId;

    }

}
