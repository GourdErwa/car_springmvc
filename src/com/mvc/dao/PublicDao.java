package com.mvc.dao;

import org.springframework.jdbc.core.JdbcTemplate;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by lw on 14-3-21.
 * 公用操作数据库方法
 */
public class PublicDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    public List getList(String sql) {
        return jdbcTemplate.queryForList(sql);
    }

    public List getListForObjects(String sql, Object[] objects) {
        return jdbcTemplate.queryForList(sql, objects);
    }

    public int getUpdate(String sql) {
        return jdbcTemplate.update(sql);
    }

    public int[] getUpdateBatch(String[] sqls) {
        return jdbcTemplate.batchUpdate(sqls);
    }

    public int getUpdateForObjects(String sql, Object[] objects) {
        return jdbcTemplate.update(sql, objects);
    }


}
