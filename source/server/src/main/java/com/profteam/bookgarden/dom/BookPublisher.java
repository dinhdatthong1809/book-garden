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
public class BookPublisher {
    
    @EmbeddedId
    private BookPublisherId bookPublisherId;
    
    @Version
    private int version;
    
    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class BookPublisherId implements Serializable {
        
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "book_id")
        private Book book;
        
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "publisher_id")
        private Publisher publisher;
        
    }

}
