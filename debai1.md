# flutter_senior_test.md

# Senior Flutter Developer Test (CRM + IoT)

> **Phiên bản:** v1.0
>
> **Vị trí:** Senior Flutter Developer (5+ năm kinh nghiệm)
>
> **Lĩnh vực:** CRM, ERP, IoT, Manufacturing
>
> **Thời gian:** 45 phút
>
> **Điểm chính:** 100
>
> **Điểm Bonus (AI):** 20
>
> **Tổng:** 120

---

# Thông tin

Ứng viên vui lòng:

* Không sử dụng Internet.
* Không sử dụng AI trong quá trình làm bài.
* Có thể viết bằng tiếng Việt hoặc tiếng Anh.
* Có thể mô tả bằng sơ đồ nếu cần.

---

# Cấu trúc đề

| Phần            | Điểm |
| --------------- | ---- |
| I. Trắc nghiệm  | 40   |
| II. Tự luận     | 20   |
| III. Tình huống | 20   |
| IV. Đọc code    | 10   |
| V. Thiết kế UI  | 10   |
| VI. AI (Bonus)  | 20   |

---

# PHẦN I - TRẮC NGHIỆM (40 điểm)

> Mỗi câu 1 điểm.

---

## Câu 1

BuildContext được sử dụng để:

A. Quản lý bộ nhớ

B. Truy cập Widget Tree

C. Quản lý Route

D. Quản lý State

---

## Câu 2

Widget nào phù hợp nhất để hiển thị danh sách 20.000 thiết bị IoT?

A. Column

B. ListView

C. ListView.builder

D. Wrap

---

## Câu 3

Bloc State nên là:

A. Mutable

B. Immutable

C. Singleton

D. Static

---

## Câu 4

Repository Pattern dùng để:

A. Quản lý UI

B. Tách Data Source khỏi Business Logic

C. Quản lý Theme

D. Điều hướng

---

## Câu 5

Interceptor trong Dio dùng để:

A. Render Widget

B. Chặn Request/Response

C. Quản lý Route

D. Quản lý Animation

---

## Câu 6

MQTT phù hợp nhất cho:

A. Chat

B. IoT

C. Video Streaming

D. OCR

---

## Câu 7

Storage phù hợp để lưu JWT Token:

A. SharedPreferences

B. Secure Storage

C. SQLite

D. Hive

---

## Câu 8

Offline-first cần:

A. Local Database

B. Firebase

C. Animation

D. Hero Widget

---

## Câu 9

SOLID - chữ S là:

A. Single Responsibility Principle

B. Security Principle

C. Service Principle

D. Stateless Principle

---

## Câu 10

dispose() được dùng để:

A. Render Widget

B. Giải phóng tài nguyên

C. Build Theme

D. Điều hướng

---

## Câu 11

Nhiều API cùng trả về 401.

Giải pháp phù hợp là:

A. Refresh từng request

B. Queue request và refresh một lần

C. Logout ngay

D. Retry vô hạn

---

## Câu 12

Widget nào giúp giảm rebuild?

A. BlocSelector

B. Scaffold

C. SafeArea

D. Padding

---

## Câu 13

Flutter DevTools dùng để:

A. Build APK

B. Debug và Profile

C. Publish App

D. Generate Icon

---

## Câu 14

BLE là:

A. Bluetooth Low Energy

B. Binary Link Engine

C. Basic Local Ethernet

D. Bluetooth Local Extension

---

## Câu 15

Trong Clean Architecture, UI nên gọi trực tiếp:

A. API

B. Database

C. UseCase/ViewModel

D. Dio

---

## Câu 16

Khi hiển thị Dashboard nhiều Card:

A. Dùng const Widget nếu có thể

B. setState liên tục

C. Column chứa toàn bộ

D. IntrinsicHeight

---

## Câu 17

Để sinh Model từ JSON nên dùng:

A. build_runner + json_serializable

B. setState

C. SharedPreferences

D. ThemeData

---

## Câu 18

Tool quản lý nhiều phiên bản Flutter:

A. Melos

B. Mason

C. FVM

D. Fastlane

---

## Câu 19

