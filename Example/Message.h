//
//  Message.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@interface Message : NSObject

@property (nonatomic, copy, readonly) NSString *messageText;
@property (nonatomic, assign, readonly) BOOL isAuthor;

- (instancetype)initWithMessageText:(NSString *)messageText isAuthor:(BOOL)isAuthor;

@end
