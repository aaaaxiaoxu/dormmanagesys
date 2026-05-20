package com.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.ChurususheEntity;
import com.entity.KaoqinxinxiEntity;
import com.entity.QingjiaEntity;
import com.entity.SushefenpeiEntity;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class AttendanceStatService {
    @Autowired
    private SushefenpeiService sushefenpeiService;

    @Autowired
    private ChurususheService churususheService;

    @Autowired
    private QingjiaService qingjiaService;

    @Autowired
    private KaoqinxinxiService kaoqinxinxiService;

    private final SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
    private final SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Transactional
    public int rebuildMonthly(String yuefen) {
        String month = StringUtils.isBlank(yuefen) ? monthFormat.format(new Date()) : yuefen.trim();
        Date monthStart = parseMonthStart(month);
        Date nextMonthStart = nextMonth(monthStart);

        List<SushefenpeiEntity> allocations = sushefenpeiService.selectList(new EntityWrapper<SushefenpeiEntity>());
        Map<String, AttendanceBucket> buckets = new LinkedHashMap<String, AttendanceBucket>();
        for (SushefenpeiEntity allocation : allocations) {
            if (allocation == null || StringUtils.isBlank(allocation.getXueshengxuehao())) {
                continue;
            }
            if (!buckets.containsKey(allocation.getXueshengxuehao())) {
                buckets.put(allocation.getXueshengxuehao(), new AttendanceBucket(allocation, month));
            }
        }
        if (buckets.isEmpty()) {
            return 0;
        }

        EntityWrapper<ChurususheEntity> accessWrapper = new EntityWrapper<ChurususheEntity>();
        accessWrapper.ge("churushijian", monthStart).lt("churushijian", nextMonthStart);
        List<ChurususheEntity> accessList = churususheService.selectList(accessWrapper);
        for (ChurususheEntity access : accessList) {
            if (access == null || access.getChurushijian() == null || StringUtils.isBlank(access.getXueshengxuehao())) {
                continue;
            }
            AttendanceBucket bucket = buckets.get(access.getXueshengxuehao());
            if (bucket == null) {
                continue;
            }
            String day = dayFormat.format(access.getChurushijian());
            if ("出宿".equals(access.getChuruleixing())) {
                bucket.outDays.add(day);
            } else if ("入宿".equals(access.getChuruleixing())) {
                bucket.inDays.add(day);
                if (isLateReturn(access.getChurushijian())) {
                    bucket.lateDays.add(day);
                }
            }
        }

        EntityWrapper<QingjiaEntity> leaveWrapper = new EntityWrapper<QingjiaEntity>();
        leaveWrapper.eq("sfsh", "是").le("qingjia1", nextMonthStart).ge("qingjia2", monthStart);
        List<QingjiaEntity> leaveList = qingjiaService.selectList(leaveWrapper);
        for (QingjiaEntity leave : leaveList) {
            if (leave == null || StringUtils.isBlank(leave.getXueshengxuehao())) {
                continue;
            }
            AttendanceBucket bucket = buckets.get(leave.getXueshengxuehao());
            if (bucket == null) {
                continue;
            }
            bucket.leaveDays.addAll(intersectLeaveDays(leave.getQingjia1(), leave.getQingjia2(), monthStart, nextMonthStart));
        }

        int count = 0;
        for (AttendanceBucket bucket : buckets.values()) {
            for (String day : bucket.outDays) {
                if (!bucket.inDays.contains(day) && !bucket.leaveDays.contains(day)) {
                    bucket.absentDays.add(day);
                }
            }
            upsertAttendance(bucket);
            count++;
        }
        return count;
    }

    public void rebuildAround(Date date) {
        if (date != null) {
            rebuildMonthly(monthFormat.format(date));
        }
    }

    public String monthOf(Date date) {
        return date == null ? monthFormat.format(new Date()) : monthFormat.format(date);
    }

    private void upsertAttendance(AttendanceBucket bucket) {
        EntityWrapper<KaoqinxinxiEntity> wrapper = new EntityWrapper<KaoqinxinxiEntity>();
        wrapper.eq("xueshengxuehao", bucket.studentNo).eq("yuefen", bucket.month);
        List<KaoqinxinxiEntity> existingList = kaoqinxinxiService.selectList(wrapper);
        boolean isNew = existingList == null || existingList.isEmpty();
        KaoqinxinxiEntity entity;
        if (isNew) {
            entity = new KaoqinxinxiEntity();
            entity.setId(new Date().getTime() + Double.valueOf(Math.floor(Math.random() * 1000)).longValue());
        } else {
            entity = existingList.get(0);
        }
        entity.setSushemingcheng(bucket.sushemingcheng);
        entity.setSusheleixing(bucket.susheleixing);
        entity.setSusheloudong(bucket.susheloudong);
        entity.setFangjianhao(bucket.fangjianhao);
        entity.setYuefen(bucket.month);
        entity.setXueshengxuehao(bucket.studentNo);
        entity.setXueshengxingming(bucket.studentName);
        entity.setWanguitianshu(bucket.lateDays.size());
        entity.setQueqintianshu(bucket.absentDays.size());
        entity.setQingjiatianshu(bucket.leaveDays.size());
        entity.setDengjishijian(new Date());
        entity.setBeizhu(buildRemark(bucket));
        if (isNew) {
            kaoqinxinxiService.insert(entity);
        } else {
            kaoqinxinxiService.updateById(entity);
        }
    }

    private String buildRemark(AttendanceBucket bucket) {
        List<String> parts = new ArrayList<String>();
        parts.add("系统自动统计");
        if (!bucket.lateDays.isEmpty()) {
            parts.add("晚归：" + StringUtils.join(bucket.lateDays, "、"));
        }
        if (!bucket.absentDays.isEmpty()) {
            parts.add("未归：" + StringUtils.join(bucket.absentDays, "、"));
        }
        if (!bucket.leaveDays.isEmpty()) {
            parts.add("请假：" + StringUtils.join(bucket.leaveDays, "、"));
        }
        return StringUtils.join(parts, "；");
    }

    private boolean isLateReturn(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.HOUR_OF_DAY) >= 23;
    }

    private List<String> intersectLeaveDays(Date leaveStart, Date leaveEnd, Date monthStart, Date nextMonthStart) {
        List<String> days = new ArrayList<String>();
        if (leaveStart == null || leaveEnd == null) {
            return days;
        }
        Date start = leaveStart.before(monthStart) ? monthStart : leaveStart;
        Date endBoundary = leaveEnd.before(nextMonthStart) ? leaveEnd : previousSecond(nextMonthStart);
        Calendar cursor = Calendar.getInstance();
        cursor.setTime(start);
        resetToDayStart(cursor);
        Calendar end = Calendar.getInstance();
        end.setTime(endBoundary);
        resetToDayStart(end);
        while (!cursor.after(end)) {
            days.add(dayFormat.format(cursor.getTime()));
            cursor.add(Calendar.DATE, 1);
        }
        return days;
    }

    private Date previousSecond(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.SECOND, -1);
        return calendar.getTime();
    }

    private Date parseMonthStart(String yuefen) {
        try {
            return monthFormat.parse(yuefen);
        } catch (ParseException e) {
            throw new IllegalArgumentException("月份格式应为 yyyy-MM");
        }
    }

    private Date nextMonth(Date monthStart) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(monthStart);
        resetToDayStart(calendar);
        calendar.add(Calendar.MONTH, 1);
        return calendar.getTime();
    }

    private void resetToDayStart(Calendar calendar) {
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
    }

    private static class AttendanceBucket {
        private final String month;
        private final String sushemingcheng;
        private final String susheleixing;
        private final String susheloudong;
        private final String fangjianhao;
        private final String studentNo;
        private final String studentName;
        private final Set<String> outDays = new HashSet<String>();
        private final Set<String> inDays = new HashSet<String>();
        private final Set<String> lateDays = new HashSet<String>();
        private final Set<String> absentDays = new HashSet<String>();
        private final Set<String> leaveDays = new HashSet<String>();

        private AttendanceBucket(SushefenpeiEntity allocation, String month) {
            this.month = month;
            this.sushemingcheng = allocation.getSushemingcheng();
            this.susheleixing = allocation.getSusheleixing();
            this.susheloudong = allocation.getSusheloudong();
            this.fangjianhao = allocation.getFangjianhao();
            this.studentNo = allocation.getXueshengxuehao();
            this.studentName = allocation.getXueshengxingming();
        }
    }
}
