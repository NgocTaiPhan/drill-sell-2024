package vn.hcmuaf.fit.drillsell.dao;

import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

public class UsersDAO implements IUserDAO{
    private static UsersDAO instance;

    public UsersDAO() {
    }

    public static UsersDAO getInstance() {
        if (instance == null) instance = new UsersDAO();
        return instance;
    }

    public User getUser(String username, String password) {
        String query = "SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode,roleUser FROM users WHERE username = ? AND passwords = ?";
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
    public Optional<Instant> getLockedUntil(int id) {
        String query = " SELECT locked_until FROM users WHERE id = :id ";
        Jdbi jdbi =DbConnector.me().get();
        try(Handle handle = jdbi.open()){
            return handle.createQuery(query)
                    .bind("id", id)
                    .mapTo(Instant.class)
                    .findOne();
        }

    }

    public User getUserByUsername(String username) {

        String query = "SELECT id, username FROM users WHERE username = ?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, username)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }

    }

    public User getUserByUserNameAndEmail(String username, String email) {

        String query = "SELECT id, fullname, address, phone, email, username, sex, yearOfBirth, verificationCode,roleUser FROM users WHERE username = ? AND email = ? ";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, username).
                    bind(1, email)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }

    }






//     public boolean addUser(User newUser) {
//         String insertQuery = "INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode) VALUES (?, ?,?,?,?,?,?,?,?)";
//         Jdbi jdbi = DbConnector.me().get();
//         try (Handle handle = jdbi.open()) {
//             handle.createUpdate(insertQuery)
//                     .bind(0, newUser.getFullname())
//                     .bind(1, newUser.getAddress())
//                     .bind(2, newUser.getPhone())
//                     .bind(3, newUser.getEmail())
//                     .bind(4, newUser.getUsername())
//                    .bind(5, hashPassword(newUser.getPasswords()))
//                     .bind(6, newUser.getSex())
//                     .bind(7, newUser.getYearOfBirth())
//                     .bind(8, newUser.getVerificationCode())
//                     .execute();
//         } catch (Exception e) {
//             e.printStackTrace();
//             return false;
//         }
//         return true;
//     }


// đổi mật khẩu(mã hóa trước khi cập nhật)
public boolean changePassword(String username, String newPassword) {
    String hashedPassword = UserUtils.hashPassword(newPassword);
    String queryUpdatePass = "UPDATE users SET passwords = ? WHERE username = ?";

        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(queryUpdatePass)
                    .bind(0, UserUtils.hashPassword(newPassword))
                    .bind(1, username)
                    .execute();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
}

//    public boolean changeInfoUser(User user) {
//        deleteUserById(user.getId());
//        addUser(user);
//        return true;
//
//    }

    public void deleteUserById(int userId) {
        String deleteQuery = "DELETE FROM users WHERE id = ?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(deleteQuery)
                    .bind(0, userId)
                    .execute();
        }
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
//    kiểm tra sự tồn tại của email khi đăng ký
    public boolean isEmailExists(String email) {
        String selectQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
        Jdbi jdbi = DbConnector.me().get();

        try (Handle handle = jdbi.open()) {
            int count = handle.createQuery(selectQuery)
                    .bind(0, email)
                    .mapTo(Integer.class)
                    .one();

            // Nếu count > 0, tức là email đã tồn tại và là trùng lặp
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
        return DbConnector.me().get().withHandle(handle -> handle.createQuery("SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode,  roleUser, userStatus FROM users")
                .mapToBean(User.class)
                .list());
    }


    public static User getUserById(int id) {
        String query = "SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode,roleUser FROM users WHERE id=?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, id)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }
    }

    public static User getUser(int id) {
        String query = "SELECT id, fullname, address, phone, email, username, sex, yearOfBirth FROM users WHERE id=?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, id)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        }
    }

    public static User getUsers(int id) {
        String query = "SELECT id, fullname, address, phone, email, username, sex, yearOfBirth FROM users WHERE id=?";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            return handle.createQuery(query)
                    .bind(0, id)
                    .mapToBean(User.class)
                    .findOnly();
        }
    }
    //   show toàn bộ người dùng trong quản lý người dùng
    public List<User> showUser() {
        String sql = "SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode,  roleUser, userStatus FROM users  WHERE userStatus = 0 ";
        return DbConnector.me().get().withHandle(handle -> handle
                .createQuery(sql)
                .mapToBean(User.class).list());
    }
