from flask import Flask, render_template, request, jsonify
from database import get_db_connection
# pyrefly: ignore [missing-import]
from mysql.connector import Error

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/baitap', methods=['POST'])
def add_baitap():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Gọi thủ tục thay vì viết lệnh INSERT trực tiếp [cite: 1, 58]
        params = (data['MaBT'], data['TenBT'], data['NoiDung'], 
                  data['ThoiHan'], data['TgGH'], data['Diem'], data['MaLop'])
        cursor.callproc('sp_ThemBaiTap', params)
        conn.commit()
        return jsonify({"success": True}), 200
    except Error as e:
        # Trả về thông báo lỗi cụ thể (không ghi chung chung) 
        return jsonify({"error": e.msg}), 400
    finally:
        cursor.close()
        conn.close()

# API Lấy danh sách (Câu 2.3) [cite: 1, 45]
@app.route('/api/list', methods=['GET'])
def list_baitap():
    ma_lop = request.args.get('maLop', '')
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.callproc('sp_TimKiemBaiTap', (ma_lop, ''))
    results = [r.fetchall() for r in cursor.stored_results()][0]
    return jsonify(results)

if __name__ == '__main__':
    app.run(debug=True)