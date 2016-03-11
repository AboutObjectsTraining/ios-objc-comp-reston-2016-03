#import <XCTest/XCTest.h>

void SayHello(void)
{
    printf("Hello!\n");
}

void SaySomething(const char *something)
{
    printf("%s\n", something);
}

void DoSomething(void (*completion)(const char *))
{
    // Pretend we actually do something here...
    
    completion("Cause I said so!");
}

// Fake a fetch
//
void FetchJSON(void (*completion)(NSString *))
{
    dispatch_async(dispatch_get_current_queue(), ^{
        
        NSDictionary *fakeJSON = @{ @"name": @"Fred", @"age": @"42" };
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(fakeJSON.description);
        });
    });
}


@interface BlockLiteralTests : XCTestCase @end

@implementation BlockLiteralTests

- (void)setUp { [super setUp]; putchar('\n'); }
- (void)tearDown { putchar('\n'); [super tearDown]; }

- (void)testCapturingLocalState
{
    int x = 3;
    char * __block text = "Hello";
    
    void (^foo)(void) = ^{
        char *myText = text;
        
        for (int i = 0; i < x; i++) {
            printf("%s %d\n", myText, i);
            myText = "Goodbye";
        }
        
        text = myText;
    };
    
    void (^bar)(void) = [foo copy];
    
    printf("before calling bar: %s\n", text);
    bar();
    printf("after calling bar: %s\n", text);
}

- (void)testDefiningBlockLiteral
{
    void (^foo)(void) = ^{
        printf("Hello, I'm a block!\n");
    };
    
    foo();
}

- (void)testArrayBlockLiteralAPI
{
    NSArray *words = @[ @"Cucumber", @"apple", @1, @"Carrot", @"peach"];

    NSArray *sortedWords = [words sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 description] caseInsensitiveCompare:[obj2 description]];
    }];
    
    NSLog(@"%@", words);
    NSLog(@"%@", sortedWords);
}

- (void)testPassingAFunctionPointer
{
    DoSomething(SaySomething);
}

- (void)testFunctionPointerWithArg
{
    void (*foo)(const char *) = SaySomething;
    
    foo("Have a nice day!");
}

- (void)testFunctionPointer
{
    void (*foo)(void) = SayHello;
    
    printf("address id %p\n", SayHello);
    
    foo();
}

@end
