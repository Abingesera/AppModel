//
//  NSString+Common.m
//  NewHoldGold
//
//  Created by zsgjs on 2017/11/21.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}



+ (NSString *)UUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}

#pragma mark - init string with data

+ (instancetype)stringWithUTF8Data:(NSData*)data
{
    NSString* string = [[self class] stringWithData:data usingEncoding:NSUTF8StringEncoding];
    return string;
}

+ (instancetype)stringWithData:(NSData*)data usingEncoding:(NSStringEncoding)encoding
{
    NSString* string = [[NSString alloc] initWithData:data encoding:encoding];
    return string;
}

#pragma mark - string methods

- (NSArray*)split:(NSString*)separator
{
    return [self componentsSeparatedByString:separator];
}

- (NSString*)replaceAll:(NSString*)target with:(NSString*)replacement
{
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSString*)substringFromIndex:(NSUInteger)begin toIndex:(NSUInteger)end
{
    if (end <= begin) {
        return nil;
    }
    NSRange range = NSMakeRange(begin, end - begin);
    return [self substringWithRange:range];
}

- (NSString*)stringByTrimmingNewLineCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

- (NSString*)stringByTrimmingWhiteAndNewLineCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)urlEncoded
{
    NSString *encoded = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                              (__bridge CFStringRef)self,
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                              kCFStringEncodingUTF8);
    return encoded;
}

- (NSString *)urlDecode {
    
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

- (NSString *)encodeStringWithUTF8
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)substringWithRegex:(NSString *)regex
{
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
    NSRange range = [regexExp rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (range.location == NSNotFound) {
        return nil;
    } else {
        return [self substringWithRange:range];
    }
}

- (NSString *)reverse
{
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[self substringWithRange:subStrRange]];
    }
    
    return reversedString;
}

- (NSComparisonResult)compareTo:(NSString *)anotherString
{
    return [self compare:anotherString];
}

- (NSComparisonResult)compareToIgnoreCase:(NSString *)string
{
    return [self compare:string options:NSCaseInsensitiveSearch];
}

- (BOOL)contains:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

- (BOOL)startsWith:(NSString *)prefix
{
    return [self hasPrefix:prefix];
}

- (BOOL)endsWith:(NSString*)suffix
{
    return [self hasSuffix:suffix];
}

- (BOOL)equals:(NSString *)anotherString
{
    return [self isEqualToString:anotherString];
}

- (BOOL)equalsIgnoreCase:(NSString*)anotherString
{
    return ([self caseInsensitiveCompare:anotherString] == NSOrderedSame);
}

- (NSInteger)indexOfChar:(unichar)ch
{
    return [self indexOfChar:ch fromIndex:0];
}

- (NSInteger)indexOfChar:(unichar)ch fromIndex:(int)index
{
    int len = (int)self.length;
    for (int i = index; i < len; i++) {
        if (ch == [self characterAtIndex:i]) {
            return i;
        }
    }
    return NSNotFound;
}

- (NSInteger)indexOfString:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    
    return range.location;
}

- (NSInteger)indexOfString:(NSString *)string fromIndex:(int)index
{
    NSRange fromRange = NSMakeRange(index, self.length - index);
    NSRange range = [self rangeOfString:string options:NSLiteralSearch range:fromRange];
    
    return range.location;
}

- (NSInteger)lastIndexOfChar:(unichar)ch
{
    int len = (int)self.length;
    for (int i = len-1; i >=0; i--) {
        if ([self characterAtIndex:i] == ch) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (NSInteger)lastIndexOfChar:(unichar)ch fromIndex:(int)index
{
    int len = (int)self.length;
    if (index >= len) {
        index = len - 1;
    }
    for (int i = index; i >= 0; i--) {
        if ([self characterAtIndex:i] == ch) {
            return index;
        }
    }
    
    return NSNotFound;
}

- (NSInteger)lastIndexOfString:(NSString *)string
{
    NSRange range = [self rangeOfString:string options:NSBackwardsSearch];
    
    return range.location;
}

- (NSInteger)lastIndexOfString:(NSString *)string fromIndex:(int)index
{
    NSRange fromRange = NSMakeRange(0, index);
    NSRange range = [self rangeOfString:string options:NSBackwardsSearch range:fromRange];
    
    return range.location;
}

#pragma mark - validate file name, email, mobile

- (BOOL)isValidFileName
{
    NSCharacterSet* characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\\/:*?\"<>|"];
    NSRange range = [self rangeOfCharacterFromSet:characterSet];
    return range.location == NSNotFound;
}

- (BOOL)isValidEmailAddress
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailPredicate evaluateWithObject:self];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidMobileNumber
{
    //手机号以13，14，15，17，18开头，九个 \d 数字字符
    NSString *phoneRegex = @"^((13)|(14)|(15)|(17)|(18))\\d{9}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phonePredicate evaluateWithObject:self];
}

