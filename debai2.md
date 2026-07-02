# flutter_senior_answer.md (Phần 1)

# Đáp án & Hướng dẫn chấm điểm

**Vị trí:** Senior Flutter Developer (5+ năm)

**Phiên bản:** v1.0

---

# PHẦN I - TRẮC NGHIỆM (Câu 1 - 20)

> Mỗi câu: **1 điểm**

---

# Câu 1

### Đáp án

✅ B

### Giải thích

`BuildContext` là đối tượng đại diện cho vị trí của Widget trong Widget Tree.

Được sử dụng để:

* Navigator
* Theme
* MediaQuery
* Provider/Bloc
* Localization
* ScaffoldMessenger

### Mục tiêu đánh giá

* Hiểu Widget Tree
* Hiểu Lifecycle

---

# Câu 2

### Đáp án

✅ C

### Giải thích

Danh sách rất lớn phải sử dụng

```dart
ListView.builder()
```

vì Widget sẽ được tạo khi cần.

Không nên:

```dart
ListView(
  children: list.map(...).toList()
)
```

vì toàn bộ Widget sẽ được tạo ngay lập tức.

### Senior nên đề cập

* Pagination
* Infinite Scroll
* Cache

---

# Câu 3

### Đáp án

✅ B

### Giải thích

State của Bloc nên immutable.

Ví dụ:

```dart
class DeviceState {
  final List<Device> devices;

  const DeviceState(this.devices);
}
```

Điều này giúp:

* Predictable State
* So sánh State
* Debug dễ hơn

---

# Câu 4

### Đáp án

✅ B

### Giải thích

Repository Pattern giúp tách:

```
Presentation

↓

Repository

↓

API / Local DB
```

Ưu điểm

* Dễ test

* Thay đổi Data Source

* Không phụ thuộc API

---

# Câu 5

### Đáp án

✅ B

### Giải thích

Interceptor dùng để:

* JWT

* Refresh Token

* Log

* Retry

* Header

* Error Handler

Ví dụ

```dart
dio.interceptors.add(AuthInterceptor());
```

---

# Câu 6

### Đáp án

✅ B

### Giải thích

MQTT rất phù hợp:

* IoT

* Smart Factory

* Sensor

* Machine

* Realtime Device

Không phù hợp:

* Database

* OCR

---

# Câu 7

### Đáp án

✅ B

### Giải thích

JWT nên lưu:

Flutter Secure Storage

Không nên:

SharedPreferences

vì dữ liệu không được mã hóa.

Senior có thể đề cập:

* Biometric

* KeyStore

* KeyChain

---

# Câu 8

### Đáp án

✅ A

### Giải thích

Offline-first cần:

* Local Database

* Queue

* Sync Engine

* Conflict Resolution

Ví dụ:

SQLite

Hive

Isar

---

# Câu 9

### Đáp án

✅ A

### Giải thích

Single Responsibility Principle

Một class chỉ nên có một lý do để thay đổi.

Ví dụ:

Sai

```dart
CustomerPage
```

vừa:

* gọi API

* lưu DB

* render UI

* validate

Đúng:

Tách

* Repository

* Service

* Bloc

* UI

---

# Câu 10

### Đáp án

✅ B

### Giải thích

dispose()

dùng để

* close Stream

* close Bloc

* cancel Timer

* dispose Controller

* MQTT disconnect

Nếu quên sẽ gây:

* Memory Leak

* RAM tăng

---

# Câu 11

### Đáp án

✅ B

### Giải thích

Sai:

```
Request A

401

Refresh

Request B

401

Refresh

Request C

401

Refresh
```

Đúng:

```
Queue

↓

Refresh Token

↓

Retry tất cả Request
```

Senior thường biết:

Mutex

Lock

Completer

---

# Câu 12

### Đáp án

✅ A

### Giải thích

BlocSelector

chỉ rebuild phần dữ liệu thay đổi.

Ví dụ

```
Dashboard

↓

StatisticCard

↓

BlocSelector
```

