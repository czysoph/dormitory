package com.sushe.service;

import com.sushe.mapper.ExchangeMapper;
import com.sushe.entity.Exchange;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;


/**
 * @author  
 * @date
 */
@Service
public class ExchangeService {

    @Autowired
    private ExchangeMapper exchangeMapper;

    public int create(Exchange exchange) {
        return exchangeMapper.create(exchange);
    }

    public int delete(String ids) {
        String[] arr = ids.split(",");
        int row = 0;
        for (String s : arr) {
            if(!StringUtils.isEmpty(s)){
                exchangeMapper.delete(Integer.parseInt(s));
            row++;
            }
        }
        return row;
    }

    public int delete(Integer id) {
        return exchangeMapper.delete(id);
    }

    public int update(Exchange exchange) {
        return exchangeMapper.update(exchange);
    }

    public int updateOut(Exchange exchange) {
        return exchangeMapper.updateOut(exchange);
    }

    public int updateEX(Exchange exchange) {
        return exchangeMapper.updateEX(exchange);
    }

    public int updateSelective(Exchange exchange) {
        return exchangeMapper.updateSelective(exchange);
    }

    public PageInfo<Exchange> query(Exchange exchange) {
        if(exchange != null && exchange.getPage() != null){
            PageHelper.startPage(exchange.getPage(),exchange.getLimit());
        }
        return new PageInfo<Exchange>(exchangeMapper.query(exchange));
    }

    public Exchange detail(Integer id) {
        return exchangeMapper.detail(id);
    }

    public int count(Exchange exchange) {
        return exchangeMapper.count(exchange);
    }
}
