//
//  NSString+Extension.m
//  rlmobile
//
//  Created by Boom on 2018/7/12.
//  Copyright © 2019年 rlmobile. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+NSData_AES.h"

#define ENCRYPT_KEY     @"1936168592476099"

@implementation NSString (Extension)

- (NSString *)addFF {
    return [NSString stringWithFormat:@"%@  FF",self ];
}

- (NSString*)concatPath:(NSString*)pathString
{
  if(!pathString || pathString.length <= 0){
    return nil;
  }
  if ([pathString hasPrefix:@"http"]) {
    return pathString;
  }
  
  if ([self hasSuffix:@"/"] && [pathString hasPrefix:@"/"]) {
    pathString = [pathString substringFromIndex:1];
    return [NSString stringWithFormat:@"%@%@",self,pathString];
  } else if (![self hasSuffix:@"/"] && ![pathString hasPrefix:@"/"]) {
    return [NSString stringWithFormat:@"%@/%@", self, pathString];
  }
  return [NSString stringWithFormat:@"%@%@",self,pathString];
}

- (NSString *)string02XFromMD5
{
  if(self == nil || [self length] == 0)
  return nil;
#if 0
  const char *value = [self UTF8String];
  
  unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
  CC_MD5(value, strlen(value), outputBuffer);
  
  NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
    [outputString appendFormat:@"%02x",outputBuffer[count]];
  }
  
  return [outputString autorelease];
#else
  const char *cStr = [self UTF8String];
  unsigned char result[20];
  CC_MD5( cStr, strlen(cStr), result );
  return [NSString stringWithFormat:
          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
          result[0], result[1], result[2], result[3],
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ];
#endif
}

//解密
+ (NSString *)AESDecryptWithString:(NSString *)aStr
{
  NSData *base64Data = [[NSData alloc]initWithBase64EncodedString:aStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
  NSData *aesData = [base64Data AES256DecryptWithKey:ENCRYPT_KEY];
  NSString *result = [[NSString alloc] initWithData:aesData encoding:NSUTF8StringEncoding];
  return result;
}

//加密
+ (NSString *)AESEncryptWithString:(NSString *)aStr
{
  NSData *data = [aStr dataUsingEncoding:NSUTF8StringEncoding];
  NSData *aesData = [data AES256EncryptWithKey:ENCRYPT_KEY];
  NSString *base64Str = [aesData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  return base64Str;
}

//解密
+ (NSString *)AESDecryptWithString:(NSString *)aStr withKey:(NSString *)key{
  NSData *base64Data = [[NSData alloc]initWithBase64EncodedString:aStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
  NSData *aesData = [base64Data AES256DecryptWithKey:key];
  NSString *result = [[NSString alloc] initWithData:aesData encoding:NSUTF8StringEncoding];
  return result;
}

//加密
+ (NSString *)AESEncryptWithString:(NSString *)aStr withKey:(NSString *)key{
  NSData *data = [aStr dataUsingEncoding:NSUTF8StringEncoding];
  NSData *aesData = [data AES256EncryptWithKey:key];
  NSString *base64Str = [aesData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  return base64Str;
}


- (BOOL)isEqualToStringCaseInsensitive:(NSString*)string
{
  return [self caseInsensitiveCompare:string] == NSOrderedSame;
}

@end
