package utils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.IOException;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;
import java.util.Map;

public class CloudinaryUtil {
    private static final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", ConfigReader.get("cloudinary.cloud_name"),
            "api_key", ConfigReader.get("cloudinary.api_key"),
            "api_secret", ConfigReader.get("cloudinary.api_secret")
    ));

    public static String uploadFile(InputStream is, String fileName) throws IOException {
        // Đọc toàn bộ InputStream thành byte[]
        byte[] bytes = toByteArray(is);

        // Upload mảng byte lên Cloudinary
        // params có thể thêm public_id = fileName nếu muốn
        @SuppressWarnings("unchecked")
        Map<String, Object> result = cloudinary.uploader().upload(bytes, ObjectUtils.emptyMap());

        return (String) result.get("secure_url");
    }

    private static byte[] toByteArray(InputStream is) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        int nRead;
        byte[] data = new byte[16384]; // 16KB buffer

        while ((nRead = is.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }

        buffer.flush();
        return buffer.toByteArray();
    }
}
