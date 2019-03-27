//
//  UIDevice+UniqueId.h
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-30.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (UniqueId)
/*
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */

- (NSString *) uniqueDeviceIdentifier;

/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */

//暂时不用
- (NSString *) uniqueGlobalDeviceIdentifier;
- (NSString *) macaddress;
@end
