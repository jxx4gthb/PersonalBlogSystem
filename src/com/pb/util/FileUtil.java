package com.pb.util;

import java.util.UUID;

public class FileUtil {
    public static String subname(String filename) {
        String s = UUID.randomUUID().toString();
        String substring = filename.substring(filename.lastIndexOf("."));
        return s + substring; //解决重名覆盖：随机字符串+后缀名
    }
}
