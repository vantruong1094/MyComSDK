# hacocms-ios-sdk

API client library for iOS of [hacoCMS](https://hacocms.com/).

## Usage

```swift
let client = HacoCmsClient(
    subDomain: SUB_DOMAIN, // Sub domain in project basic settings
    accessToken: ACCESS_TOKEN, // Access-Token for the project
    draftToken: PROJECT_DRAFT_TOKEN, // Optional: Project-Draft-Token for your project
    loggingRequest: true // Optional: Using for log for request
)

// Using for pass parameters in request
let query = QueryBuilder(
    limit: 3,
    s: "-updatedAt"
)

// Get Content List
// returnType: Object is extended from Codable
// includingDraft: Retrieve the list of content that include draft articles
client.getListContent(returnType: ResponseData.self, path: "/posts", query: query, includingDraft: false)
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


// Get Single Content
client.getSingleContent(returnType: Decodable.Protocol, path: String)


// Get Detail Content
client.getDetailContent(returnType: Decodable.Protocol, path: String, contentId: String, draftToken: String?)


```
