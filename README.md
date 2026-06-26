# 🎨 Camera Trace

> Ứng dụng hỗ trợ **vẽ truyền thần**, **can nét (Trace Drawing)** và **phác họa** bằng cách phủ ảnh mẫu lên camera theo thời gian thực.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.22+-02569B?logo=flutter&logoColor=white">
  <img src="https://img.shields.io/badge/Riverpod-State%20Management-FCB900">
  <img src="https://img.shields.io/badge/Clean%20Architecture-Feature%20First-blue">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-success">
</p>

---

# ✨ Tính năng nổi bật

- 📷 Camera Preview thời gian thực
- 🖼️ Chọn ảnh từ thư viện
- ✋ Kéo · Zoom · Xoay ảnh bằng Gesture
- 🔒 Khóa ảnh để tránh thao tác nhầm
- 🎨 Nhiều bộ lọc hỗ trợ can nét
- 🌗 Hỗ trợ giấy sáng và giấy tối
- 📐 Hiển thị lưới căn bố cục
- 💾 Tự động lưu trạng thái làm việc

---

# 📱 Cách sử dụng

```text
Mở ứng dụng
      │
      ▼
Cấp quyền Camera
      │
      ▼
Chọn ảnh từ Gallery
      │
      ▼
Căn chỉnh ảnh
(Drag • Zoom • Rotate)
      │
      ▼
Chọn Filter
      │
      ▼
Khóa ảnh
      │
      ▼
Bắt đầu vẽ
```

---

# 🤏 Gesture

| Gesture | Chức năng |
|----------|-----------|
| 👆 Drag | Di chuyển ảnh |
| 🤏 Pinch | Phóng to / Thu nhỏ |
| 🔄 Rotate | Xoay ảnh |
| 👆👆 Double Tap | Reset vị trí |
| ✋ Long Press | Khóa / Mở khóa |

---

# 🎨 Bộ lọc

| Filter | Mô tả | Phù hợp |
|---------|-------|----------|
| Original | Ảnh gốc | Mọi trường hợp |
| Outline Black | Trích nét màu đen | Giấy trắng |
| Outline White | Trích nét màu trắng | Giấy đen |
| Outline Red | Trích nét đỏ | Độ tương phản cao |
| Grayscale | Ảnh xám | Quan sát chi tiết |
| High Contrast | Tăng tương phản | Ảnh mờ |
| Invert | Đảo màu | Một số ảnh tối |
| Cyan | Phủ xanh | Ánh sáng trắng |
| Amber | Phủ vàng | Ánh sáng lạnh |

---

# 🏗️ Kiến trúc

Dự án sử dụng:

- ✅ Clean Architecture
- ✅ Feature First
- ✅ Riverpod
- ✅ Immutable State
- ✅ Separation of Concerns

```
lib/
│
├── app/
├── core/
├── features/
│   ├── camera/
│   └── overlay/
├── shared/
└── main.dart
```

---

# 📂 Cấu trúc dự án

```text
lib
│
├── app
│   ├── app.dart
│   ├── router.dart
│   └── theme.dart
│
├── core
│   └── services
│
├── features
│   ├── camera
│   │
│   └── overlay
│
├── shared
│   ├── models
│   └── widgets
│
└── main.dart
```

---

# 📦 Packages chính

| Package | Mục đích |
|----------|----------|
| flutter_riverpod | State Management |
| go_router | Navigation |
| camera | Camera Preview |
| image_picker | Chọn ảnh |
| permission_handler | Xin quyền |
| shared_preferences | Lưu trạng thái |
| flutter_animate | Animation |
| google_fonts | Font chữ |
| image | Xử lý ảnh |
| vector_math | Biến đổi ma trận |

---

# 🚀 Cài đặt

## Clone project

```bash
git clone <repo-url>
```

## Cài package

```bash
flutter pub get
```

## Phân tích source

```bash
flutter analyze
```

## Chạy ứng dụng

```bash
flutter run
```

## Chạy test

```bash
flutter test
```

---

# 🧠 Công nghệ

- Flutter 3.22+
- Dart
- Riverpod
- Clean Architecture
- Isolate
- Sobel Edge Detection
- GPU Color Filter

---

# 🛣️ Roadmap

- [ ] Quay Timelapse
- [ ] Điều khiển Flash
- [ ] Điều chỉnh Brightness
- [ ] Điều chỉnh Contrast
- [ ] Lưu Preset Filter
- [ ] Shader GPU cho Outline
- [ ] Xuất ảnh sau khi Trace

---

# 📖 Workflow

```text
Gallery
    │
    ▼
Overlay Image
    │
    ▼
Gesture
    │
    ▼
Image Filter
    │
    ▼
Lock
    │
    ▼
Trace Drawing
```

---

# ❤️ Dành cho

- ✏️ Họa sĩ
- 🎨 Người học vẽ
- 🖌️ Truyền thần
- 📚 Luyện sketch
- 🧑‍🎨 Thiết kế
- 👨‍🏫 Giáo viên mỹ thuật

---

## 📄 License

MIT License