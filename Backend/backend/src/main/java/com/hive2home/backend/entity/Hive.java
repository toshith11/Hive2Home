package com.hive2home.backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "hives")
public class Hive {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String hiveCode;

    private String status;

    @ManyToOne
    @JoinColumn(name = "apiary_id", nullable = false)
    private Apiary apiary;

    public Hive() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getHiveCode() {
        return hiveCode;
    }

    public void setHiveCode(String hiveCode) {
        this.hiveCode = hiveCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Apiary getApiary() {
        return apiary;
    }

    public void setApiary(Apiary apiary) {
        this.apiary = apiary;
    }
}