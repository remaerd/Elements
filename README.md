[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/remaerd/Elements)
[![Version](https://img.shields.io/github/release/soffes/Crypto.svg)](https://github.com/remaerd/Elements/releases)
[![License](https://img.shields.io/pypi/l/Django.svg)](https://github.com/remaerd/Elements/blob/master/LICENSE)


# Elements - XML 建模框架
*Please help me translate the README documentation. Thanks!*


## 干嘛用

```swift

let xmlString = "<feed url=\"example.com\"><articles><article>Hello World</article></articles></feed>"
let classes : [ElementType.Type] = [Feed.self,Article.self]
let xml = Elements.XML(xml: xmlString, models: classes)

xml.decode { (rootElements, errors) -> Void in
  let feed = rootElements[0] as! Feed
  let article = feed.articles[0]
  print(article.title) // "Hello World"
}

```

Elements 是一个没有学习曲线的 XML 建模框架。 Elements 简化了大部分 NSXMLParser 的复杂接口并提供了一系列建模接口，并提供了一套简单的 XML 数据验证规则（Rule）。让你不需另外学习使用 DTD， XML Schema 等麻烦且不实用的 XML 验证方式。

## 核心思路

每一个需要支持 XML 建模的模型（Models），必须添加 ```ElementType``` 协议（Protocol）的支持。 当你需要将 XML 文档转换成模型（Models）时， 框架会根据你在模型内设置的 XML 标签（tag）和相应的规则（Rule）进行建模。 当 XML 文档不符合建模规则时，框架会报错并结束建模。


## 最佳实践

### Carthage

需要使用 Elements 请安装 Carthage 并在 Cartfile 内加入

```
	github "remaerd/Elements"
```

<!-- ### 储存在本地的加密数据

用户的数据不应该直接使用密码字串符加密。当你需要加密数据时，你必须使用对称密钥加密用户的数据，再用密码加密对称密钥。 同理，当你需要解密数据时。你需要通过密码解密对称密钥，再用对称密钥解密用户的数据。

#### 新建密码

```swift
	let password = Password("Hello")
	let salt = password.salt // 盐
	let rounds = password.rounds // Rounds
	let data = password.data // 由密码和盐计算出来的密钥
```

每次新建密码会自动生成一个随机盐和 Round 值。当你使用相同的密码但不同的盐 ／ Round 值生成密码后，新的 Password 不能够解密之前用 Password 加密过的数据。
你不应该将用户的密码明文保存到本地，但你需要将盐和 Rounds 保存到本地。当创建密码时，你应该重新问用户获取密码，再用盐和 Rounds 重建密码。

#### 新建对称密钥

```swift
	let key = SymmetricKey()
	let encryptionKey = key.cryptoKey // 加密用的密钥
	let iv = key.IV // IV
	let hmacKey = key.hmacKey // 生成 MAC （ 数据验证码 Message Authentication Code） 用的密钥
```

每次新建对称密钥会自动生成一个随机 IV 值和 验证数据用的 HMAC。当你需要保留密钥时，你需要同时在本地存储 cryptoKey，IV，和 hmac。

#### 加密数据

```swift
	let key = SymmetricKey()
	let data = "Hello World!".dataUsingEncoding(NSUTF8StringEncoding)!
	do {
		let encryptedData = try key.encrypt(data)
		print(encryptedData)
	} catch {
		print("Cannot encrypt data")
	}
```

#### 解密数据

```swift
	let key = SymmetricKey(key: keyData, hmacKey: hmacData, IV: IVData)
	do {
		let decryptedData = try key.decrypt(data)
		print(decryptedData)
	} catch {
		print("Cannot decrypt data")
	}
```

### 需要传输的加密数据

当你需要将某些加密数据传输到第三方时，你需要使用非对称密钥。你可以想象一个金库有两把钥匙，一把能够用来将黄金放进金库，一把能够用来取出黄金。当你需要传输数据时，你在本地使用其中一把钥匙加密数据后，你将另一把钥匙和数据传输到另外一个设备，另外一个设备就能够解密你的数据。

#### 新建非对称密钥

```swift
	let keys = AsymmetricKeys()
	let cryptoKeys = keys.keys // 加密/解密用的一对密钥
	let validationKeys = key.validationKeys // 验证数据用的一对密钥
```

每次生成新的非对称密钥。将会同时生成两对密钥。四个钥匙分别负责加密，解密，获得数据签名，验证数据。当传输数据时，你需要将加密后的数据，以及 cryptoKeys 的 publicKey， validationKeys.publicKey 同时发送到数据接收者的设备。

#### 加密数据

```swift
	let data = "Hello World!".dataUsingEncoding(NSUTF8StringEncoding)!
	let keys = AsymmetricKeys()
	let privateKey = keys.keys.privateKey
	do {
		let encryptedData = try privateKey.encrypt(data)
	} catch {
		print("Cannot encrypt data")
	}
```

#### 解密数据

```swift
	let key = PublicKey(keyData)
	do {
		let decryptedData = privateKey.decrypt(data)
	} catch {
		print("Cannot decrypt data")
	}
``` -->