- (BOOL)isInternationValidMobileNumber{
    NSString *phoneRegex = @"^011(999|998|997|996|995|994|993|992|991| 990|979|978|977|976|975|974|973|972|971|970| 969|968|967|966|965|964|963|962|961|960|899| 898|897|896|895|894|893|892|891|890|889|888| 887|886|885|884|883|882|881|880|879|878|877| 876|875|874|873|872|871|870|859|858|857|856| 855|854|853|852|851|850|839|838|837|836|835| 834|833|832|831|830|809|808|807|806|805|804| 803|802|801|800|699|698|697|696|695|694|693| 692|691|690|689|688|687|686|685|684|683|682| 681|680|679|678|677|676|675|674|673|672|671| 670|599|598|597|596|595|594|593|592|591|590| 509|508|507|506|505|504|503|502|501|500|429| 428|427|426|425|424|423|422|421|420|389|388| 387|386|385|384|383|382|381|380|379|378|377| 376|375|374|373|372|371|370|359|358|357|356| 355|354|353|352|351|350|299|298|297|296|295| 294|293|292|291|290|289|288|287|286|285|284| 283|282|281|280|269|268|267|266|265|264|263| 262|261|260|259|258|257|256|255|254|253|252| 251|250|249|248|247|246|245|244|243|242|241| 240|239|238|237|236|235|234|233|232|231|230| 229|228|227|226|225|224|223|222|221|220|219| 218|217|216|215|214|213|212|211|210|98|95|94| 93|92|91|90|86|84|82|81|66|65|64|63|62|61|60| 58|57|56|55|54|53|52|51|49|48|47|46|45|44|43| 41|40|39|36|34|33|32|31|30|27|20|7|1)[0-9]{0, 14}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}

//url
- (BOOL)isURLRegular{
    
    NSString *urlRegular = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegular
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];

    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [self substringWithRange:match.range];
        NSLog(@"substringForMatch - %@", substringForMatch);
        return YES;
    }
    return NO;
}

#pragma mark -- nil string
///返回非nil字符串，为nil则返回@""
- (NSString *)nonilString
{
    return self ? self : @"";
}

///判断是否为nil、NULL、@“”
+ (BOOL)isNil:(NSString *)string
{
    BOOL isNil = NO;
    if (!string)
    {
        isNil = YES;
    }
    else if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@""])
    {
        isNil = YES;
    }
    else if ([string isEqual:[NSNull null]])
    {
        isNil = YES;
    }
    
    return isNil;
}

#pragma mark - pinyin

//- (NSString *)pinYin
//{
//    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
//    [outputFormat setToneType:ToneTypeWithoutTone];
//    [outputFormat setVCharType:VCharTypeWithV];
//    [outputFormat setCaseType:CaseTypeLowercase];
//
//    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:self
//                                               withHanyuPinyinOutputFormat:outputFormat
//                                                              withNSString:@""];
//    return outputPinyin;
//}
//
//- (NSString *)jianPin
//{
//    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
//    [outputFormat setToneType:ToneTypeWithoutTone];
//    [outputFormat setVCharType:VCharTypeWithV];
//    [outputFormat setCaseType:CaseTypeLowercase];
//
//    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:self
//                                               withHanyuPinyinOutputFormat:outputFormat
//                                                              withNSString:@" "];
//
//    NSArray *array = [outputPinyin componentsSeparatedByString:@" "];
//    NSMutableArray *firstLetters = [[NSMutableArray alloc] init];
//    for (NSString *string in array) {
//        if (string && string.length >= 1) {
//            [firstLetters addObject:[string substringToIndex:1]];
//        }
//    }
//
//    return [firstLetters componentsJoinedByString:@""];
//}

