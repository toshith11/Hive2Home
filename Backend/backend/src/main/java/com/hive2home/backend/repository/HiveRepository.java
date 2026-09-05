package com.hive2home.backend.repository;

import com.hive2home.backend.entity.Hive;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HiveRepository extends JpaRepository<Hive, Long> {
}