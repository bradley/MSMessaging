//
//  MessageBubbleController.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

#import "MessageBubbleViewModel.h"

@interface MessageBubbleController : NSObject

@property (nonatomic, assign, readwrite) CGSize collectionViewSize;

- (MessageBubbleViewModel *)viewModelForMessageText:(NSString *)messageText isAuthor:(BOOL)isAuthor;

@end
