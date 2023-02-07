package org.acme;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import io.smallrye.common.constraint.NotNull;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import java.util.List;

@Entity
public class Book extends PanacheEntityBase {

    @NotNull
    @NotBlank
    public String title;
    public String genre;
    @Column(unique = true)
    @NotNull
    @Id
    public String isbn;
    @Column(columnDefinition = "TEXT")
    public String summary;


    public static List<Book> getAll(){
        return listAll();
    }

    public static Book getOne(String isbn){
        return findById(isbn);
    }

}
