//
//  MSMessageViewController.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/24/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "MSMessageInputToolbar.h"
#import "MSMessageBubbleCell.h"

@protocol MSMessageViewControllerDelegate;

@interface MSMessageViewController : UIViewController

@property (nonatomic, strong) MSMessageInputViewModel *messageInputViewModel;
@property (nonatomic, weak) id<MSMessageViewControllerDelegate> delegate;
@property (nonatomic, strong) id<UILayoutSupport> maxKeyboardLayoutGuide;

+ (MSMessageInputViewModel *)defaultMessageInputViewModel;

- (void)reloadData;

@end

@protocol MSMessageViewControllerDelegate <NSObject>

- (NSUInteger)messageCount;
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (MSMessageBubbleViewModel *)messageBubbleViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)messageViewController:(MSMessageViewController *)messageViewController didSendMessageText:(NSString *)messageText;

@end