package vn.hcmuaf.fit.drillsell.model;

import org.jetbrains.annotations.Nullable;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

public class Log {
    private int id;
    private int userId;
    private String ip;
    @Nullable
    private Timestamp timeLogin;
    private String statuss;
    private String address;
    private String levels;
    private int SL;

    static Map<Integer, String> leveMapping = new HashMap<>();

    static {
        leveMapping.put(0, "INFO");
        leveMapping.put(1, "ERROR");
        leveMapping.put(2, "WARNING");
        leveMapping.put(3, "DANGER");

    }

    public static int INFO = 0;
    public static  int ERROR = 1;
    public static  int WARNING = 2;
    public static  int DANGER = 3;


    public static Map<Integer, String> getLevel(){
        return leveMapping;
    }

    public Log() {
    }

    public Log(int id, int userId, String ip, @Nullable Timestamp timeLogin, String statuss, String address, String levels, int SL) {
        this.id = id;
        this.userId = userId;
        this.ip = ip;
        this.timeLogin = timeLogin;
        this.statuss = statuss;
        this.address = address;
        this.levels = levels;
        this.SL = SL;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Timestamp getTimeLogin() {
        return timeLogin;
    }

    public void setTimeLogin(Timestamp timeLogin) {
        this.timeLogin = timeLogin;
    }

    public String getStatuss() {
        return statuss;
    }

    public void setStatuss(String statuss) {
        this.statuss = statuss;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLevels() {
        return levels;
    }

    public void setLevels(String levels) {
        this.levels = levels;
    }

    public static Map<Integer, String> getLeveMapping() {
        return leveMapping;
    }

    public static void setLeveMapping(Map<Integer, String> leveMapping) {
        Log.leveMapping = leveMapping;
    }

    public static int getINFO() {
        return INFO;
    }

    public static void setINFO(int INFO) {
        Log.INFO = INFO;
    }

    public static int getERROR() {
        return ERROR;
    }

    public static void setERROR(int ERROR) {
        Log.ERROR = ERROR;
    }

    public static int getWARNING() {
        return WARNING;
    }

    public static void setWARNING(int WARNING) {
        Log.WARNING = WARNING;
    }

    public static int getDANGER() {
        return DANGER;
    }

    public static void setDANGER(int DANGER) {
        Log.DANGER = DANGER;
    }

    public int getSL() {
        return SL;
    }

    public void setSL(int SL) {
        this.SL = SL;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", userId=" + userId +
                ", ip='" + ip + '\'' +
                ", timeLogin=" + timeLogin +
                ", statuss='" + statuss + '\'' +
                ", address='" + address + '\'' +
                ", levels='" + levels + '\'' +
                ", SL=" + SL +
                '}';
    }
}
