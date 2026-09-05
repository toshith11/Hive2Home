package com.hive2home.backend.repository;

import com.hive2home.backend.entity.Apiary;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ApiaryRepository extends JpaRepository<Apiary, Long> {
}