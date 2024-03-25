package com.sushe.service;

import com.sushe.mapper.IntentionMapper;
import com.sushe.entity.Intention;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;


/**
 * @author  
 * @date
 */
@Service
public class IntentionService {

    @Autowired
    private IntentionMapper intentionMapper;

    public int create(Intention intention) {
        return intentionMapper.create(intention);
    }

    public int delete(String ids) {
        String[] arr = ids.split(",");
        int row = 0;
        for (String s : arr) {
            if(!StringUtils.isEmpty(s)){
                intentionMapper.delete(Integer.parseInt(s));
                row++;
            }
        }
        return row;
    }


    public int delete(Integer id) {
        return intentionMapper.delete(id);
    }

    public int deleteStu(Integer id) {
        return intentionMapper.deleteStu(id);
    }

    public int update(Intention intention) {
        return intentionMapper.update(intention);
    }

    public int updateSelective(Intention intention) {
        return intentionMapper.updateSelective(intention);
    }

    public PageInfo<Intention> query(Intention intention) {
        if(intention != null && intention.getPage() != null){
            PageHelper.startPage(intention.getPage(),intention.getLimit());
        }
        return new PageInfo<Intention>(intentionMapper.query(intention));
    }

    public Intention detail(Integer id) {
        return intentionMapper.detail(id);
    }

    public int count(Intention intention) {
        return intentionMapper.count(intention);
    }

    public int queryApplicationAmount(Integer roomId) {
        return intentionMapper.queryApplicationAmount(roomId);
    }

}

