//
//  NSString+Extension.h
//  rlmobile
//
//  Created by Boom on 2018/7/12.
//  Copyright © 2019年 rlmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (NSString *)addFF;

- (NSString*)concatPath:(NSString*)pathString;
- (NSString *)string02XFromMD5;

+ (NSString *)AESDecryptWithString:(NSString *)aStr;
+ (NSString *)AESEncryptWithString:(NSString *)aStr;

//解密
+ (NSString *)AESDecryptWithString:(NSString *)aStr withKey:(NSString *)key;

//加密
+ (NSString *)AESEncryptWithString:(NSString *)aStr withKey:(NSString *)key;

- (BOOL)isEqualToStringCaseInsensitive:(NSString*)string;
@end
