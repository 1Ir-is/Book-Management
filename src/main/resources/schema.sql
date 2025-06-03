CREATE TABLE IF NOT EXISTS vai_tro (
                                       ma_vai_tro INT PRIMARY KEY,
                                       ten_vai_tro VARCHAR(50)
    );

CREATE TABLE IF NOT EXISTS nguoi_dung (
                                          ma_nguoi_dung INT AUTO_INCREMENT PRIMARY KEY,
                                          ten VARCHAR(100),
    email VARCHAR(100),
    mat_khau VARCHAR(100),
    so_dien_thoai VARCHAR(20),
    dia_chi VARCHAR(255),
    ma_vai_tro INT,
    avatar_url VARCHAR(255),
    FOREIGN KEY (ma_vai_tro) REFERENCES vai_tro(ma_vai_tro)
    );

CREATE TABLE IF NOT EXISTS danh_muc (
                                        ma_danh_muc INT AUTO_INCREMENT PRIMARY KEY,
                                        ten_danh_muc VARCHAR(100)
    );

CREATE TABLE IF NOT EXISTS sach (
                                    ma_sach INT AUTO_INCREMENT PRIMARY KEY,
                                    ten_sach VARCHAR(255),
    tac_gia VARCHAR(100),
    nha_xuat_ban VARCHAR(100),
    gia DOUBLE,
    mo_ta TEXT,
    ma_danh_muc INT,
    img_url VARCHAR(255),
    nam_xuat_ban INT,
    FOREIGN KEY (ma_danh_muc) REFERENCES danh_muc(ma_danh_muc)
    );

CREATE TABLE IF NOT EXISTS gio_hang (
                                        ma_gio_hang INT AUTO_INCREMENT PRIMARY KEY,
                                        ngay_tao DATE,
                                        ma_nguoi_dung INT,
                                        FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(ma_nguoi_dung)
    );

CREATE TABLE IF NOT EXISTS chi_tiet_gio_hang (
                                                 ma_gio_hang INT,
                                                 ma_sach INT,
                                                 so_luong INT,
                                                 PRIMARY KEY (ma_gio_hang, ma_sach),
    FOREIGN KEY (ma_gio_hang) REFERENCES gio_hang(ma_gio_hang),
    FOREIGN KEY (ma_sach) REFERENCES sach(ma_sach)
    );

CREATE TABLE IF NOT EXISTS don_hang (
                                        ma_don_hang INT AUTO_INCREMENT PRIMARY KEY,
                                        ngay_dat DATE,
                                        trang_thai VARCHAR(50),
    ma_nguoi_dung INT,
    FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(ma_nguoi_dung)
    );

CREATE TABLE IF NOT EXISTS chi_tiet_don_hang (
                                                 ma_don_hang INT,
                                                 ma_sach INT,
                                                 so_luong INT,
                                                 gia DOUBLE,
                                                 PRIMARY KEY (ma_don_hang, ma_sach),
    FOREIGN KEY (ma_don_hang) REFERENCES don_hang(ma_don_hang),
    FOREIGN KEY (ma_sach) REFERENCES sach(ma_sach)
    );


