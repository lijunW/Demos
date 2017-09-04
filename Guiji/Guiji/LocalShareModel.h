//
//  LocalShareModel.h
//  SuXuanTang
//
//  Created by YXM on 2017/7/13.
//  Copyright © 2017年 YXM. All rights reserved.
//

#import <Realm/Realm.h>

@interface LocalShareModel : RLMObject
@property NSDate *timestamp;
@property double speed;
@property double verticalAccuracy;
@property double horizontalAccuracy;
@property double altitude;
@property double  latitude;
@property double  longitude;
@property NSDate     * creatTime;

@property NSString      *loc;
@property BOOL          background;

@property NSString *formattedAddress;
@end
