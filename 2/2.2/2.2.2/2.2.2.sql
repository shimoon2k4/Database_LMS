USE LMS_Group9;

-- 1. Trigger sau khi INSERT bài đăng
DELIMITER //
CREATE TRIGGER trg_AfterInsert_BaiDang
AFTER INSERT ON BaiDang
FOR EACH ROW
BEGIN
    UPDATE DienDan 
    SET TongSoBaiDang = (SELECT COUNT(*) FROM BaiDang WHERE MaDienDan = NEW.MaDienDan)
    WHERE MaDienDan = NEW.MaDienDan;
END //

-- 2. Trigger sau khi DELETE bài đăng
CREATE TRIGGER trg_AfterDelete_BaiDang
AFTER DELETE ON BaiDang
FOR EACH ROW
BEGIN
    UPDATE DienDan 
    SET TongSoBaiDang = (SELECT COUNT(*) FROM BaiDang WHERE MaDienDan = OLD.MaDienDan)
    WHERE MaDienDan = OLD.MaDienDan;
END //

-- 3. Trigger sau khi UPDATE (di chuyển bài đăng giữa các diễn đàn)
CREATE TRIGGER trg_AfterUpdate_BaiDang
AFTER UPDATE ON BaiDang
FOR EACH ROW
BEGIN
    IF OLD.MaDienDan <> NEW.MaDienDan THEN
        -- Cập nhật diễn đàn cũ
        UPDATE DienDan 
        SET TongSoBaiDang = (SELECT COUNT(*) FROM BaiDang WHERE MaDienDan = OLD.MaDienDan)
        WHERE MaDienDan = OLD.MaDienDan;
        -- Cập nhật diễn đàn mới
        UPDATE DienDan 
        SET TongSoBaiDang = (SELECT COUNT(*) FROM BaiDang WHERE MaDienDan = NEW.MaDienDan)
        WHERE MaDienDan = NEW.MaDienDan;
    END IF;
END //
DELIMITER ;