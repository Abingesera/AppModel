//
//  NSString+Json.h
//  CCEF
//
//  Created by 掌金 on 2017/5/11.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Json)

-(id)JSONValue;

/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/*
 
 * @brief 把字典转换为格式化的JSON字符串
 
 * @param dic 要转换的字典
 
 * @return 返回字符串
 
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


//十六进制颜色转RGB
-(UIColor *)hexStringToColor;

@end