Tool sinh Boilerplate Flutter:

A. Mason

B. Dio

C. Hive

D. Patrol

---

## Câu 20

Tool quản lý Monorepo:

A. Melos

B. Fastlane

C. Patrol

D. Mocktail

---

## Câu 21

Tool dùng để Integration Test:

A. Patrol

B. Dio

C. Isar

D. Drift

---

## Câu 22

Khi hiển thị danh sách lớn nên:

A. ListView(children)

B. ListView.builder()

C. Column

D. Wrap

---

## Câu 23

Widget phù hợp cho Dashboard có Grid và List:

A. CustomScrollView

B. Stack

C. Wrap

D. PageView

---

## Câu 24

Nguyên tắc Dependency Injection giúp:

A. Giảm Coupling

B. Tăng FPS

C. Tăng RAM

D. Giảm APK

---

## Câu 25

Tool phân tích Memory Leak:

A. Flutter DevTools

B. VSCode Explorer

C. Android Manifest

D. Pubspec

---

## Câu 26

MQTT reconnect nên sử dụng:

A. Infinite reconnect

B. Exponential Backoff

C. Restart App

D. Ignore

---

## Câu 27

Nếu AI sinh code, bước tiếp theo nên là:

A. Merge ngay

B. Review + Test

C. Release

D. Xóa Unit Test

---

## Câu 28

Claude Code CLI phù hợp nhất để:

A. Refactor

B. Quản lý Database

C. Thiết kế UI

D. Chạy Emulator

---

## Câu 29

Git workflow phù hợp:

A. Commit trực tiếp main

B. Pull Request

C. Force Push

D. Cherry-pick main

---

## Câu 30

Lefthook/Husky thường dùng để:

A. Git Hook

B. Build APK

C. Deploy

D. Database Migration

---

## Câu 31

freezed chủ yếu dùng để:

A. Immutable Model

B. MQTT

C. BLE

D. Theme

---

## Câu 32

custom_lint dùng để:

A. Tạo luật kiểm tra code

B. Sinh JSON

C. Debug

D. Test UI

---

## Câu 33

Khi sử dụng StreamSubscription cần:

A. dispose/cancel

B. Không cần làm gì

C. Restart App

D. Gọi setState()

---

## Câu 34

Repository không nên:

A. Gọi trực tiếp Widget

B. Gọi API

C. Gọi Local DB

D. Mapping Data

---

## Câu 35

State Management ưu tiên cho dự án lớn:

A. Bloc/Cubit

B. setState toàn bộ

C. StatefulWidget

D. Global Variable

---

## Câu 36

Widget tối ưu cho Device Card:

A. Reusable StatelessWidget

B. Tạo trong build()

C. Inline toàn bộ

D. Stack

---

## Câu 37

Tool CI/CD phổ biến:

A. GitHub Actions

B. SQLite

C. Riverpod

D. Hive

---

## Câu 38

Tool AI nào dưới đây là AI Coding Assistant?

A. Continue.dev

B. Dio

C. FlutterGen

D. Drift

---

## Câu 39

Tool AI nào hoạt động theo dạng Agent trong IDE?

A. Cursor

B. Dart Format

C. DevTools

D. Mocktail

---

## Câu 40

Điều nào đúng khi sử dụng AI?

A. Merge code AI sinh ra mà không review

B. AI luôn đúng

C. AI hỗ trợ tăng năng suất nhưng cần review, test và tuân thủ coding standard

D. AI thay thế hoàn toàn Senior Developer

---

# PHẦN II - TỰ LUẬN (20 điểm)

## Câu 41 (10 điểm)

Thiết kế kiến trúc cho ứng dụng CRM có các module:

* Khách hàng
* Đơn hàng
* Thiết bị IoT
* Dashboard

Mô tả:

* Folder Structure
* State Management
* Repository Pattern
* Dependency Injection
* Cách tổ chức module để dễ mở rộng.

---

## Câu 42 (10 điểm)

Thiết kế cơ chế **Offline-first**.

Yêu cầu:

* Không có Internet vẫn tạo được đơn hàng.
* Đồng bộ dữ liệu khi Online.
* Xử lý Conflict.
* Retry khi Sync thất bại.

