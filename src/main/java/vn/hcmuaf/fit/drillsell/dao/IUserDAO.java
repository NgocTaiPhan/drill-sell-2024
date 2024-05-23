package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.model.User;

import java.util.List;

public interface IUserDAO {
    List<User> showUser();
  boolean deleteUser(int id);
}