thay vì

```
BlocBuilder

↓

Rebuild toàn Dashboard
```

---

# Câu 13

### Đáp án

✅ B

### Giải thích

Flutter DevTools hỗ trợ

* Memory

* CPU

* Timeline

* Widget Inspector

* Network

* Performance

Đây là công cụ bắt buộc Senior Flutter nên thành thạo.

---

# Câu 14

### Đáp án

✅ A

### Giải thích

BLE

=

Bluetooth Low Energy

Được dùng nhiều trong

* Beacon

* IoT

* Máy chấm công

* Máy quét

* Thiết bị y tế

---

# Câu 15

### Đáp án

✅ C

### Giải thích

UI

↓

UseCase / Bloc / ViewModel

↓

Repository

↓

Datasource

Không nên

```
Widget

↓

API
```

điều này vi phạm Clean Architecture.

---

# Câu 16

### Đáp án

✅ A

### Giải thích

const Widget

giúp Flutter

* reuse object

* giảm rebuild

* tăng FPS

Senior cũng có thể đề cập:

* RepaintBoundary

* BlocSelector

* ValueListenableBuilder

---

# Câu 17

### Đáp án

✅ A

### Giải thích

Thông thường sử dụng

```yaml
json_serializable

build_runner
```

để sinh code Model.

Ưu điểm

* ít lỗi

* dễ bảo trì

---

# Câu 18

### Đáp án

✅ C

### Giải thích

FVM

Flutter Version Management

Cho phép:

* nhiều version Flutter

* nhiều project

* CI ổn định

---

# Câu 19

### Đáp án

✅ A

### Giải thích

Mason

dùng để

Generate

* Feature

* Bloc

* Repository

* Screen

* Clean Architecture

rất phù hợp dự án lớn.

---

# Câu 20

### Đáp án

✅ A

### Giải thích

Melos

quản lý

* Monorepo

* Package

* Bootstrap

* Script

Ví dụ

```
apps/

crm/

warehouse/

packages/

network/

ui/

device/

core/
```

---

# Đánh giá sau Phần 1

## 18 - 20 điểm

* Kiến thức Flutter Core rất tốt.
* Có khả năng làm việc với dự án Enterprise.

---

## 15 - 17 điểm

* Đạt yêu cầu Senior.

* Có thể cần bổ sung thêm về Tooling hoặc Architecture.

---

## 12 - 14 điểm

* Mid+/Senior.

* Nên đánh giá thêm qua phần đọc code.

---

## <12 điểm

* Chưa đạt kỳ vọng cho vị trí Senior Flutter 5+ năm.
* Cần xem xét thêm kinh nghiệm thực tế hoặc cân nhắc vị trí Mid-level.

# flutter_senior_answer.md (Phần 2)

# Đáp án & Hướng dẫn chấm điểm

## PHẦN I - TRẮC NGHIỆM (Câu 21 - 40)

> Mỗi câu: **1 điểm**

---

# Câu 21

### Đáp án

✅ A

### Giải thích

**Patrol** là framework dùng để kiểm thử Integration/UI cho Flutter.

Ưu điểm:

* Test gần với hành vi người dùng.
* Hỗ trợ Android/iOS.
* Dễ tích hợp CI/CD.

Các đáp án khác:

* Dio → Networking
* Isar → Database
* Drift → ORM/SQLite

---

# Câu 22

### Đáp án

✅ B

### Giải thích

Với dữ liệu lớn, luôn ưu tiên:

```dart
ListView.builder()
```

Ưu điểm:

* Lazy Loading Widget
* Tiết kiệm RAM
* Scroll mượt

Senior có thể đề cập:

* Pagination
* Infinite Scroll
* Cache

---

# Câu 23

### Đáp án

✅ A

### Giải thích

Dashboard gồm Grid + List nên dùng:

```text
CustomScrollView
 ├── SliverGrid
 └── SliverList
```

Ưu điểm

