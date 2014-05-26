//
//  MessageBubbleController.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleController.h"

@implementation MessageBubbleController

- (MessageBubbleViewModel *)viewModelForMessageText:(NSString *)messageText isAuthor:(BOOL)isAuthor
{
	MessageBubbleLayoutSpec *layoutSpec = [[MessageBubbleLayoutSpec alloc] init];
	layoutSpec.collectionViewSize = self.collectionViewSize;
	layoutSpec.bubbleMaskImageSize = CGSizeMake(48.f, 35.f);
	layoutSpec.bubbleMaskOffset = CGPointMake(20.f, 16.f);
	layoutSpec.alignMessageLabelRight = isAuthor;
	
	if (isAuthor) {
		layoutSpec.messageBubbleInsets = UIEdgeInsetsMake(0.f, 74.f, 0.f, 10.f);
		layoutSpec.messageLabelInsets = UIEdgeInsetsMake(6.5f, 12.f, 7.5f, 18.f);
	}
	else {
		layoutSpec.messageBubbleInsets = UIEdgeInsetsMake(0.f, 10.f, 0.f, 74.f);
		layoutSpec.messageLabelInsets = UIEdgeInsetsMake(6.5f, 18.f, 7.5f, 12.f);
	}
	
	CGFloat constraintWidth = self.collectionViewSize.width - (layoutSpec.messageBubbleInsets.left + layoutSpec.messageBubbleInsets.right + layoutSpec.messageLabelInsets.left + layoutSpec.messageLabelInsets.right);
	CGSize constraintSize = CGSizeMake(constraintWidth, MAXFLOAT);
	layoutSpec.messageLabelSize = [messageText boundingRectWithSize:constraintSize
																			  options:NSStringDrawingUsesLineFragmentOrigin
																		  attributes:@{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody] }
																			  context:nil].size;

	return [[MessageBubbleViewModel alloc] initWithMessageLabelText:messageText isAuthor:isAuthor layoutSpec:layoutSpec];
}

- (MessageInputViewModel *)viewModel
{
	MessageInputLayoutSpec *layoutSpec = [[MessageInputLayoutSpec alloc] init];
	//layoutSpec.messageInputTextViewContentInset = UIEdgeInsetsMake(5.f, 3.f, 0.f, 0.f);
	layoutSpec.messageInputTextViewContentInset = UIEdgeInsetsMake(5.f, 3.f, -2.f, 0.f);
	layoutSpec.messageInputTextViewPadding = UIEdgeInsetsMake(8.f, 8.f, 8.f, 8.f);
	
	MessageInputViewModel *viewModel = [[MessageInputViewModel alloc] initWithLayoutSpec:layoutSpec];
	viewModel.messageInputCornerRadius = 5.f;
	viewModel.messageInputBorderWidth = 0.5f;
	viewModel.messageInputBackgroundColor = [UIColor colorWithWhite:1 alpha:0.825f];
	viewModel.messageInputBorderColor = [UIColor colorWithWhite:0.5f alpha:0.4f];
	viewModel.messageInputFont = [UIFont systemFontOfSize:16];
	viewModel.messageInputFontColor = [UIColor darkTextColor];
	viewModel.sendButtonFont = [UIFont boldSystemFontOfSize:17.f];
	viewModel.backgroundToolbarName = @"backgroundToolbar";
	viewModel.inputTextViewName = @"inputTextView";
	viewModel.sendButtonName = @"sendButton";
	
	viewModel.layoutConstraints = @[
		@"H:[sendButton]-6-|",
		@"V:[sendButton]-4.5-|",
		[NSString stringWithFormat:@"H:|-%.2f-[inputTextView]-%.2f-[sendButton]-6-|", viewModel.layoutSpec.messageInputTextViewPadding.left, viewModel.layoutSpec.messageInputTextViewPadding.right],
		[NSString stringWithFormat:@"V:|-%.2f-[inputTextView]-%.2f-|", viewModel.layoutSpec.messageInputTextViewPadding.top, viewModel.layoutSpec.messageInputTextViewPadding.bottom],
	];
	
	return viewModel;
}

@end
