[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/remaerd/Elements)
[![Version](https://img.shields.io/github/release/soffes/Crypto.svg)](https://github.com/remaerd/Elements/releases)
[![License](https://img.shields.io/pypi/l/Django.svg)](https://github.com/remaerd/Elements/blob/master/LICENSE)


# Elements - XML 模型框架
*Please help me translate the README documentation. Thanks!*


## 干嘛用

```swift

	import Elements


	class Root : ElementType {
  
  	static var tag  : String { return "root" }
  	var parent      : ElementType?
	}


	var xmlString = "<root version=\"1.0\"><tags><tag/><tag>Hello World<tag><tags></xml>"
	var xml = try XML(xml: xmlString)
	try xml.detectElementTypeWithClass(Root.self)
	xml.decode { (error) -> Void in
  	print(error)
	}

```

Elements 是一个没有学习曲线的 XML 模型框架。 Keys 简化了大部分 NSXMLParser 的复杂接口并提供了一系列模型（Models） 创建，验证等接口，满足你需要进行 XML 模型创建的任务。

## 了解 Element

每一个 XML Element 等同于软件中的 Model。 ｀｀｀<element>property</element>｀｀｀ 中的 <element> 相当于一个 Model。

每一个 XML Element 可将 Property（数据）放在两个地方， ｀｀｀<element attribute="12345">HelloWorld</element>｀｀｀ 中有两个数据： 12345 和 HelloWorld。 由 Elements 框架负责转换到响应数据的格式。

在将 XML 文档转换成 Models 的过程中， Elements 会根据 Rule（规则） 转换数据。当数据不符合规定时，会显示出错误的地方。


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