* Scroll thống nhất.
* Hiệu năng cao.
* Không bị Nested Scroll.

---

# Câu 24

### Đáp án

✅ A

### Giải thích

Dependency Injection giúp:

* Giảm Coupling.
* Dễ Unit Test.
* Thay đổi Implementation.
* Dễ Mock.

Ví dụ

```dart
getIt.registerLazySingleton<DeviceRepository>(
  () => DeviceRepositoryImpl(),
);
```

---

# Câu 25

### Đáp án

✅ A

### Giải thích

Flutter DevTools hỗ trợ:

* Memory Leak
* Allocation
* Timeline
* CPU
* Rebuild Widget

Senior nên biết sử dụng Memory View.

---

# Câu 26

### Đáp án

✅ B

### Giải thích

Reconnect liên tục sẽ:

* Hao pin
* Hao CPU
* Tăng Traffic
* Gây DDOS chính Server MQTT

Nên dùng:

* Exponential Backoff
* Retry giới hạn
* Heartbeat
* Keep Alive

---

# Câu 27

### Đáp án

✅ B

### Giải thích

AI chỉ hỗ trợ sinh code.

Developer phải:

* Review Logic.
* Chạy Test.
* Kiểm tra Security.
* Kiểm tra Coding Convention.
* Đánh giá Performance.

Không nên merge trực tiếp.

---

# Câu 28

### Đáp án

✅ A

### Giải thích

Claude Code CLI phù hợp:

* Refactor
* Generate Feature
* Fix Bug
* Generate Test
* Explain Code
* Review Code

Không thay thế việc thiết kế kiến trúc hay quyết định nghiệp vụ.

---

# Câu 29

### Đáp án

✅ B

### Giải thích

Pull Request giúp:

* Review Code
* Thảo luận
* Chạy CI
* Kiểm tra Quality Gate

Không nên:

* Commit trực tiếp lên `main`
* Force Push lên nhánh chính

---

# Câu 30

### Đáp án

✅ A

### Giải thích

Lefthook/Husky là Git Hook.

Ví dụ:

Trước Commit:

* dart format
* flutter analyze
* unit test

Nếu lỗi

→ Không cho Commit.

---

# Câu 31

### Đáp án

✅ A

### Giải thích

`freezed`

dùng để:

* Immutable Class
* Union Type
* copyWith
* Equality
* Sealed Class

Rất phù hợp với Bloc.

---

# Câu 32

### Đáp án

✅ A

### Giải thích

custom_lint

cho phép tạo Rule riêng.

Ví dụ:

Không cho phép

```dart
Api.getCustomers();
```

trong UI.

Hoặc

Bắt buộc Repository Pattern.

Đây là điểm cộng lớn nếu ứng viên từng áp dụng.

---

# Câu 33

### Đáp án

✅ A

### Giải thích

StreamSubscription

phải:

```dart
subscription.cancel();
```

Nếu không:

* Memory Leak
* Event bị nhận nhiều lần
* RAM tăng

---

# Câu 34

### Đáp án

✅ A

### Giải thích

Repository

không được biết UI.

Sai:

```text
Repository

↓

Navigator.push()
```

Đúng:

Repository

↓

Datasource

↓

API

---

# Câu 35

### Đáp án

✅ A

### Giải thích

Dự án Enterprise

ưu tiên:

* Bloc/Cubit
* Riverpod

Không nên:

* Global Variable
* setState toàn dự án

---

# Câu 36

### Đáp án

✅ A

### Giải thích

DeviceCard nên là

```dart
class DeviceCard extends StatelessWidget
```

Ưu điểm

* Reuse
* Test
* Ít Rebuild

Không nên viết toàn bộ UI trong một `build()` dài hàng trăm dòng.

---

# Câu 37

### Đáp án

✅ A

### Giải thích

GitHub Actions hỗ trợ:

* flutter analyze
* unit test
* build apk
* build ipa
* release

Các lựa chọn khác không phải công cụ CI/CD.

---

# Câu 38

