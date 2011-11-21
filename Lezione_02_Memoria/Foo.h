//
//  Foo.h
//  Lezione_02_Memoria
//
//  Created by Alberto Pasca on 28/10/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foo : NSObject {
  NSString *name;
}

@property (nonatomic, assign) NSString *name;

- (id) initWithName:(NSString*)n;

@end
