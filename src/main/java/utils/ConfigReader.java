package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigReader {
    private static final Properties props = new Properties();

    static {
        try (InputStream input = ConfigReader.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                throw new RuntimeException("Khong tim thay config.properties trong classpath");
            }
            props.load(input);
        } catch (IOException ex) {
            throw new RuntimeException("Loi khi doc file config.properties", ex);
        }
    }

    public static String get(String key) {
        return props.getProperty(key);
    }
}