### Đáp án

✅ A

### Giải thích

Continue.dev

là AI Extension cho VS Code/JetBrains.

Có thể kết nối:

* Claude
* OpenAI
* Gemini
* Ollama
* Azure OpenAI

Điểm cộng nếu ứng viên biết dùng với mô hình nội bộ.

---

# Câu 39

### Đáp án

✅ A

### Giải thích

Cursor là AI IDE/Agent.

Có khả năng:

* Hiểu Codebase
* Multi-file Edit
* Refactor
* Generate Test
* Chat với Project

Ngoài Cursor, các công cụ tương tự gồm:

* Windsurf
* Roo Code
* Cline
* Augment Code

---

# Câu 40

### Đáp án

✅ C

### Giải thích

AI giúp:

* Tăng năng suất.
* Sinh Boilerplate.
* Refactor.
* Viết Test.
* Giải thích Code.

Nhưng cần:

* Review.
* Test.
* Security Review.
* Performance Review.
* Kiểm tra Business Logic.

Không nên coi AI là nguồn chân lý tuyệt đối.

---

# PHẦN II - TỰ LUẬN

## Câu 41 (10 điểm)

### Mục tiêu đánh giá

* Tư duy kiến trúc.
* Kinh nghiệm dự án lớn.
* Khả năng tổ chức mã nguồn.

---

### Đáp án mong đợi

Ứng viên không nhất thiết phải đúng hoàn toàn, nhưng nên trình bày được các ý sau:

#### 1. Folder Structure (3 điểm)

Ví dụ:

```text
lib/
├── core/
│   ├── network/
│   ├── storage/
│   ├── di/
│   └── utils/
├── features/
│   ├── customer/
│   ├── order/
│   ├── device/
│   └── dashboard/
└── shared/
```

Điểm cộng nếu theo **Feature-first** thay vì chia theo MVC truyền thống.

---

#### 2. State Management (2 điểm)

Ưu tiên:

* Bloc/Cubit
* Riverpod

Giải thích được lý do lựa chọn.

---

#### 3. Repository Pattern (2 điểm)

Luồng chuẩn:

```text
UI
 ↓
Bloc/ViewModel
 ↓
UseCase (nếu có)
 ↓
Repository
 ↓
Remote / Local Data Source
```

Không gọi API trực tiếp từ Widget.

---

#### 4. Dependency Injection (2 điểm)

Ví dụ:

* GetIt
* Injectable

Biết đăng ký:

* Repository
* Service
* API Client

---

#### 5. Khả năng mở rộng (1 điểm)

Ứng viên nên đề cập:

* Module độc lập.
* Dễ thêm tính năng.
* Dễ Unit Test.
* Dễ thay đổi nguồn dữ liệu.

---

### Dấu hiệu của Senior

Ngoài các ý trên, ứng viên đề cập thêm:

* SOLID
* Feature Module
* Domain Layer
* Shared Component
* Coding Convention
* Monorepo (Melos)
* CI/CD

=> Có thể đánh giá rất tốt.

---

## Câu 42 (10 điểm)

### Mục tiêu đánh giá

Đánh giá kinh nghiệm làm ứng dụng doanh nghiệp và Offline-first.

---

### Đáp án mong đợi

Ứng viên nên trình bày được các ý sau:

#### 1. Local Database (2 điểm)

Ví dụ:

* Isar
* SQLite
* Hive

---

#### 2. Queue thao tác (2 điểm)

Lưu:

* INSERT
* UPDATE
* DELETE

Thay vì chỉ lưu dữ liệu cuối cùng.

---

#### 3. Sync Engine (2 điểm)

Khi có Internet:

```text
Queue
 ↓
Upload
 ↓
Server
 ↓
Success → Xóa Queue
```

Có Retry nếu thất bại.

---

#### 4. Conflict Resolution (2 điểm)

Ví dụ:

* updatedAt
* version
* last-write-wins
* merge theo nghiệp vụ

