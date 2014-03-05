//
//  Deck.h
//  Card Flip
//
//  Created by Jacob Tomaw on 3/3/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card;
- (Card *) drawRandomCard;

@end
