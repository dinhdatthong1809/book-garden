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
public class StorageDetail {
    
    @EmbeddedId
    private StorageDetailId storageDetailId;
    
    @Column
    @Min(1)
    private int amount;
    
    @Column
    private Double money;
    
    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class StorageDetailId implements Serializable {
        
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "storage_id")
        private Storage storage;
        
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "book_id")
        private Book book;
        
    }
    
}