Điểm cộng nếu phân biệt được xung đột dữ liệu và chiến lược giải quyết.

---

#### 5. Error Handling (2 điểm)

Đề cập:

* Retry giới hạn.
* Log lỗi.
* Hiển thị trạng thái Sync.
* Không làm mất dữ liệu người dùng.

---

### Dấu hiệu của Senior

Ứng viên đề cập thêm:

* Background Sync.
* Connectivity Listener.
* Idempotent API.
* Batch Sync.
* Transaction.
* Đồng bộ theo từng module thay vì toàn bộ.

=> Đây là dấu hiệu đã từng triển khai Offline-first trong thực tế.

# flutter_senior_answer.md (Phần 3)

# Đáp án & Hướng dẫn chấm điểm

## PHẦN III - XỬ LÝ TÌNH HUỐNG

> Tổng điểm: **20 điểm**

---

# Câu 43 (10 điểm)

## Đề bài

Ứng dụng Flutter đang kết nối hơn **300 thiết bị IoT** thông qua MQTT.

Sau khoảng 4 giờ hoạt động:

* RAM tăng dần từ 200MB → 900MB.
* UI bắt đầu giật khi chuyển màn hình.
* Một số thiết bị reconnect liên tục.
* Khách hàng phản ánh sau một ngày chạy thì ứng dụng rất chậm.

Bạn sẽ xử lý như thế nào?

---

# Mục tiêu đánh giá

Đánh giá:

* Kinh nghiệm Production
* Debug Performance
* Memory Leak
* MQTT
* Architecture
* Khả năng phân tích nguyên nhân

---

# Đáp án mong đợi

## Bước 1. Thu thập thông tin (1 điểm)

Senior không nên sửa ngay.

Đầu tiên cần xác định:

* Có tái hiện được lỗi không?
* Bao lâu thì xảy ra?
* Android hay iOS?
* Bao nhiêu thiết bị kết nối?
* Có log Crash không?
* Có log MQTT không?

---

## Bước 2. Kiểm tra Flutter DevTools (2 điểm)

Ưu tiên mở

Flutter DevTools

Kiểm tra:

* Memory
* Allocation
* CPU
* Timeline
* Widget Rebuild

Nếu RAM tăng liên tục

=> Khả năng cao Memory Leak.

---

## Bước 3. Kiểm tra Stream (2 điểm)

Ví dụ

```dart
mqtt.stream.listen(...)
```

Ứng viên nên nói đến:

* StreamSubscription

* cancel()

* dispose()

Ví dụ

```dart
late StreamSubscription subscription;

@override
void dispose() {
    subscription.cancel();
    super.dispose();
}
```

Nếu không cancel

→ Stream vẫn hoạt động.

---

## Bước 4. MQTT Connection (1 điểm)

Không nên

```text
Disconnect

↓

Connect

↓

Disconnect

↓

Connect
```

Nên

* KeepAlive
* Heartbeat
* Exponential Backoff
* Retry giới hạn

---

## Bước 5. Kiểm tra Rebuild UI (2 điểm)

Nếu

```dart
BlocBuilder(
    builder...
)
```

bao toàn bộ Dashboard

→ mỗi Event MQTT

↓

Rebuild toàn màn hình.

Senior nên đề xuất

* BlocSelector
* Selector
* ValueListenableBuilder

hoặc chia nhỏ Widget.

---

## Bước 6. Kiểm tra Widget (1 điểm)

Không nên

```dart
ListView(
 children:
     devices.map(...).toList()
)
```

Nên

```dart
ListView.builder()
```

---

## Bước 7. Kiểm tra Business Logic (1 điểm)

Nếu xử lý

* Parse JSON lớn
* Decode Base64
* Encrypt
* Export Excel

=> chuyển sang

```dart
compute()
```

hoặc

Isolate.

---

# Điểm cộng

Ứng viên đề cập thêm

* Dart Observatory
* Leak Tracker
* MQTT QoS
* Backpressure
* Debounce Event
* Batch Update
* Logging bằng Sentry/Crashlytics
* Theo dõi FPS hoặc Frame Rendering

