//
//  XLEncrytHelper.h
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-27.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface XLEncrytHelper : NSObject
+ (NSString *) md5:(NSString *)str;
+ (NSString *) desEncryptStr:(NSString *)str key:(NSString *)key;
+ (NSString *) desDecryptStr:(NSString	*)str key:(NSString *)key;


#pragma mark Based64 methods
+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

#pragma mark url methods

// 把 要进行URL编码的字符串中特殊字符编码 (+ -> %2B)
+ (void)encodeSpecialUrlCharacters:(NSMutableString*)encodeStr;

// 把编码中的特殊字符替换为占位符，（/ -> @@）
+ (NSUInteger)encodeSpecialCharacters:(NSMutableString*)encryptStr;

// 把编码中的占位符替换为特殊字符，（@@ -> /）
+ (NSUInteger)decodeSpecialCharacters:(NSMutableString*)encryptStr;


+ (NSString *) newDesEncryptStr:(NSString *)str key:(NSString *)key;
+ (NSString *) newDesDecryptStr:(NSString	*)str key:(NSString *)key;
+ (NSString *) newNewDesDecryptStr:(NSString	*)str key:(NSString *)key;


//+ (NSString *)newNewDoCipher:(NSString *)sTextIn key:(NSString *)sKey;


+ (NSString *)newDesEncryptStrWithoutEncode:(NSString *)str key:(NSString *)key;

+ (void)encodeSpecialDownDataCharacters:(NSMutableString *)encodeStr;

+ (NSString *)newWithoutEncodeDoCipher:(NSString *)sTextIn key:(NSString *)sKey
                                 context:(CCOperation)encryptOrDecrypt;


@end
