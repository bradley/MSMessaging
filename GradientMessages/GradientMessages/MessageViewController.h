//
//  MessageViewController.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/24/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "Message.h"

@protocol MessageViewControllerDelegate;

@interface MessageViewController : UIViewController

@property (nonatomic, weak) id<MessageViewControllerDelegate> delegate;
@property (nonatomic, strong) id<UILayoutSupport> maxKeyboardLayoutGuide;

- (void)reloadData;

@end

@protocol MessageViewControllerDelegate <NSObject>

- (NSUInteger)messageCount;
- (Message *)messageAtIndexPath:(NSIndexPath *)indexPath;

- (void)messageViewController:(MessageViewController *)messageViewController didSendMessageText:(NSString *)messageText;

@end