=> Có thể cộng tối đa **2 điểm thưởng** (không vượt quá điểm tối đa của câu).

---

# Rubric

| Nội dung      | Điểm |
| ------------- | ---- |
| DevTools      | 2    |
| Memory Leak   | 2    |
| MQTT Strategy | 1    |
| UI Rebuild    | 2    |
| Performance   | 2    |
| Debug Process | 1    |

---

# Dấu hiệu Senior

Ứng viên trả lời theo trình tự:

Thu thập dữ liệu

↓

Đo đạc

↓

Phân tích

↓

Sửa

↓

Benchmark

Không sửa theo cảm tính.

==================================================

# Câu 44 (10 điểm)

## Đề bài

CRM có màn hình hiển thị hơn **20.000 khách hàng**.

Thông tin mỗi khách hàng:

* Avatar
* Tên
* Địa chỉ
* Công ty
* Doanh số
* Trạng thái

Thời gian mở màn hình khoảng **12 giây**.

Khách hàng yêu cầu mở dưới **2 giây**.

Bạn sẽ tối ưu như thế nào?

---

# Mục tiêu đánh giá

* Performance
* API Design
* Flutter Rendering
* Database
* Clean Architecture

---

# Đáp án mong đợi

## 1. Phân tích nguyên nhân (1 điểm)

Không kết luận ngay.

Kiểm tra

* API
* Database
* Flutter
* Image
* Widget
* Memory

---

## 2. API (2 điểm)

Không trả

20.000 record.

Nên

```text
?page=1

&pageSize=50
```

hoặc

Cursor Pagination.

Có thể đề cập:

* Server-side Filtering
* Server-side Sorting

---

## 3. Flutter UI (2 điểm)

Không dùng

```dart
Column(
 children: ...
)
```

Không dùng

```dart
ListView(
 children: ...
)
```

Nên

```dart
ListView.builder()
```

---

## 4. Lazy Loading (1 điểm)

Scroll đến đâu

↓

Load đến đó.

Không tải toàn bộ.

---

## 5. Image (1 điểm)

Avatar

↓

Cache

Ví dụ:

* cached_network_image

Không tải lại mỗi lần mở màn hình.

---

## 6. Rebuild (1 điểm)

Không rebuild

toàn bộ List.

Sử dụng

* BlocSelector
* const
* Reusable Widget

---

## 7. Search (1 điểm)

Không filter

20.000 item trên App.

Nên Search từ API.

---

## 8. JSON Parsing (1 điểm)

Nếu Response lớn

↓

Parse bằng

```dart
compute()
```

hoặc

Isolate.

---

# Điểm cộng

Ứng viên đề cập

* Virtual List
* SliverList
* CustomScrollView
* Diff Update
* Skeleton Loading
* Cache Strategy
* Infinite Scroll
* Repository Cache
* SWR (Stale-While-Revalidate)
* Debounce khi tìm kiếm

=> cộng tối đa **2 điểm thưởng**.

---

# Rubric

| Nội dung         | Điểm |
| ---------------- | ---- |
| API Paging       | 2    |
| ListView.builder | 2    |
| Lazy Load        | 1    |
| Image Cache      | 1    |
| Reduce Rebuild   | 1    |
| Search API       | 1    |
| JSON Parse       | 1    |
| Debug Process    | 1    |

---

# Dấu hiệu Senior

Senior thường tối ưu theo nhiều lớp:

```text
Database

↓

API

↓

Network

↓

Repository

↓

State

↓

Widget

↓

Image

↓

Render
```

Thay vì chỉ tập trung vào Flutter UI.

==================================================

# Đánh giá sau Phần III

## 18–20 điểm

* Đã từng xử lý Production.
* Có kinh nghiệm với hệ thống Enterprise/IoT.
* Hiểu Performance và quy trình debug.

---

## 15–17 điểm