//    Xóa người dùng theo id người dùng
    public boolean deleteUser(int id, int status) {

        final boolean[]  deleted = {false};

        DbConnector.me().get().useHandle(handle -> {
        int rowCount = handle.createUpdate("UPDATE users SET userStatus = :userStatus WHERE id = :id AND roleUser != 1")
                    .bind("userStatus", status)
                    .bind("id", id)
                    .execute();
            deleted[0] = rowCount > 0;
            System.out.println("Người dùng " + id + " thay đổi trạng thái thành : " + status);
        });
        return deleted[0];
    }
    public User getUserById(User user) {
        int id = user.getId();
        DbConnector.me().get().useHandle(handle -> {
            handle.execute("SELECT id, fullname, address, phone, email, username, passwords, sex, yearOfBirth FROM users WHERE id = ?", id);

        });


        return user;

    }
//    lấy thông tin chi tiết người dùng
    public User getDetailUserById() {
        String sqll ="SELECT users.id,users.username,users.email FROM users ";
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery(sqll)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null));

    }

public static long getCountCustomer() {
    return DbConnector.me().get().withHandle(handle ->
            handle.createQuery("SELECT COUNT(users.id) AS countCustomer FROM users")
                    .mapTo(Long.class) // Map the count to a Long
                    .one()
    );
}
// cập nhật người dùng
public void updateUser(User user) {
    int id = user.getId();
    String hashedPassword = user.getPasswords() != null ? UserUtils.hashPassword(user.getPasswords()) : null;
    DbConnector.me().get().useHandle(handle -> {
        handle.createUpdate(
                        "UPDATE users SET fullname = ?, username = ?, email = ?, passwords = COALESCE(?, passwords), address = ?, phone = ?, sex = ?, yearOfBirth = ?, roleUser = ? WHERE id = ?")
                .bind(0, user.getFullname())
                .bind(1, user.getUsername())
                .bind(2, user.getEmail())
                .bind(3, hashedPassword)  // Bind hashedPassword only if not null
                .bind(4, user.getAddress())
                .bind(5, user.getPhone())
                .bind(6, user.getSex())
                .bind(7, user.getYearOfBirth())
                .bind(8, user.isRoleUser() ? 1 : 0)
                .bind(9, id)
                .execute();
    });
}

    public void updateVerifyCode(int id, String verifyCode) {
        DbConnector.me().get().useHandle(handle -> {
            handle.execute(
                    "UPDATE users SET verificationCode = ? WHERE id = ?",
                    verifyCode,
                    id
            );
        });
    }
    public boolean addUser(User newUser,String confirmationCode) {

        String insertQuery = "INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode) VALUES (?, ?,?,?,?,?,?,?,?)";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(insertQuery)
                    .bind(0, newUser.getFullname())
                    .bind(1, newUser.getAddress())
                    .bind(2, newUser.getPhone())
                    .bind(3, newUser.getEmail())
                    .bind(4, newUser.getUsername())
                    .bind(5, UserUtils.hashPassword(newUser.getPasswords()))
                    .bind(6, newUser.getSex())
                    .bind(7, newUser.getYearOfBirth())
                    .bind(8, confirmationCode)
                    .execute();
        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
        return true;
    }
    public boolean AdminaddUser(User newUser,String confirmationCode) {

        String insertQuery = "INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, roleUser, verificationCode) VALUES (?, ?,?,?,?,?,?,?,?,?)";
        Jdbi jdbi = DbConnector.me().get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate(insertQuery)
                    .bind(0, newUser.getFullname())
                    .bind(1, newUser.getAddress())
                    .bind(2, newUser.getPhone())
                    .bind(3, newUser.getEmail())
                    .bind(4, newUser.getUsername())
                    .bind(5, UserUtils.hashPassword(newUser.getPasswords()))
                    .bind(6, newUser.getSex())
                    .bind(7, newUser.getYearOfBirth())
                    .bind(8,newUser.isRoleUser())
                    .bind(9, confirmationCode)
                    .execute();
        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
        return true;
    }
    public static void main(String[] args) {
        System.out.println(getCountCustomer());
    }
}

