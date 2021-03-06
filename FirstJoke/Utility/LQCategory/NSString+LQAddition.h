//
//  NSString+LQAddition.h
//  LQBaseProject
//
//  Created by 刘伟强 on 16/8/19.
//  Copyright © 2016年 刘伟强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DateTools.h>
@interface NSString (LQAddition)
/**
 *  调整行间距
 *
 *  @param spacing 行间距
 *
 *  @return 调整好行间距的字符串
 */
- (NSMutableAttributedString *)getSpaceStr:(CGFloat)spacing;
/**
 *  时间戳字符串 转 时间字符串
 *
 *  @return 时间字符串
 */
- (NSString *)getTimeStrOfTimeStamp;
/**
 *  字符串转二进制
 *
 *  @return nadate
 */
- (NSData *)hexData;
/**
 *  是否包含某个字符串
 *
 *  @param string 包含的字符串
 *
 *  @return bool
 */
- (BOOL)containsString:(NSString *)string;
/**
 *  验证是否是手机号
 *
 *  @return bool
 */
- (BOOL)isTelephoneNumber;
/**
 *  验证 是否 是6 - 18 位 字母 或 数字
 *
 *  @return bool
 */
- (BOOL)isVaildPasswordWithMoreThan6LessThan18NumbersOrLetters;

/**
 *  去掉字符串中的空格
 */
- (NSString *)getNOSpaceStr;

/**
 *  Create a MD5 string from self
 *
 *  @return Returns the MD5 NSString from self
 */
- (NSString *)MD5;
/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *) dictionaryValue;

/**
 *  检查是够是邮箱
 *
 *  @return Returns YES if it's an email, NO if not
 */
- (BOOL)isEmail;

@end
