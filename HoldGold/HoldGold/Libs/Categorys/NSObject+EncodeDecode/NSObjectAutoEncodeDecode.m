//
//  NSObjectAutoEncodeDecode.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 14-1-16.
//  Copyright (c) 2014年 zsgjs. All rights reserved.
//

#import "NSObjectAutoEncodeDecode.h"
#import <objc/runtime.h>

@implementation NSObjectAutoEncodeDecode
+ (void)encodeObject:(id)obj withCoder:(NSCoder *)encoder {
	Class cls = [obj class];
	while (cls != [NSObject class]) {
		unsigned int numberOfIvars = 0;
		Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
		for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++){
			Ivar const ivar = *p;
			const char *type = ivar_getTypeEncoding(ivar);
			NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
			id value = [obj valueForKey:key];
			if (value) {
				switch (type[0]) {
					case _C_STRUCT_B: {
						NSUInteger ivarSize = 0;
						NSUInteger ivarAlignment = 0;
						NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
						NSData *data = [NSData dataWithBytes:(const char *)obj + ivar_getOffset(ivar)
													  length:ivarSize];
						[encoder encodeObject:data forKey:key];
					}
						break;
					default:
						[encoder encodeObject:value
									   forKey:key];
						break;
				}
			}
		}
        free(ivars);
		cls = class_getSuperclass(cls);
	}
}

+ (id)initObject:(id)obj withCoder:(NSCoder *)decoder {
	if (obj) {
		Class cls = [obj class];
		while (cls != [NSObject class]) {
			unsigned int numberOfIvars = 0;
			Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
			
			for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++){
				Ivar const ivar = *p;
				const char *type = ivar_getTypeEncoding(ivar);
				NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
				id value = [decoder decodeObjectForKey:key];
				if (value) {
					switch (type[0]) {
						case _C_STRUCT_B: {
							NSUInteger ivarSize = 0;
							NSUInteger ivarAlignment = 0;
							NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
							NSData *data = [decoder decodeObjectForKey:key];
							char *sourceIvarLocation = (char*)obj+ ivar_getOffset(ivar);
							[data getBytes:sourceIvarLocation length:ivarSize];
						}
							break;
						default:
							[obj setValue:[decoder decodeObjectForKey:key]
                                   forKey:key];
							break;
					}
				}
			}
            free(ivars);
			cls = class_getSuperclass(cls);
		}
	}
	
	return obj;
}

@end
