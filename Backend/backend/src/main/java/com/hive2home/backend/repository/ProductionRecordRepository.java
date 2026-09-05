package com.hive2home.backend.repository;

import com.hive2home.backend.entity.ProductionRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductionRecordRepository
        extends JpaRepository<ProductionRecord, Long> {
}