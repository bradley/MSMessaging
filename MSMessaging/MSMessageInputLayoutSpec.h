//
//  MSMessageInputLayoutSpec.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@interface MSMessageInputLayoutSpec : NSObject

@property (nonatomic, assign, readwrite) UIEdgeInsets contentInset;
@property (nonatomic, assign, readwrite) UIEdgeInsets messageTextViewContentInset;
@property (nonatomic, assign, readwrite) UIEdgeInsets sendButtonContentEdgeInsets;

@end
