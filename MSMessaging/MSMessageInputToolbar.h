//
//  MSMessageInputToolbar.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "MSMessageInputViewModel.h"

@class MSMessageInputToolbar;

@protocol MSMessageInputToolbarDelegate <UIToolbarDelegate>

- (void)messageInputToolbarDidChangeText:(MSMessageInputToolbar *)messageInputToolbar;
- (void)messageInputToolbar:(MSMessageInputToolbar *)messageInputToolbar didSendMessageText:(NSString *)messageText;

@end

@interface MSMessageInputToolbar : UIToolbar

@property (nonatomic, weak) id<MSMessageInputToolbarDelegate> delegate;

- (void)setViewModel:(MSMessageInputViewModel *)viewModel;

- (void)scrollToCaret;
- (void)clearInputText;

@end

