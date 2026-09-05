package com.hive2home.backend.repository;

import com.hive2home.backend.entity.HoneyBatch;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HoneyBatchRepository
        extends JpaRepository<HoneyBatch, Long> {
}