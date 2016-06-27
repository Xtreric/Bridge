//
//  globalCode.swift
//  Cobweb
//
//  Created by Eric Huang on 2016/6/24.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import Foundation

// 擴充方法
extension String {
    //網址編碼方法
    var URLEncoded:String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = NSCharacterSet(charactersInString: unreservedChars)
        let encodedString = self.stringByAddingPercentEncodingWithAllowedCharacters(unreservedCharset)
        return encodedString ?? self
    }
}

// defaultsKeys結構: key = UserTokenJson
struct defaultsKeys {
    static let UserTokenJson = ""
    static let TokenJson = ""
}
// 全域變數
var curUserData = UserData()