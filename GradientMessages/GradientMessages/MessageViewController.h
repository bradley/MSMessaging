//
//  MessageViewController.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/24/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "Message.h"
#import "MessageInputView.h"
#import "MessageBubbleCell.h"

@protocol MessageViewControllerDelegate;

@interface MessageViewController : UIViewController

@property (nonatomic, weak) id<MessageViewControllerDelegate> delegate;
@property (nonatomic, strong) id<UILayoutSupport> maxKeyboardLayoutGuide;

- (void)reloadData;

@end

@protocol MessageViewControllerDelegate <NSObject>

- (MessageInputViewModel *)messageInputViewModel;
- (NSUInteger)messageCount;
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (MessageBubbleViewModel *)messageBubbleViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)messageViewController:(MessageViewController *)messageViewController didSendMessageText:(NSString *)messageText;

@end