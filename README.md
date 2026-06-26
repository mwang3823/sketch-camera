# 🎨 Camera Trace - Ứng dụng Hỗ trợ Vẽ truyền thần & Can nét chuyên nghiệp

[![Flutter](https://img.shields.io/badge/Flutter-v3.22+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State--Management-Riverpod-FCB900?logo=dart&logoColor=white)](https://riverpod.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean--Architecture-blue)](https://clean-architecture.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey)](#)

**Camera Trace** là một ứng dụng di động cao cấp được thiết kế dành cho các họa sĩ và người yêu thích hội họa, giúp can nét (trace) các đối tượng thực tế hoặc tranh vẽ bằng cách phủ một hình ảnh tham chiếu lên trên luồng camera trực tiếp của thiết bị.

Ứng dụng được xây dựng dựa trên các nguyên tắc **Clean Architecture** (Kiến trúc Sạch) kết hợp với **Riverpod** để quản lý trạng thái hiệu năng cao, mượt mà và cực kỳ tin cậy.

---

## 📸 Quy trình Hoạt động chính (Workflow)

1. **Khởi động & Cấp quyền:** Ứng dụng kiểm tra và yêu cầu quyền sử dụng Camera và Thư viện ảnh. Giao diện camera trực tiếp mở ra ngay khi quyền được chấp thuận.
2. **Nhập ảnh mẫu (Gallery):** Người dùng bấm nút Thư viện ở thanh công cụ dưới để chọn ảnh vẽ mẫu (PNG, JPEG, WEBP). Lịch sử ảnh nhập được tự động lưu lại.
3. **Căn chỉnh lớp phủ:** Sử dụng các thao tác cử chỉ kéo rê, thu phóng, xoay, lật gương để điều chỉnh ảnh mẫu khớp với vật thể thực tế qua camera.
4. **Áp dụng Bộ lọc & Căn tỷ lệ:** Chọn bộ lọc phù hợp (ví dụ: Nét vẽ Đen khi vẽ trên giấy sáng màu, hoặc Nét vẽ Đỏ để tăng độ tương phản) và chọn chế độ vừa màn hình (Fit) hoặc tràn viền (Fill).
5. **Khóa hình ảnh (Lock):** Khóa toàn bộ cử chỉ vuốt chạm để cố định hình ảnh mẫu, tránh các va chạm vô ý trong lúc đặt điện thoại lên giá đỡ và vẽ.
6. **Vẽ truyền thần:** Nhìn qua màn hình điện thoại vào tờ giấy thực tế bên dưới và thực hiện các nét vẽ theo đường viền mẫu một cách chuẩn xác.

---

## 🎮 Hướng dẫn Thao tác Cử chỉ (Gestures Guide)

| Cử chỉ (Gestures) | Hành động (Action) | Ghi chú (Note) |
| :--- | :--- | :--- |
| **Vuốt 1 ngón tay** | Di chuyển lớp phủ ảnh | Kéo ảnh mẫu đến bất kỳ vị trí nào trên màn hình. |
| **Banh/kẹp 2 ngón tay** | Phóng to / Thu nhỏ | Zoom kích thước ảnh từ `0.05x` đến `15.0x`. |
| **Xoay bằng 2 ngón tay** | Xoay hình ảnh mẫu | Xoay góc tự do theo mọi hướng. |
| **Nhấn đúp (Double Tap)** | Khôi phục căn chỉnh | Trả các thông số di chuyển, xoay, thu phóng về mặc định. |
| **Nhấn giữ (Long Press)** | Khóa / Mở khóa lớp phủ | Khóa nhanh để cố định tranh vẽ hoặc mở khóa khi cần sửa. |

---

## 🎨 Bộ lọc đường nét & Xử lý Hình ảnh (Image Processing Overlays)

Để đảm bảo khả năng quan sát tối ưu trong mọi môi trường vẽ, ứng dụng hỗ trợ đa dạng bộ lọc xử lý hình ảnh thời gian thực, đặc biệt tối ưu cho cả **nền giấy sáng màu** lẫn **nền giấy tối màu**:

*   **Ảnh gốc (Original):** Giữ nguyên màu sắc ban đầu của ảnh mẫu.
*   **Nét trắng (Outline White):** Trích xuất nét vẽ màu trắng trên nền trong suốt (sử dụng thuật toán dò cạnh Sobel chạy ngầm trên luồng Isolate riêng biệt). **Lý tưởng khi vẽ trên nền giấy đen/tối màu**.
*   **Nét đen (Outline Black):** Trích xuất nét vẽ màu đen trên nền trong suốt (áp dụng bộ lọc màu GPU thời gian thực lên lớp mặt nạ Sobel). **Lý tưởng khi vẽ trên giấy trắng/nền sáng màu**.
*   **Nét đỏ (Outline Red):** Trích xuất nét vẽ màu đỏ trên nền trong suốt. Có độ tương phản cực kỳ cao, **nổi bật trên cả nền giấy sáng lẫn tối**.
*   **Trắng đen (Grayscale):** Chuyển đổi ảnh sang dạng đơn sắc xám.
*   **Đảo màu (Invert):** Đảo ngược âm bản của ảnh để làm nổi bật các chi tiết tối.
*   **Tương phản (High Contrast/Stencil):** Tăng mạnh độ tương phản, chuyển đổi ảnh thành dạng stencil nhị phân rõ nét.
*   **Phủ xanh Cyan (Cyan Tint) & Phủ vàng ấm (Amber Tint):** Phủ một lớp màu đặc trưng lên ảnh mẫu giúp mắt dễ chịu và phân biệt nét vẽ tốt hơn dưới các nguồn ánh sáng phòng khác nhau.

---

## 🏛️ Kiến trúc Dự án & Cấu trúc Thư mục

Ứng dụng tuân thủ nghiêm ngặt **Kiến trúc Sạch hướng tính năng (Feature-First Clean Architecture)**, giúp tách biệt hoàn toàn các mảng nghiệp vụ:

```text
lib/
├── app/
│   ├── app.dart         # Cấu hình MaterialApp gốc
│   ├── router.dart      # Hệ thống định tuyến go_router & cổng kiểm tra quyền hạn
│   └── theme.dart       # Cấu hình giao diện tối (Dark Mode), sử dụng font Montserrat
│
├── core/
│   └── services/
│       └── storage_service.dart # Lưu trữ & khôi phục trạng thái qua SharedPreferences
│
├── features/
│   ├── camera/          # Tính năng quản lý phần cứng Camera
│   │   └── presentation/
│   │       ├── camera_preview_widget.dart # Khung hình xem trực tiếp tự động scale cover
│   │       ├── camera_provider.dart       # Quản lý vòng đời camera (tự động giải phóng khi ẩn app)
│   │       ├── home_screen.dart           # Giao diện canvas chính tích hợp Stack lớp phủ
│   │       ├── permission_page.dart       # Màn hình yêu cầu quyền camera & lưu trữ
│   │       └── permission_provider.dart   # Quản lý trạng thái cấp quyền động
│   │
│   └── overlay/         # Tính năng quản lý ảnh mẫu & cử chỉ
│       └── presentation/
│           ├── bottom_toolbar.dart        # Thanh công cụ dưới (nhập ảnh, bộ lọc, lật lắt, khóa)
│           ├── grid_painter.dart          # Vẽ lưới hướng dẫn bố cục 3x3
│           ├── opacity_slider_widget.dart # Thanh trượt độ mờ đục thời gian thực
│           ├── overlay_image_widget.dart  # Lớp cử chỉ và xử lý bộ lọc ảnh mẫu
│           ├── overlay_provider.dart      # Điều phối vị trí ảnh, lịch sử và luồng Sobel Isolate
│           └── top_toolbar.dart           # Thanh công cụ trên (hướng dẫn vẽ, nút xóa ảnh)
│
├── shared/
│   ├── models/
│   │   └── overlay_state_model.dart       # Lớp dữ liệu trạng thái Immutable (Equatable)
│   └── widgets/
│       ├── error_view.dart                # Giao diện hiển thị lỗi thân thiện
│       ├── floating_icon_button.dart       # Nút chức năng tròn kiểu glassmorphism cao cấp (48dp)
│       └── loading_view.dart              # Giao diện chờ tải dữ liệu mượt mà
│
└── main.dart            # Điểm khởi chạy ứng dụng & nạp dữ liệu SharedPreferences
```

---

## 📦 Các Thư viện Sử dụng chính (Core Packages)

*   **`flutter_riverpod` & `riverpod`**: Quản lý trạng thái phân tách rõ ràng và phản ứng tức thì (reactive).
*   **`go_router`**: Điều hướng màn hình thông minh, tự động chuyển đến màn xin quyền nếu chưa được cấp phép.
*   **`camera`**: Tương tác camera độ phân giải cao, hỗ trợ chuyển đổi camera trước/sau.
*   **`image_picker`**: Chọn ảnh mẫu từ thư viện ảnh hệ thống.
*   **`permission_handler`**: Quản lý và yêu cầu quyền hệ thống động lúc chạy ứng dụng.
*   **`shared_preferences`**: Lưu trữ cục bộ trạng thái canh chỉnh và lịch sử ảnh nhập.
*   **`google_fonts`**: Tải động và cấu hình font chữ nghệ thuật `Montserrat` cao cấp.
*   **`flutter_animate`**: Tạo các hiệu ứng chuyển động, hiển thị mượt mà cho thanh công cụ và hộp thoại.
*   **`image` & `vector_math`**: Hỗ trợ thuật toán xử lý ma trận và tính toán cạnh Sobel trên Isolate.

---

## 🚀 Hướng dẫn Cài đặt & Khởi chạy

### Điều kiện cần
Hãy đảm bảo bạn đã cài đặt phiên bản [Flutter SDK](https://docs.flutter.dev/get-started/install) mới nhất trên máy tính.

### Bước 1: Tải các thư viện phụ thuộc
Mở terminal tại thư mục dự án và chạy lệnh:
```bash
flutter pub get
```

### Bước 2: Kiểm tra phân tích mã nguồn
Đảm bảo mã nguồn chuẩn hóa, không có lỗi cảnh báo:
```bash
flutter analyze
```

### Bước 3: Chạy ứng dụng
Khởi chạy dự án trên thiết bị giả lập hoặc thiết bị thật được kết nối:
```bash
flutter run
```

### Bước 4: Chạy kiểm thử tự động
Khởi chạy bộ test kiểm tra khởi động app và định tuyến:
```bash
flutter test
```

---

## 🗺️ Định hướng Phát triển Tương lai (Roadmap)
- [ ] Tích hợp tính năng **Quay video Tua nhanh (Timelapse)** hành trình vẽ của họa sĩ.
- [ ] Bổ sung thanh công cụ **Cân bằng sáng/đèn flash** của camera trực tiếp từ trong ứng dụng.
- [ ] Thêm tính năng **Hiệu chỉnh Độ tương phản/Độ sáng** của ảnh mẫu trực quan bằng các thanh trượt riêng lẻ.
- [ ] Tối ưu hóa thuật toán Sobel trên GPU bằng cách sử dụng Shader để trích nét tức thì không cần luồng Isolate.
