package com.utils;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.ResourceUtils;

public final class UploadFileUtil {
    private static final String UPLOAD_DIR = "upload";

    private UploadFileUtil() {
    }

    public static File getUploadDir() throws IOException {
        File upload = new File(System.getProperty("user.dir"), UPLOAD_DIR);
        if (!upload.exists()) {
            upload.mkdirs();
        }
        return upload;
    }

    public static File findUploadFile(String fileName) throws IOException {
        String normalized = normalizeFileName(fileName);
        if (StringUtils.isBlank(normalized)) {
            return null;
        }

        File external = new File(getUploadDir(), normalized);
        if (external.exists()) {
            return external;
        }

        File classpathUpload = getClasspathUploadDir();
        if (classpathUpload != null) {
            File classpathFile = new File(classpathUpload, normalized);
            if (classpathFile.exists()) {
                return classpathFile;
            }
        }

        return external;
    }

    public static String normalizeFileName(String fileName) {
        if (StringUtils.isBlank(fileName)) {
            return "";
        }
        String normalized = fileName.trim();
        int queryIndex = normalized.indexOf("?");
        if (queryIndex >= 0) {
            normalized = normalized.substring(0, queryIndex);
        }
        try {
            normalized = URLDecoder.decode(normalized, "UTF-8");
        } catch (Exception ignored) {
        }
        normalized = normalized.replace("\\", "/");
        normalized = normalized.replaceFirst("^https?://[^/]+/dormmanagesys/", "");
        normalized = normalized.replaceFirst("^https?://[^/]+/", "");
        normalized = normalized.replaceFirst("^/+", "");
        normalized = normalized.replaceFirst("^dormmanagesys/", "");
        normalized = normalized.replaceFirst("^upload/", "");
        return normalized;
    }

    private static File getClasspathUploadDir() {
        try {
            File staticDir = new File(ResourceUtils.getURL("classpath:static").getPath());
            if (!staticDir.exists()) {
                return null;
            }
            return new File(staticDir, UPLOAD_DIR);
        } catch (Exception e) {
            return null;
        }
    }
}