* Có nền tảng tốt.
* Đủ năng lực xử lý phần lớn vấn đề thực tế.

---

## 10–14 điểm

* Biết lý thuyết nhưng thiếu trải nghiệm thực chiến.

---

## <10 điểm

* Chủ yếu trả lời theo cảm tính.
* Chưa thể hiện được tư duy phân tích hệ thống hoặc kinh nghiệm xử lý sự cố trên môi trường Production.
 
 # flutter_senior_answer.md (Phần 4)

# Đáp án & Hướng dẫn chấm điểm

## PHẦN IV - ĐỌC CODE (10 điểm)

> **Mục tiêu:** Đánh giá khả năng review code, phát hiện lỗi về Clean Architecture, SOLID, Performance, Memory Leak và Maintainability.

---

# Câu 45

## Đề bài

Đọc đoạn code sau và tìm **ít nhất 8 vấn đề**.

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

# Mục tiêu đánh giá

Ứng viên có khả năng:

* Review code
* Phát hiện lỗi kiến trúc
* Đánh giá Performance
* Đánh giá Maintainability
* Đề xuất hướng cải thiện

---

# Đáp án mong đợi

Ứng viên không nhất thiết phải nêu đúng toàn bộ, nhưng nên phát hiện được **tối thiểu 8 lỗi** dưới đây.

---

# 1. Không hủy MQTT Client (1 điểm)

## Vấn đề

```dart
mqttClient.connect();
```

Không có

```dart
mqttClient.disconnect();
```

trong

```dart
dispose()
```

### Hậu quả

* Memory Leak
* Socket không đóng
* Reconnect bất thường

---

# 2. Không cancel StreamSubscription (1 điểm)

Đoạn code

```dart
mqttClient.stream.listen(...)
```

không lưu lại Subscription.

Đúng nên là

```dart
late StreamSubscription subscription;
```

và

```dart
subscription.cancel();
```

trong

```dart
dispose()
```

---

# 3. Gọi API trực tiếp trong UI (1 điểm)

Sai

```dart
Api.getDevices();
```

Widget đang phụ thuộc trực tiếp vào API.

Đúng

```text
Widget

↓

Bloc

↓

UseCase

↓

Repository

↓

Datasource

↓

API
```

Đây là lỗi về **Clean Architecture**.

---

# 4. Không có Repository Pattern (1 điểm)

UI đang biết:

* API
* MQTT

Điều này làm:

* Khó Unit Test
* Khó Mock
* Coupling cao

Nên tách:

```text
Repository

↓

RemoteDatasource

↓

MQTTDatasource
```

---

# 5. Không xử lý Exception (1 điểm)

Đoạn

```dart
await Api.getDevices();
```

không có

```dart
try
```

```dart
catch
```

Nếu API lỗi

↓

Crash hoặc màn hình trắng.

---

# 6. Không có Loading State (0.5 điểm)

Người dùng không biết:

* Đang tải
* Thành công
* Thất bại

Senior thường thêm

```text
Loading

Success

Empty

Error
```

---

# 7. Không có Error State (0.5 điểm)

Không hiển thị:

* Retry
* Snackbar
* Dialog

Nếu API lỗi.

---

# 8. setState() cho toàn bộ màn hình (1 điểm)

```dart
setState(() {})
```

sẽ rebuild toàn bộ

```text
DevicePage
```

Nếu dữ liệu cập nhật liên tục

↓

Hiệu năng giảm.

Nên:

* Bloc
* BlocSelector
* ValueNotifier
* Riverpod

---

# 9. ListView(children) (1 điểm)

Sai

```dart
ListView(
 children: devices.map(...).toList()
)
```

Với 20.000 Device

↓

Flutter tạo

20.000 Widget.

Đúng

```dart
ListView.builder()
```

---

# 10. Không Pagination (0.5 điểm)

API đang tải toàn bộ.

Nên

```text
?page=1&pageSize=50
```

---

# 11. Không Retry Strategy (0.5 điểm)

API lỗi