---

# PHẦN III - TÌNH HUỐNG (20 điểm)

## Câu 43 (10 điểm)

Ứng dụng kết nối hơn **300 thiết bị MQTT**.

Sau khoảng 4 giờ hoạt động:

* RAM tăng dần.
* UI giật.
* Thiết bị reconnect liên tục.

Hãy mô tả quy trình phân tích và cách xử lý.

---

## Câu 44 (10 điểm)

CRM hiển thị **20.000 khách hàng**.

Thời gian mở màn hình khoảng **12 giây**.

Bạn sẽ tối ưu từ API đến Flutter như thế nào?

---

# PHẦN IV - ĐỌC CODE (10 điểm)

## Câu 45

Đọc đoạn code dưới đây và tìm **ít nhất 8 vấn đề** liên quan đến:

* Clean Architecture
* SOLID
* Memory Leak
* Performance
* Error Handling
* Maintainability

```dart
class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final mqttClient = MQTTClient();

  List<Device> devices = [];

  @override
  void initState() {
    super.initState();

    mqttClient.connect();

    mqttClient.stream.listen((event) {
      setState(() {
        devices = event.devices;
      });
    });

    loadDevices();
  }

  Future<void> loadDevices() async {
    devices = await Api.getDevices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: devices
          .map((e) => DeviceCard(device: e))
          .toList(),
    );
  }
}
```

---

# PHẦN V - THIẾT KẾ UI (10 điểm)

## Câu 46

Từ mô tả dưới đây, hãy:

* Mô tả Widget Tree **hoặc**
* Viết cấu trúc Flutter Widget phù hợp.

```text
+------------------------------------------------+
| CRM Dashboard                                  |
+------------------------------------------------+
| Search                                         |
+------------------------------------------------+
| Online | Offline | Warning | Error             |
+------------------------------------------------+
| Device A                                       |
| Device B                                       |
| Device C                                       |
| ...                                            |
+------------------------------------------------+
|                     (+)                        |
+------------------------------------------------+
```

Yêu cầu:

* Responsive.
* Có khả năng tái sử dụng Widget.
* Dễ mở rộng.

---

# PHẦN VI - BONUS (AI-Assisted Development) (20 điểm)

> **Không bắt buộc. Không làm phần này không ảnh hưởng đến điểm chính.**

## Câu 47 (5 điểm)

Liệt kê các công cụ AI bạn đã sử dụng trong quá trình phát triển phần mềm.

Ví dụ:

* Claude Code CLI
* ChatGPT
* GitHub Copilot
* Cursor
* Continue.dev
* Gemini CLI
* Aider
* Roo Code
* Cline
* Windsurf
* Khác...

Với mỗi công cụ, mô tả:

* Dùng để làm gì?
* Tần suất sử dụng?
* Điểm mạnh/yếu theo trải nghiệm của bạn.

---

## Câu 48 (5 điểm)

Mô tả **workflow sử dụng AI CLI hoặc AI IDE** khi phát triển một tính năng Flutter mới.

Ví dụ:

* Phân tích yêu cầu
* Thiết kế Architecture
* Sinh Model
* Sinh Repository
* Sinh Bloc
* Sinh UI
* Review
* Refactor
* Unit Test

---

## Câu 49 (5 điểm)

Nếu dự án của bạn đã từng sử dụng AI Agent, hãy chia sẻ:

* AI Rules
* Instructions
* Hooks
* Prompt Template
* Coding Convention dành cho AI

Ví dụ:

* `.claude/CLAUDE.md`
* `.cursor/rules/*.mdc`
* `.github/copilot-instructions.md`
* `.aider.conf.yml`
* Hook trước commit hoặc quy trình review AI-generated code.

Nếu chưa từng sử dụng, hãy mô tả cách bạn sẽ xây dựng các quy tắc này.

---

## Câu 50 (5 điểm)

Theo bạn:

1. AI nên hỗ trợ những công việc nào?
2. AI **không nên** quyết định những công việc nào?
3. Làm thế nào để đảm bảo chất lượng mã nguồn do AI tạo ra trước khi merge vào dự án?
