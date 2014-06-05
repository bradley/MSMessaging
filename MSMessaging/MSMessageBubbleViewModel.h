//
//  MSMessageBubbleViewModel.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@interface MSMessageBubbleViewModel : NSObject

@property (nonatomic, assign, readonly) CGSize containerSize;
@property (nonatomic, assign, readonly) CGSize cellSize;
@property (nonatomic, assign, readonly) CGRect bubbleMaskFrame;
@property (nonatomic, assign, readonly) CGRect messageLabelFrame;
@property (nonatomic, assign, readonly) CGRect gradientFrame;
@property (nonatomic, assign, readonly) CGRect bubbleMaskLayerContentsCenter;

@property (nonatomic, copy, readonly) NSString *messageLabelText;
@property (nonatomic, strong, readonly) UIColor *messageLabelColor;
@property (nonatomic, strong, readonly) UIColor *messageBackgroundColor;
@property (nonatomic, assign, readonly) CATransform3D bubbleMaskTransform;

- (instancetype)initWithContainerSize:(CGSize)containerSize messageText:(NSString *)messageText isAuthor:(BOOL)isAuthor;

@end
