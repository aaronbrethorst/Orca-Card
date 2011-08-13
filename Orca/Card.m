//
//  Card.m
//  Orca
//
//  Created by Aaron Brethorst on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize cardID;
@synthesize cardNickname;
@synthesize passengerType;
@synthesize balance;
@synthesize cardStatus;

- (void)dealloc
{
    self.cardID = nil;
    self.cardNickname = nil;
    self.passengerType = nil;
    self.balance = nil;
    self.cardStatus = nil;    

    [super dealloc];
}

@end
