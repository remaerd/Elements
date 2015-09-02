[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/remaerd/Elements)
[![Version](https://img.shields.io/github/release/soffes/Crypto.svg)](https://github.com/remaerd/Elements/releases)
[![License](https://img.shields.io/pypi/l/Django.svg)](https://github.com/remaerd/Elements/blob/master/LICENSE)


# Elements - XML 建模框架
*Please help me translate the README documentation. Thanks!*


## 干嘛用

```swift

let xmlString = "<feed url=\"example.com\"><articles><article>Hello World</article></articles></feed>"
let models : [ElementType.Type] = [Feed.self,Article.self]
let xml = Elements.XML(xml: xmlString, models: models)

xml.decode { (rootElements, errors) -> Void in
	let feed = rootElements[0] as! Feed
	let article = feed.articles[0]
	print(article.title) // "Hello World"
}

```

Elements 是一个没有学习曲线的 XML 建模框架。 Elements 简化了大部分 NSXMLParser 的复杂接口并提供一系列简单易懂的建模接口。

## 核心思路

每一个需要支持 XML 建模的模型（Models），必须添加 ```ElementType``` 协议（Protocol）的支持。 通过 ```XML``` 对象，你能够轻松地将 XML 文档转换成模型，或将模型转换成 XML 文件。


## 最佳实践

### Carthage

需要使用 Elements 请安装 Carthage 并在 Cartfile 内加入

```
	github "remaerd/Elements"
```

### 简单样例代码

```swift

class Feed : ElementType {

	enum Error : ErrorType {
		case InvalidURL
	}

	let url : String

	required init(parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws {
		self.url = attributes["url"]
		if self.title == nil { throw InvalidTitle }
	}

	func child(element: ElementType) {
		if let comment = element as? Comment {
			self.comments.append(comment)
		}
	}
}


class Article : ElementType {
	
	enum Error : ErrorType {
		case InvalidTitle
	}

	unowned let feed : Feed!
	let title : String!
	var content : String?

	static var element : String {
		return "item"
	}

	required init(parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws {
		self.feed = parent as! Feed
		self.title = attributes["title"]
		self.content = attributes["content"]
		if self.title == nil { throw InvalidTitle }
	}
}


let xmlString = "<feed url=\"example.com\"><items><item>Hello World</item></items></feed>"
let models : [ElementType.Type] = [Feed.self,Article.self]
let xml = Elements.XML(xml: xmlString, models: models)

xml.decode { (rootElements, errors) -> Void in
	let feed = rootElements[0] as! Feed
	let article = feed.articles[0]
	print(article.title) // "Hello World"
}

```
