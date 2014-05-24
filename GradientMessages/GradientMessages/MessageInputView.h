//
//  MessageInputView.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "MessageInputViewModel.h"

@interface MessageInputView : UIView

@property (nonatomic, strong, readonly) UITextView *inputTextView;
@property (nonatomic, strong, readonly) UIButton *sendButton;

- (void)setViewModel:(MessageInputViewModel *)viewModel;

- (void)scrollToCaret;

@end
