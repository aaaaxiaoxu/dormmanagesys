package com.utils;


import org.apache.tools.ant.util.DateUtils;
import org.springframework.lang.Nullable;
import org.springframework.util.Assert;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 对象比较
 */
public class ClazzDiff {






    /**
     * 判断本实体有没有这个字段
     * @param c
     * @param fieldName
     * @return
     */
    public boolean hasField(Class c, String fieldName){
        Field[] fields = c.getDeclaredFields();

        for (Field f : fields) {
            if (fieldName.equals(f.getName())) {
                return true;

            }

        }

        return false;
    }


    public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException {

//        ChengpinEntity chengpinEntity1 = new ChengpinEntity();
//
//        chengpinEntity1.setId(2);
//        chengpinEntity1.setXiaoshourenyuanId(3);
//        chengpinEntity1.setChengpinUuidNumber("4");
//        chengpinEntity1.setChengpinName("6");
//        chengpinEntity1.setChengpinSchool("7");
//        chengpinEntity1.setChengpinLianxifangshi("8");
//        chengpinEntity1.setChengpinXiaoshouJine(9.0);
//        chengpinEntity1.setChengpinTichengJine(10.0);
//        chengpinEntity1.setLunwenTypes(11);
//        chengpinEntity1.setLunwenXiaoshouJine(12.1);
//        chengpinEntity1.setLunwenTichengJine(13.1);
//        chengpinEntity1.setChengpinZhuangtaiTypes(14);
//        chengpinEntity1.setChengpinFile("15");
//        chengpinEntity1.setChengpinText("16");
//        chengpinEntity1.setChengpinDelete(1);
//        chengpinEntity1.setInsertTime(new Date());
//        chengpinEntity1.setUpdateTime(null);
//        chengpinEntity1.setCreateTime(null);
//
//
//
//
//        ChengpinEntity chengpinEntity2 = new ChengpinEntity();
//
//        chengpinEntity2.setId(3);
//        chengpinEntity2.setXiaoshourenyuanId(4);
//        chengpinEntity2.setChengpinUuidNumber("4");
//        chengpinEntity2.setChengpinName("6");
//        chengpinEntity2.setChengpinSchool("7");
//        chengpinEntity2.setChengpinLianxifangshi("8");
//        chengpinEntity2.setChengpinXiaoshouJine(9.0);
//        chengpinEntity2.setChengpinTichengJine(10.0);
//        chengpinEntity2.setLunwenTypes(11);
//        chengpinEntity2.setLunwenXiaoshouJine(12.1);
//        chengpinEntity2.setLunwenTichengJine(13.1);
//        chengpinEntity2.setChengpinZhuangtaiTypes(14);
//        chengpinEntity2.setChengpinFile("16");
//        chengpinEntity2.setChengpinText("16");
//        chengpinEntity2.setChengpinDelete(1);
//        chengpinEntity2.setInsertTime(null);
//        chengpinEntity2.setUpdateTime(new Date());
//        chengpinEntity2.setCreateTime(null);


//        List<String> strings = new ClazzDiff<ChengpinEntity>().ClazzDiffColumn(chengpinEntity1, chengpinEntity2,new String[]{"serialVersionUID"});
//        List<String> strings = new ClazzDiff().ClazzDiffColumn(chengpinEntity1, chengpinEntity2);
//        System.out.println(strings);


    }

}
