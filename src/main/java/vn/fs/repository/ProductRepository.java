package vn.fs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.fs.entities.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

	// List product by category
	@Query(value = "SELECT * FROM products WHERE category_id = ?", nativeQuery = true)
	public List<Product> listProductByCategory(Long categoryId);
	
	// List product by author
	@Query(value = "SELECT * FROM products WHERE author_id = ?", nativeQuery = true)
	public List<Product> listProductByAuthor(Long authorId);
	
	// List product by publisher
	@Query(value = "SELECT * FROM products WHERE publisher_id = ?", nativeQuery = true)
	public List<Product> listProductByPublisher(Long publisherId);

	// Top 10 product by category
	@Query(value = "SELECT * FROM products AS b WHERE b.category_id = ?;", nativeQuery = true)
	List<Product> listProductByCategory10(Long categoryId);
	
	// Top 10 product by author
	@Query(value = "SELECT * FROM products AS b WHERE b.author_id = ?;", nativeQuery = true)
	List<Product> listProductByAuthor10(Long authorId);
	
	// Top 10 product by publisher
	@Query(value = "SELECT * FROM products AS b WHERE b.publisher_id = ?;", nativeQuery = true)
	List<Product> listProductByPublisher10(Long publisherId);
	
	// List product new
	@Query(value = "SELECT * FROM products ORDER BY entered_date DESC limit 20;", nativeQuery = true)
	public List<Product> listProductNew20();
	
	// Search Product
	@Query(value = "SELECT * FROM products WHERE product_name LIKE %?1%" , nativeQuery = true)
	public List<Product> searchProduct(String productName);
	
	// count quantity each category
	@Query(value = "SELECT c.category_id,c.category_name,\r\n"
			+ "COUNT(*) AS SoLuong\r\n"
			+ "FROM products p\r\n"
			+ "JOIN categories c ON p.category_id = c.category_id\r\n"
			+ "GROUP BY c.category_name;" , nativeQuery = true)
	List<Object[]> listCategoryByProductName();
	
	// count quantity each publisher
	@Query(value = "SELECT c.publisher_id,c.publisher_name,\r\n"
			+ "COUNT(*) AS SoLuong\r\n"
			+ "FROM products p\r\n"
			+ "JOIN publishs c ON p.publisher_id = c.publisher_id\r\n"
			+ "GROUP BY c.publisher_name" , nativeQuery = true)
	List<Object[]> listPublisherByProductName();
	
	// count quantity each author
	@Query(value = "SELECT c.author_id,c.author_name,\r\n"
			+ "COUNT(*) AS SoLuong\r\n"
			+ "FROM products p\r\n"
			+ "JOIN authors c ON p.author_id = c.author_id\r\n"
			+ "GROUP BY c.author_name;" , nativeQuery = true)
	List<Object[]> listAuthorByProductName();
	
	// Top 20 product best sale
	@Query(value = "SELECT p.product_id,\r\n"
			+ "COUNT(*) AS SoLuong\r\n"
			+ "FROM order_details p\r\n"
			+ "JOIN products c ON p.product_id = c.product_id\r\n"
			+ "GROUP BY p.product_id\r\n"
			+ "ORDER by SoLuong DESC limit 20;", nativeQuery = true)
	public List<Object[]> bestSaleProduct20();
	
	@Query(value = "select * from products o where product_id in :ids", nativeQuery = true)
	List<Product> findByInventoryIds(@Param("ids") List<Integer> listProductId);

}
