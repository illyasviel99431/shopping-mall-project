package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Product;

public class ProductRepository {

    private static ProductRepository instance =
            new ProductRepository();


    public static ProductRepository getInstance() {
        return instance;
    }


    // 생성자는 비워둔다.
    // 이제 상품을 Java 코드에서 직접 생성하지 않는다.
    private ProductRepository() {
    }


    // =========================================================
    // 전체 상품 조회
    // =========================================================
    public ArrayList<Product> getAllProducts() {

        ArrayList<Product> listOfProducts =
                new ArrayList<Product>();

        String sql =
                "SELECT p_id, p_name, p_unitPrice, p_description, "
                + "p_manufacturer, p_category, p_unitsInStock, "
                + "p_condition, p_fileName, p_quantity "
                + "FROM product_illya "
                + "ORDER BY p_id";


        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(
                        rs.getString("p_id")
                );

                product.setPname(
                        rs.getString("p_name")
                );

                product.setUnitPrice(
                        rs.getInt("p_unitPrice")
                );

                product.setDescription(
                        rs.getString("p_description")
                );

                product.setManufacturer(
                        rs.getString("p_manufacturer")
                );

                product.setCategory(
                        rs.getString("p_category")
                );

                product.setUnitsInStock(
                        rs.getLong("p_unitsInStock")
                );

                product.setCondition(
                        rs.getString("p_condition")
                );

                product.setFilename(
                        rs.getString("p_fileName")
                );

                product.setQuantity(
                        rs.getInt("p_quantity")
                );

                listOfProducts.add(product);
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "상품 조회 중 DB 오류가 발생했습니다.",
                    e
            );
        }

        return listOfProducts;
    }


    // =========================================================
    // 상품 검색
    // 상품명 / 설명 / 제조사 / 카테고리 / 상품ID 검색
    // =========================================================
    public ArrayList<Product> searchProducts(String keyword) {

        ArrayList<Product> listOfProducts =
                new ArrayList<Product>();

        String sql =
                "SELECT p_id, p_name, p_unitPrice, p_description, "
                + "p_manufacturer, p_category, p_unitsInStock, "
                + "p_condition, p_fileName, p_quantity "
                + "FROM product_illya "
                + "WHERE UPPER(p_id) LIKE UPPER(?) "
                + "OR UPPER(p_name) LIKE UPPER(?) "
                + "OR UPPER(p_description) LIKE UPPER(?) "
                + "OR UPPER(p_manufacturer) LIKE UPPER(?) "
                + "OR UPPER(p_category) LIKE UPPER(?) "
                + "ORDER BY p_id";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                    conn.prepareStatement(sql)
        ) {

            String searchText =
                    "%" + keyword.trim() + "%";

            pstmt.setString(1, searchText);
            pstmt.setString(2, searchText);
            pstmt.setString(3, searchText);
            pstmt.setString(4, searchText);
            pstmt.setString(5, searchText);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {

                    Product product = new Product();

                    product.setProductId(
                            rs.getString("p_id")
                    );

                    product.setPname(
                            rs.getString("p_name")
                    );

                    product.setUnitPrice(
                            rs.getInt("p_unitPrice")
                    );

                    product.setDescription(
                            rs.getString("p_description")
                    );

                    product.setManufacturer(
                            rs.getString("p_manufacturer")
                    );

                    product.setCategory(
                            rs.getString("p_category")
                    );

                    product.setUnitsInStock(
                            rs.getLong("p_unitsInStock")
                    );

                    product.setCondition(
                            rs.getString("p_condition")
                    );

                    product.setFilename(
                            rs.getString("p_fileName")
                    );

                    product.setQuantity(
                            rs.getInt("p_quantity")
                    );

                    listOfProducts.add(product);
                }
            }

        } catch (Exception e) {

            throw new RuntimeException(
                    "상품 검색 중 DB 오류가 발생했습니다.",
                    e
            );
        }

        return listOfProducts;
    }


    // =========================================================
    // 상품 하나 조회
    // =========================================================
    public Product getProductById(String productId) {

        Product product = null;

        String sql =
                "SELECT p_id, p_name, p_unitPrice, p_description, "
                + "p_manufacturer, p_category, p_unitsInStock, "
                + "p_condition, p_fileName, p_quantity "
                + "FROM product_illya "
                + "WHERE p_id = ?";


        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                    conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, productId);


            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    product = new Product();

                    product.setProductId(
                            rs.getString("p_id")
                    );

                    product.setPname(
                            rs.getString("p_name")
                    );

                    product.setUnitPrice(
                            rs.getInt("p_unitPrice")
                    );

                    product.setDescription(
                            rs.getString("p_description")
                    );

                    product.setManufacturer(
                            rs.getString("p_manufacturer")
                    );

                    product.setCategory(
                            rs.getString("p_category")
                    );

                    product.setUnitsInStock(
                            rs.getLong("p_unitsInStock")
                    );

                    product.setCondition(
                            rs.getString("p_condition")
                    );

                    product.setFilename(
                            rs.getString("p_fileName")
                    );

                    product.setQuantity(
                            rs.getInt("p_quantity")
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return product;
    }


    // =========================================================
    // 상품 등록
    // =========================================================
    public boolean addProduct(Product product) {

        String sql =
                "INSERT INTO product_illya "
                + "(p_id, p_name, p_unitPrice, p_description, "
                + "p_manufacturer, p_category, p_unitsInStock, "
                + "p_condition, p_fileName, p_quantity) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                    conn.prepareStatement(sql)
        ) {

            pstmt.setString(
                    1,
                    product.getProductId()
            );

            pstmt.setString(
                    2,
                    product.getPname()
            );

            pstmt.setInt(
                    3,
                    product.getUnitPrice()
            );

            pstmt.setString(
                    4,
                    product.getDescription()
            );

            pstmt.setString(
                    5,
                    product.getManufacturer()
            );

            pstmt.setString(
                    6,
                    product.getCategory()
            );

            pstmt.setLong(
                    7,
                    product.getUnitsInStock()
            );

            pstmt.setString(
                    8,
                    product.getCondition()
            );

            pstmt.setString(
                    9,
                    product.getFilename()
            );

            pstmt.setInt(
                    10,
                    product.getQuantity()
            );

            int result =
                    pstmt.executeUpdate();

            return result > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // 상품 수정
    // =========================================================
    public void updateProduct(Product product) {

        String sql =
                "UPDATE product_illya SET "
                + "p_name = ?, "
                + "p_unitPrice = ?, "
                + "p_description = ?, "
                + "p_manufacturer = ?, "
                + "p_category = ?, "
                + "p_unitsInStock = ?, "
                + "p_condition = ?, "
                + "p_fileName = ?, "
                + "p_quantity = ? "
                + "WHERE p_id = ?";


        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                    conn.prepareStatement(sql)
        ) {

            pstmt.setString(
                    1,
                    product.getPname()
            );

            pstmt.setInt(
                    2,
                    product.getUnitPrice()
            );

            pstmt.setString(
                    3,
                    product.getDescription()
            );

            pstmt.setString(
                    4,
                    product.getManufacturer()
            );

            pstmt.setString(
                    5,
                    product.getCategory()
            );

            pstmt.setLong(
                    6,
                    product.getUnitsInStock()
            );

            pstmt.setString(
                    7,
                    product.getCondition()
            );

            pstmt.setString(
                    8,
                    product.getFilename()
            );

            pstmt.setInt(
                    9,
                    product.getQuantity()
            );

            pstmt.setString(
                    10,
                    product.getProductId()
            );

            pstmt.executeUpdate();

        } catch (Exception e) {

            throw new RuntimeException(
                    "상품 수정 중 오류가 발생했습니다.",
                    e
            );
        }
    }


    // =========================================================
    // 결제 완료 시 장바구니 수량만큼 재고 차감
    // 모든 상품을 하나의 트랜잭션으로 처리하여
    // 부분 차감을 방지합니다.
    // =========================================================
    public void completePurchase(List<Product> cartList) {

        if (cartList == null || cartList.isEmpty()) {
            return;
        }

        Connection conn = null;

        try {

            conn = DBConnection.getConnection();

            conn.setAutoCommit(false);


            String sql =
                    "UPDATE product_illya "
                    + "SET p_unitsInStock = "
                    + "p_unitsInStock - ? "
                    + "WHERE p_id = ? "
                    + "AND p_unitsInStock >= ?";


            try (
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
            ) {

                for (Product product : cartList) {

                    int quantity =
                            product.getQuantity();


                    if (quantity <= 0) {

                        throw new IllegalArgumentException(
                                "상품 수량이 올바르지 않습니다."
                        );
                    }


                    pstmt.setInt(
                            1,
                            quantity
                    );

                    pstmt.setString(
                            2,
                            product.getProductId()
                    );

                    pstmt.setInt(
                            3,
                            quantity
                    );


                    int updated =
                            pstmt.executeUpdate();


                    if (updated != 1) {

                        throw new IllegalStateException(
                                "재고가 부족하거나 존재하지 않는 상품입니다: "
                                + product.getProductId()
                        );
                    }
                }
            }


            conn.commit();

        } catch (Exception e) {

            if (conn != null) {

                try {

                    conn.rollback();

                } catch (Exception rollbackException) {

                    rollbackException.printStackTrace();
                }
            }


            throw new RuntimeException(
                    "결제 처리 중 재고 차감에 실패했습니다.",
                    e
            );

        } finally {

            if (conn != null) {

                try {

                    conn.setAutoCommit(true);

                    conn.close();

                } catch (Exception closeException) {

                    closeException.printStackTrace();
                }
            }
        }
    }


    // =========================================================
    // 상품 삭제
    // =========================================================
    public void deleteProduct(String productId) {

        String sql =
                "DELETE FROM product_illya "
                + "WHERE p_id = ?";


        try (
            Connection conn =
                    DBConnection.getConnection();

            PreparedStatement pstmt =
                    conn.prepareStatement(sql)
        ) {

            pstmt.setString(
                    1,
                    productId
            );

            pstmt.executeUpdate();

        } catch (Exception e) {

            throw new RuntimeException(
                    "상품 삭제 중 오류가 발생했습니다.",
                    e
            );
        }
    }
}