#pragma mark - to date

- (NSDate *)toDateWithFormatter:(NSString *)formatter
{
    if (self.length == 0) {
        return nil;
    }
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
    }
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:self];
}

- (NSDate *)toDate;
{
    return [self toDateWithFormatter:@"yyyy-MM-dd"];
}

- (NSDate *)toDateTime;
{
    return [self toDateWithFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate *)toFullDateTime;
{
    return [self toDateWithFormatter:@"yyyy-MM-dd HH:mm:ss zzz"];
}

- (NSDate *)toTime;
{
    return [self toDateWithFormatter:@"HH:mm:ss"];
}

#pragma mark - encrypt & decrypt

- (NSString *)md5String32:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

- (NSString *)md5String16:(NSString *)srcString
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self md5String32:srcString];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

//动态计算文字的高度
- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

#pragma mark 计算字体自适应大小
- (CGSize)calculateTextWidthWithFont:(UIFont *)font AndWithMAXWidth:(CGFloat)MaxWidth AndWithMaxHeigth:(CGFloat)MaxHeight{
    if (kStringIsEmpty(self)) {
        return CGSizeZero;
    }
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(MaxWidth, MaxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSKernAttributeName:@0.0f,NSFontAttributeName:font} context:nil].size;
    return textSize;
    
}

//计算富文本的高度
-(CGSize)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

/**
 *  设置段落样式
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    return attriStr;
}


#pragma mark == 时间比较去重
+(NSString *)dateCompare:(NSString *)str1 withStr:(NSString *)str2{
    
    NSString *dateStr;
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd";
    // 开始时间data格式
    NSDate *startDate = [dateFomatter dateFromString:str1];
    // 截止时间data格式
    NSDate *endDate = [dateFomatter dateFromString:str2];
    NSInteger startYear = [startDate year];
    NSInteger endYear = [endDate year];
    //是不是同一年
    if (endYear - startYear == 0) {
        dateFomatter.dateFormat = @"yyyy年MM月dd日";
        NSString *startStr = [dateFomatter stringFromDate:startDate];
        dateFomatter.dateFormat = @"MM月dd日";
        NSString *endStr = [dateFomatter stringFromDate:endDate];
        dateStr = [NSString stringWithFormat:@"%@-%@",startStr,endStr];
        if ([startDate month] == [endDate month] && [startDate day] == [endDate day]) {//同一天
            dateStr = [NSString stringWithFormat:@"%@",startStr];
        }
        return dateStr;
    }else{
        dateFomatter.dateFormat = @"yyyy年MM月dd日";
        NSString *startStr = [dateFomatter stringFromDate:startDate];
        NSString *endStr = [dateFomatter stringFromDate:endDate];
        return [NSString stringWithFormat:@"%@-%@",startStr,endStr];
    }
}

+(NSString *)dateStrCompare:(NSString *)startStr withStr:(NSString *)endStr{
    
    NSString *dateStr;
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd";
    // 开始时间data格式
    NSDate *startDate = [dateFomatter dateFromString:startStr];
    // 截止时间data格式
    NSDate *endDate = [dateFomatter dateFromString:endStr];
    
    NSInteger startYear = [startDate year];
    NSInteger endYear = [endDate year];
    //是不是同一年
    if (endYear - startYear == 0) {
        dateFomatter.dateFormat = @"MM.dd";
        NSString *startStr = [dateFomatter stringFromDate:startDate];
        NSString *endStr = [dateFomatter stringFromDate:endDate];
        dateStr = [NSString stringWithFormat:@"%@-%@",startStr,endStr];
        return dateStr;
    }else{
        dateFomatter.dateFormat = @"yyyy.MM.dd";
        NSString *startStr = [dateFomatter stringFromDate:startDate];
        NSString *endStr = [dateFomatter stringFromDate:endDate];
        return [NSString stringWithFormat:@"%@-%@",startStr,endStr];
    }
}

@end
