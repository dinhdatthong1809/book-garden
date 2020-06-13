package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import com.profteam.bookgarden.dom.enums.OrderRentStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class OrderRent extends AbstractEntity implements Serializable {
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private Customer customer;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private Employee employee;
    
    @Column
    private Double costRent;
    
    @Column
    private Double costExpiration;
    
    @Column
    private Integer expirationDay;
    
    @Column
    private LocalDate createdDate;
    
    @Column
    private LocalDate returnedDate;
    
    @Column
    @NotNull
    @Enumerated(EnumType.STRING)
    private OrderRentStatus status;
    
    @OneToMany(mappedBy = "orderRentDetailId.orderRent")
    List<OrderRentDetail> orderRentDetails = new ArrayList<>();
    
    @OneToMany(mappedBy = "orderRent")
    private List<OrderShipping> orderShippings = new ArrayList<>();
    
}
