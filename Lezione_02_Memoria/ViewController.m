//
//  ViewController.m
//  Lezione_02_Memoria
//
//  Created by Alberto Pasca on 28/10/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import "ViewController.h"
#import "Foo.h"

@interface ViewController (Private) 
- (void) FooAssignRelease;
- (void) MemoryLeakMethod;
- (void) IncorrectReleaseMethod;
- (void) AutoreleaseMethod_BadWay;
- (void) AutoreleaseMethod_GoodWay;
@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //
  //  STATIC_ANALYZER
  //  INSTRUMENTS
  //  MEMORY LEAK
  //  AUTORELEASE POOL
  //
    
//  [self FooAssignRelease];
//  [self MemoryLeakMethod];
//  [self IncorrectReleaseMethod];
  
//  [self AutoreleaseMethod_BadWay];
//  [self AutoreleaseMethod_GoodWay];
  
}

#pragma mark -
#pragma mark MEMORY_TESTING
#pragma mark -

- (void) FooAssignRelease {

  Foo *myFooOne = [[Foo alloc] init];         //retain count is 1
  NSLog(@"RC: %d", [myFooOne retainCount]);
  
  Foo *myFooTwo = myFooOne;                   //myFooTwo points to original Foo (ASSIGN)
  NSLog(@"RC: %d", [myFooOne retainCount]);
  NSLog(@"RC: %d", [myFooTwo retainCount]);
  
  [myFooTwo retain];                          //runtime now knows myFooTwo points to Foo,
  
  NSLog(@"RC: %d", [myFooOne retainCount]);
  NSLog(@"RC: %d", [myFooTwo retainCount]);
  
  [myFooOne release];
  [myFooTwo release];
  
}

- (void) MemoryLeakMethod {
  
  NSString * myStringA = [[NSString alloc] initWithFormat:@"stringa %@", @"aaa"];    //retainCount = 1
  NSString * myStringB = [[NSString alloc] initWithString:@"valore"];                //retainCount = MAX_INT || -1
  
  NSLog(@"RC: %d", [myStringA retainCount]);
  NSLog(@"RC: %d", [myStringB retainCount]);
  
  Foo * myFoo = [[Foo alloc] initWithName:myStringA];                               //retainCount = 1
  
  NSLog(@"RC: %d", [myFoo retainCount]);

  NSLog(@"RC: %d", [myStringA retainCount]);
  NSLog(@"RC: %d", [myStringB retainCount]);

//  [myFoo release];
//  [myStringA release];
//  [myStringB release];
}

- (void) IncorrectReleaseMethod {
  
  Foo *myFooOne = [[Foo alloc] initWithName:@"la mia stringa"];  // retainCount = 1
  Foo * myFooTwo = myFooOne;                                     // retainCount = 1
  
  [myFooOne release];                                            // retaincount = 0, deallocazione!
  
  NSLog(@"Nome: %@", myFooTwo.name);                             //runtime error
  
}

- (void) AutoreleaseMethod_BadWay {
  
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  int count = 0;
  while(count++ < 1000000000) {
    NSString * tempString = [NSString stringWithFormat:@"Test%i",count];
    NSLog(@"%@", tempString);
  }
  
  [pool drain];
  
}
- (void) AutoreleaseMethod_GoodWay {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  int count = 0;
  while(count++ < 1000000000) {
    NSString * tempString = [[NSString alloc] initWithFormat:@"Test%i",count];
    NSLog(@"%@", tempString);
    [tempString release];
  }
  
  [pool drain];
}


#pragma mark -
#pragma mark - View Delegates
#pragma mark -

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end


