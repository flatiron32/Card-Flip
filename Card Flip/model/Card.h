//
//  Card.h
//  Card Flip
//
//  Created by Jacob Tomaw on 3/3/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

@end
