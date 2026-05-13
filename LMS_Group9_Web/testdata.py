from database import get_db_connection
from mysql.connector import Error

try:
    # Thử thiết lập kết nối
    connection = get_db_connection()
    
    if connection.is_connected():
        db_info = connection.get_server_info()
        print(f"✅ Kết nối thành công! Phiên bản MySQL: {db_info}")
        
        cursor = connection.cursor()
        cursor.execute("SELECT DATABASE();")
        record = cursor.fetchone()
        print(f"✅ Bạn đang kết nối tới CSDL: {record[0]}")

except Error as e:
    print(f"❌ Lỗi kết nối: {e}")

finally:
    if 'connection' in locals() and connection.is_connected():
        connection.close()
        print("🔌 Đã đóng kết nối an toàn.")