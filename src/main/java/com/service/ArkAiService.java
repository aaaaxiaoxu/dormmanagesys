package com.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Service
public class ArkAiService {

    private static final MediaType JSON_TYPE = MediaType.parse("application/json; charset=utf-8");

    private final OkHttpClient client = new OkHttpClient.Builder()
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(60, TimeUnit.SECONDS)
            .writeTimeout(60, TimeUnit.SECONDS)
            .build();

    @Value("${ark.api-key:}")
    private String apiKey;

    @Value("${ark.model:ep-20250126163455-8xrmx}")
    private String model;

    @Value("${ark.endpoint:https://ark.cn-beijing.volces.com/api/v3/chat/completions}")
    private String endpoint;

    public String generateReply(String question, String username, String roleName) {
        if (StringUtils.isBlank(question)) {
            return "请先输入你想咨询的问题，我会尽快为你解答。";
        }
        if (StringUtils.isBlank(apiKey) || "YOUR_ARK_API_KEY".equalsIgnoreCase(apiKey)) {
            return "AI客服暂未完成密钥配置，请联系管理员在服务器配置 Ark API Key 后再试。";
        }

        JSONObject body = new JSONObject();
        body.put("model", model);
        body.put("temperature", 0.6);
        body.put("max_tokens", 900);

        JSONArray messages = new JSONArray();
        messages.add(buildMessage("system",
                buildSystemPrompt(roleName)));
        messages.add(buildMessage("user",
                "当前咨询人角色：" + defaultValue(roleName, "访客")
                        + "；用户名：" + defaultValue(username, "未命名用户")
                        + "。\n用户问题：" + question));
        body.put("messages", messages);

        Request request = new Request.Builder()
                .url(endpoint)
                .post(RequestBody.create(JSON_TYPE, body.toJSONString()))
                .addHeader("Authorization", "Bearer " + apiKey)
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (response.body() == null) {
                return "AI客服暂时没有返回内容，请稍后重试。";
            }
            String responseText = response.body().string();
            if (!response.isSuccessful()) {
                return "AI客服调用失败，请稍后重试。";
            }
            JSONObject jsonObject = JSON.parseObject(responseText);
            JSONArray choices = jsonObject.getJSONArray("choices");
            if (choices == null || choices.isEmpty()) {
                return "AI客服暂时没有生成有效回复，请稍后再试。";
            }
            JSONObject firstChoice = choices.getJSONObject(0);
            JSONObject message = firstChoice.getJSONObject("message");
            String content = message == null ? "" : message.getString("content");
            return StringUtils.isBlank(content) ? "AI客服暂时没有生成有效回复，请稍后再试。" : content.trim();
        } catch (IOException e) {
            return "AI客服连接异常，请稍后再试。";
        }
    }

    private JSONObject buildMessage(String role, String content) {
        JSONObject object = new JSONObject();
        object.put("role", role);
        object.put("content", content);
        return object;
    }

    private String buildSystemPrompt(String roleName) {
        String basePrompt = "你是宿舍管理系统的AI客服。"
                + "请围绕宿舍管理业务回答问题，包括宿舍分配、报修、卫生、水电费、出入登记、请假、考勤、公告、系统使用。"
                + "回答要求：语气友好、实用、简洁；优先给出可执行步骤；不要编造不存在的制度、流程或数据；"
                + "如果问题必须人工处理，要明确说明建议联系谁或进入哪个功能模块。";

        String rolePrompt;
        if (isStudentRole(roleName)) {
            rolePrompt = "当前用户是学生端用户。"
                    + "回答应站在学生视角，重点帮助其完成查询、提交申请、发起报修、处理宿舍生活问题。"
                    + "对于权限外内容，不要指导其进行管理员或宿管员专属操作，而是提示联系宿管员或在系统内提交申请。";
        } else if (isDormManagerRole(roleName)) {
            rolePrompt = "当前用户是宿管员端用户。"
                    + "回答应站在宿管员视角，重点帮助其处理宿舍分配、入住/出入宿舍、卫生巡查、学生管理、报修跟进等工作。"
                    + "可适当提示如何核对学生信息、宿舍信息和分配记录，强调规范操作与异常上报。";
        } else if (isAdminRole(roleName)) {
            rolePrompt = "当前用户是管理员端用户。"
                    + "回答应站在管理员视角，重点帮助其进行系统配置、数据管理、宿舍资源统筹、角色权限和全局业务处理。"
                    + "可从全局管理角度给出建议，但不要虚构系统中不存在的菜单或审批制度。";
        } else {
            rolePrompt = "当前用户角色未明确。请使用通用宿舍管理助手口径回答。";
        }
        return basePrompt + rolePrompt;
    }

    private boolean isStudentRole(String roleName) {
        return StringUtils.contains(roleName, "学生");
    }

    private boolean isDormManagerRole(String roleName) {
        return StringUtils.contains(roleName, "宿管");
    }

    private boolean isAdminRole(String roleName) {
        return StringUtils.contains(roleName, "管理员");
    }

    private String defaultValue(String value, String fallback) {
        return StringUtils.isBlank(value) ? fallback : value;
    }
}