↓

Không Retry.

MQTT mất kết nối

↓

Không Retry.

---

# 12. MQTT và UI đang Coupling (0.5 điểm)

Widget

↓

MQTT

Sai.

MQTT nên nằm trong

Datasource

hoặc

Repository.

---

# 13. Không dispose Resource khác (0.5 điểm)

Nếu sau này thêm

* AnimationController
* TextEditingController
* Timer

rất dễ quên dispose.

Senior thường review vấn đề này.

---

# 14. Không tách Business Logic (0.5 điểm)

Widget đang:

* gọi API
* cập nhật dữ liệu
* nghe MQTT
* render UI

Vi phạm SRP.

---

# 15. Không có Dependency Injection (0.5 điểm)

Sai

```dart
final mqttClient = MQTTClient();
```

Nên Inject

```dart
DeviceRepository

DeviceService

MQTTService
```

qua GetIt hoặc Constructor Injection.

---

# Tổng hợp lỗi

| STT | Lỗi                             | Điểm |
| --- | ------------------------------- | ---- |
| 1   | Không dispose MQTT              | 1    |
| 2   | Không cancel StreamSubscription | 1    |
| 3   | UI gọi API trực tiếp            | 1    |
| 4   | Không Repository Pattern        | 1    |
| 5   | Không xử lý Exception           | 1    |
| 6   | Không Loading State             | 0.5  |
| 7   | Không Error State               | 0.5  |
| 8   | setState rebuild toàn màn hình  | 1    |
| 9   | ListView(children)              | 1    |
| 10  | Không Pagination                | 0.5  |
| 11  | Không Retry                     | 0.5  |
| 12  | MQTT Coupling                   | 0.5  |
| 13  | Không dispose Resource          | 0.5  |
| 14  | Business Logic trong UI         | 0.5  |
| 15  | Không Dependency Injection      | 0.5  |

> **Lưu ý:** Chỉ chấm tối đa **10 điểm**.

---

# Điểm cộng

Nếu ứng viên đề cập thêm:

* Immutable State
* Event Debounce
* Bloc thay cho setState
* Isolate cho JSON lớn
* Cache dữ liệu
* Logging
* Monitoring
* Unit Test
* Widget Test
* Lint Rule
* SOLID
* Dependency Inversion
* Interface Segregation

=> Có thể đánh giá là **Senior mạnh**.

---

# Dấu hiệu của Senior

Ứng viên không chỉ chỉ ra lỗi mà còn giải thích:

* Vì sao đây là vấn đề.
* Ảnh hưởng tới Production.
* Cách refactor.
* Trade-off giữa các giải pháp.

Ví dụ:

> "Tôi sẽ không đưa MQTTClient vào Widget vì điều đó làm UI phụ thuộc vào tầng giao tiếp thiết bị. Tôi sẽ đặt MQTT trong DataSource, Repository chỉ cung cấp Stream<DeviceStatus> cho Bloc, còn UI chỉ lắng nghe State."

Đây là câu trả lời thể hiện tư duy kiến trúc thay vì chỉ sửa cú pháp.

---

# Rubric chấm điểm

| Mức độ        | Đánh giá                                                                                         |
| ------------- | ------------------------------------------------------------------------------------------------ |
| **9–10 điểm** | Tìm được ≥10 lỗi, giải thích rõ nguyên nhân, đề xuất refactor hợp lý, thể hiện tư duy kiến trúc. |
| **7–8 điểm**  | Tìm được 8–9 lỗi, hiểu phần lớn vấn đề về Performance và Clean Architecture.                     |
| **5–6 điểm**  | Tìm được 5–7 lỗi, chủ yếu ở mức cú pháp và hiệu năng, ít đề cập kiến trúc.                       |
| **3–4 điểm**  | Chỉ phát hiện các lỗi cơ bản như `ListView`, `dispose`, `setState`.                              |
| **<3 điểm**   | Chưa có kỹ năng review code ở mức Senior.                                                        |
