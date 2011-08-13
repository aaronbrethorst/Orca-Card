//
//  Card.h
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(nonatomic,retain) NSString *cardID;
@property(nonatomic,retain) NSString *cardNickname;
@property(nonatomic,retain) NSString *passengerType;
@property(nonatomic,retain) NSString *balance;
@property(nonatomic,retain) NSString *cardStatus;
@end
