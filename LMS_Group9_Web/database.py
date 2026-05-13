# pyrefly: ignore [missing-import]
import mysql.connector

# Cấu hình dựa trên thông tin từ HeidiSQL
db_config = {
    'host': '127.0.0.1',        # Hostname/IP trong ảnh 
    'user': 'root',             # User được thiết lập là root 
    'password': 'hoangson0852',             # Để trống theo như ô Password trong ảnh 
    'port': 3306,               # Port mặc định là 3306 
    'database': 'LMS_Group9'    # Tên CSDL đã tạo ở các bước trước 
}

def get_db_connection():
    """Tạo và trả về kết nối tới MySQL."""
    return mysql.connector.connect(**db_config)