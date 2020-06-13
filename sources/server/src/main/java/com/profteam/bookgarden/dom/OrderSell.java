package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class OrderSell extends AbstractEntity {
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private Customer customer;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private Employee employee;
    
    @Column
    private LocalDate createdDate;
    
    @OneToMany(mappedBy = "orderSellDetailId.orderSell")
    private List<OrderSellDetail> orderSellDetails = new ArrayList<>();
    
    @OneToMany(mappedBy = "orderSell")
    private List<OrderShipping> orderShippings = new ArrayList<>();
    
}
