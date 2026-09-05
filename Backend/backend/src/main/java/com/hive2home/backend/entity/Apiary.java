package com.hive2home.backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "apiaries")
public class Apiary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String location;

    @ManyToOne
    @JoinColumn(name = "beekeeper_id", nullable = false)
    private BeekeeperProfile beekeeper;

    public Apiary() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public BeekeeperProfile getBeekeeper() {
        return beekeeper;
    }

    public void setBeekeeper(BeekeeperProfile beekeeper) {
        this.beekeeper = beekeeper;
    }
}