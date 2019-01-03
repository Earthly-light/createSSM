package com.bean;

import lombok.Data;

import javax.persistence.Entity;

@Entity
@Data
public class User {
    private String id;
    private String name;
    private String sex;

}
