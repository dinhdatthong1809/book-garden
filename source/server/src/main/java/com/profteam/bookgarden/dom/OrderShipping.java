package com.profteam.bookgarden.dom;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class OrderShipping {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_sell_id")
    private OrderSell orderSell;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_rent_id")
    private OrderRent orderRent;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private Customer customer;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private Employee employee;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_id")
    private Address address;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id")
    private ShippingStatus shippingStatus;
    
    @Column
    @Size(max = 256)
    private String employeeNote;
    
    @Column
    @Size(max = 256)
    private String userNote;
    
    @OneToMany(mappedBy = "orderShipping")
    private List<RatingShipping> ratingShippings = new ArrayList<>();
    
}
