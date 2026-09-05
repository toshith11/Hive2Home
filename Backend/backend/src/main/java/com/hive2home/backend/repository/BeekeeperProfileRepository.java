package com.hive2home.backend.repository;

import com.hive2home.backend.entity.BeekeeperProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BeekeeperProfileRepository
        extends JpaRepository<BeekeeperProfile, Long> {
}