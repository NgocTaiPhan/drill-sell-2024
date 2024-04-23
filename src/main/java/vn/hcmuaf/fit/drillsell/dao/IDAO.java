package vn.hcmuaf.fit.drillsell.dao;

public interface IDAO<T> {

public int insert( T t );
public int update( T t );
public int delete( T t );

}
