//
//  MessageInputView.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "MessageInputViewModel.h"

@class MessageInputView;

@protocol MessageInputViewDelegate <UIToolbarDelegate>

- (void)messageInputViewDidChangeText:(MessageInputView *)messageInputView;
- (void)messageInputView:(MessageInputView *)messageInputView didSendMessageText:(NSString *)messageText;

@end

@interface MessageInputView : UIToolbar

@property (nonatomic, weak) id<MessageInputViewDelegate> delegate;

- (void)setViewModel:(MessageInputViewModel *)viewModel;

- (void)scrollToCaret;
- (void)clearInputText;

@end

