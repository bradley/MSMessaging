//
//  Message.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "Message.h"

@interface Message ()

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) BOOL isAuthor;

@end

@implementation Message

- (instancetype)initWithMessageText:(NSString *)messageText isAuthor:(BOOL)isAuthor
{
	self = [super init];
	if (self) {
		self.messageText = messageText;
		self.isAuthor = isAuthor;
	}
	
	return self;
}

@end
