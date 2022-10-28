# hacocms-ios-sdk

API client library for iOS of [hacoCMS](https://hacocms.com/).

# Step 1. hacoCMSのAPIスキーマ設定
お持ちのhacoCMSアカウントの適当なプロジェクト（無ければ作成してください）に、ブログ記事のAPIを以下の設定で作成してください。[APIの作成方法についてはhacoCMSのドキュメント](https://hacocms.com/docs/entry/api-create)をご確認ください。

- API名：`記事`（任意）
- エンドポイント：`entries`
- 説明文：（任意）
- APIの型：`リスト形式`
- APIスキーマ：`下記の表と画像を参照`

| # | details              | フィールド名（任意） | フィールド ID     |
| --|----------------------| -----------------|-----------------|
| 1 | テキストフィールド       | タイトル          | `title`          |
| 2 | テキストフィールド       | 概要             | `description`    |
| 3 | リッチテキスト          | 本文             | `body`           |

# Step 2. Installation a SDK

## CocoaPods

Bạn có thể cài đặt HacocmsiOSSDK thông qua [CocoaPds](https://cocoapods.org/) bằng việc thêm nó vào file `Podfile`:
```
pod 'HacocmsiOSSDK'
```
Sau đó thực thi terminal `pod install`.

## Carthage

Bạn có thể cài đặt HacocmsiOSSDK thông qua [Carthage](https://github.com/Carthage/Carthage) bằng việc thêm nó vào file `Cartfile`:

```
github "hacocms/HacocmsiOSSDK"
```

## Swift Package Manager

Bạn có thể cài đặt HacocmsiOSSDK thông qua [Swift Package Manager](https://swift.org/package-manager/) bằng việc thêm nó vào file `Package.swift`:

```swift
import PackageDescription

let package = Package(
    [...]
    dependencies: [
        .package(url: "https://github.com/hacocms/HacocmsiOSSDK.git", from: "1.0.0"),
    ]
)
```

# Step 3. Usage

**Tạo đối tượng client**
```swift
let client = HacoCmsClient(
    subDomain: SUB_DOMAIN, // Sub domain in project basic settings
    accessToken: ACCESS_TOKEN, // Access-Token for the project
    draftToken: PROJECT_DRAFT_TOKEN, // Optional: Project-Draft-Token for your project
    loggingRequest: true // Optional: Using for log for request
)
```

Để maping được kết quả trả về từ API, chúng ta tạo Object được extends từ `Codable`:

```swift
class HacoContent: Codable {
    let data: [Entry]
}

class Entry: Codable {
    let id: String
    let title: String
    let description: String
    let body: String
}
```

Thư viện có hỗ trợ 2 cách triển khai code, bạn có thể sử dụng Closures hoặc Combine để xử lý kết quả phía API trả về


## Sử dụng Closures

```swift

// Get Content List
// returnType: Object is extended from Codable
// includingDraft: Retrieve the list of content that include draft articles
client.getListContent(returnType: HacoContent.self, path: "/entries") { result in
    switch result {
    case .success(let response):
        print(response.data)
    case .failure(let error):
        print(error)
    }
}

// Get Single Content
client.getSingleContent(returnType: User.self, path: "/user"){ result in
    switch result {
    case .success(let response):
        print(response)
    case .failure(let error):
        print(error)
    }
}

// Get Detail Content
client.getDetailContent(returnType: Content.self, path: "/posts", contentId: "contentID", draftToken: "draft_token") { result in
    switch result {
    case .success(let response):
        print(response)
    case .failure(let error):
        print(error)
    }
}
```

## Sử dụng Combine

```swift

// Get Content List
// returnType: Object is extended from Codable
// includingDraft: Retrieve the list of content that include draft articles
client.getListContent(returnType: HacoContent.self, path: "/entries", query: query, includingDraft: false)
    .convertToResult()
    .sink(receiveValue: { result in
        switch result {
        case .success(let response):
            print(response.data)
        case .failure(let error):
            print(error)
        }
    })
    .store(in: &subscriptions)


// Get Single Content
client.getSingleContent(returnType: User.self, path: "/user")
    .convertToResult()
    .sink(receiveValue: { result in
        switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
        }
    })
    .store(in: &subscriptions)


// Get Detail Content
client.getDetailContent(returnType: Content.self, path: "/posts", contentId: "contentID", draftToken: "draft_token")
    .convertToResult()
    .sink(receiveValue: { result in
        switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
        }
    })
    .store(in: &subscriptions)


```

# Parameters
Thư viện cũng hỗ trợ bạn định nghĩa các parameter cần chỉ định khi request API

```swift
client.getListContent(returnType: ResponseData.self, path: "/posts", query: QueryBuilder(limit: 3, s: "-updatedAt")) { result in
    switch result {
    case .success(let response):
        print(response.data)
    case .failure(let error):
        print(error)
    }
}
```
[hacoCMS APIリファレンス](https://hacocms.com/references/content-api)
