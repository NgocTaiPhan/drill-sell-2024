package vn.hcmuaf.fit.drillsell.db;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;

public class DbConnector {

    private static final DbConnector instance = new DbConnector();
    private Jdbi jdbi;

    public static DbConnector me() {
        return instance;
    }

    private DbConnector() {
    }

    public Jdbi get() {
        if (jdbi == null) connect();
        return jdbi;
    }

    private void connect() {
        MysqlDataSource dataSource = new MysqlDataSource();
        System.out.println("jdbc:mysql://" + Db.host + ":" + Db.port + "/" + Db.dbName);
        dataSource.setURL("jdbc:mysql://" + Db.host + ":" + Db.port + "/" + Db.dbName);
        dataSource.setUser(Db.username);
        dataSource.setPassword(Db.password);
        try {
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);
        } catch (SQLException e) {
            System.out.println("Not found database");
            throw new RuntimeException();
        }
        jdbi = Jdbi.create(dataSource);
        System.out.println("Connect successfull to : " + Db.dbName);
    }


    public static void main(String[] args) {
        DbConnector.me().connect();

    }

}
