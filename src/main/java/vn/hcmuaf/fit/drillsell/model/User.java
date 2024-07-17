package vn.hcmuaf.fit.drillsell.model;

import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.util.List;
import java.util.stream.Collectors;

public class
User {
    private int id, countCustomer;
    private String fullname,

    address,
            phone,
            email,
            username,
            passwords,

            yearOfBirth,
            verificationCode;
    private boolean sex;
    private boolean isVerified, roleUser;

    public User() {
    }

    public User(String id, String name, String email) {
//        this.id = id;
        this.fullname = name;
        this.email = email;
    }

    public User(String username, String passwords) {
        this.username = username;
        this.passwords = passwords;
    }


    public User(int id, int countCustomer, String fullname, String address, String phone, String email, String username, String passwords, String yearOfBirth, String verificationCode, boolean sex, boolean isVerified, boolean roleUser) {
        this.id = id;
        this.countCustomer = countCustomer;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.username = username;
        this.passwords = passwords;
        this.yearOfBirth = yearOfBirth;
        this.verificationCode = verificationCode;
        this.sex = sex;
        this.isVerified = isVerified;
        this.roleUser = roleUser;
    }

    public User(String fullname, String address, String phone, String email, String username, String passwords, boolean sex, String yearOfBirth) {
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.username = username;
        this.passwords = passwords;
        this.sex = sex;
        this.yearOfBirth = yearOfBirth;

    }

    public User(String fullname, String address, String phone, String email, String username, String passwords, boolean gender, String yearOfBirth, String verificationCode) {
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.username = username;
        this.passwords = passwords;
        this.sex = gender;
        this.yearOfBirth = yearOfBirth;
        this.verificationCode = verificationCode;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswords() {
        return passwords;
    }

    public void setPasswords(String passwords) {
        this.passwords = passwords;
    }

    public boolean getSex() {
        return sex;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public String getYearOfBirth() {
        return yearOfBirth;
    }

    public void setYearOfBirth(String yearOfBirth) {
        this.yearOfBirth = yearOfBirth;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public boolean isRoleUser() {
        return roleUser;
    }

    public void setRoleUser(boolean roleUser) {
        this.roleUser = roleUser;
    }

    public int getCountCustomer() {
        return countCustomer;
    }

    public void setCountCustomer(int countCustomer) {
        this.countCustomer = countCustomer;
    }

    public boolean isSex() {
        return sex;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", countCustomer=" + countCustomer +
                ", fullname='" + fullname + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", passwords='" + passwords + '\'' +
                ", yearOfBirth='" + yearOfBirth + '\'' +
                ", verificationCode='" + verificationCode + '\'' +
                ", sex=" + sex +
                ", isVerified=" + isVerified +
                ", roleUser=" + roleUser +
                '}';
    }

    public static void main(String[] args) {
        List<User> users = DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("select users.username from users ").mapToBean(User.class).collect(Collectors.toList());
        });


        System.out.println(users);

    }



}

