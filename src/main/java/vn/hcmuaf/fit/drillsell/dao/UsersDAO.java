package vn.hcmuaf.fit.drillsell.dao;

import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.List;

public class UsersDAO {

    private static UsersDAO instance;

    private UsersDAO() {
    }

    public static UsersDAO getInstance() {
        if (instance == null) instance = new UsersDAO();
        return instance;
    }

    public User getUser(String username, String password) {
        String query = "SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode,isVerified,roleUser FROM users WHERE username = ? AND passwords = ?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, username)
                    .bind(1, password)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }
    }

    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] hash = md.digest();
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean addUser(User newUser) {
        String insertQuery = "INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode, isVerified, roleUser) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(insertQuery)
                    .bind(0, newUser.getFullname())
                    .bind(1, newUser.getAddress())
                    .bind(2, newUser.getPhone())
                    .bind(3, newUser.getEmail())
                    .bind(4, newUser.getUsername())
                    .bind(5, hashPassword(newUser.getPasswords()))
                    .bind(6, newUser.getSex())
                    .bind(7, newUser.getYearOfBirth())
                    .bind(8, newUser.getVerificationCode())
                    .bind(9, newUser.isVerified() ? 1 : 0)  // Chuyển đổi  boolean sang TINYINT
                    .bind(10, newUser.isRoleUser() ? 1 : 0)  // Chuyển đổi  boolean sang TINYINT
                    .execute();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean changePassword(String username, String newPassword) {
        String queryUpdatePass = "UPDATE users SET passwords = ? WHERE username = ?";


        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(queryUpdatePass)
                    .bind(0, hashPassword(newPassword))
                    .bind(1, username)
                    .execute();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean changeInfoUser(User user) {
        deleteUserById(user.getId());
        addUser(user);
        return true;

    }

    public void deleteUserById(int userId) {
        String deleteQuery = "DELETE FROM users WHERE id = ?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(deleteQuery)
                    .bind(0, userId)
                    .execute();
        }
    }

    public static void main(String[] args) {
//        User newUser = new User();
//        newUser.setId(7);
//        newUser.setFullname("admin");
//        newUser.setAddress("VN");
//        newUser.setPhone("6565656");
//        newUser.setEmail("admin@gmail.com");
//        newUser.setUsername("admin");
//        newUser.setPasswords("admin");
//        newUser.setSex("Không");
//        newUser.setYearOfBirth("1990-02-15");
//        newUser.setVerificationCode("123456");
//        newUser.setVerified(true); // Đặt giá trị cho isVerified
//        newUser.setRoleUser(true); // Đặt giá trị cho isRoleUser

        // Gọi phương thức addUser để thêm đối tượng User vào database
//        UserService.getInstance().addUser(newUser);

        System.out.println(UsersDAO.getInstance().hashPassword("123"));

    }


    public boolean isUsernameDuplicate(String username) {
        String selectQuery = "SELECT COUNT(*) FROM users WHERE username = ?";
        Jdbi jdbi = DbConnector.me().get();

        try (Handle handle = jdbi.open()) {
            int count = handle.createQuery(selectQuery)
                    .bind(0, username)
                    .mapTo(Integer.class)
                    .one();

            // Nếu count > 0, tức là username đã tồn tại và là trùng lặp
            return count > 0;
        }
    }

    public String getVerifyCode(String username, String email) {
        String selectQuery = "SELECT verificationCode FROM users WHERE username = ? AND email = ?";
        Jdbi jdbi = DbConnector.me().get();

        try (Handle handle = jdbi.open()) {
            return handle.createQuery(selectQuery)
                    .bind(0, username)
                    .bind(1, email)
                    .mapTo(String.class)
                    .one();
        }
    }

    public List<User> showAll() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode, isVerified, roleUser FROM users")
                    .mapToBean(User.class)
                    .list();
        });
    }

    public User getUserById(int id) {
        String query = "SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode,isVerified,roleUser FROM users WHERE username = ? AND passwords = ?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, id)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }
    }

    public User getUserByUserName(String username) {
        String query = "SELECT id, fullname, email, username FROM users WHERE username = ?  ";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, username)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }
    }
}
