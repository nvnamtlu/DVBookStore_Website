package vn.fs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.fs.entities.Publisher;

@Repository
public interface PublisherRepository extends JpaRepository<Publisher, Long> {

}
