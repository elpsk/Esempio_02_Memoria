//
//  Foo.m
//  Lezione_02_Memoria
//
//  Created by Alberto Pasca on 28/10/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import "Foo.h"

@implementation Foo
@synthesize name;


- (id) initWithName:(NSString*)n {
  self.name = n;
  
  return [super init];
}

@end
