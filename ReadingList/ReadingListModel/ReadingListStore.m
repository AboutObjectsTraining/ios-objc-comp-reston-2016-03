#import "ReadingListStore.h"
#import "ReadingList.h"

@interface ReadingListStore ()
@property (nonatomic, copy) NSString *storeName;
@end


NSString *RELPathForDocument(NSString *name, NSString *type)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths.firstObject stringByAppendingPathComponent:name] stringByAppendingPathExtension:type];
}

@implementation ReadingListStore

- (instancetype)initWithStoreName:(NSString *)storeName
{
    if (!(self = [super init])) return nil;
    
    _storeName = [storeName copy];
    
    return self;
}

+ (instancetype)storeWithName:(NSString *)storeName
{
    return [[self alloc] initWithStoreName:storeName];
}

- (ReadingList *)fetchedReadingList
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:RELPathForDocument(self.storeName, @"plist")];
    
    if (dict == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSString *path = [bundle pathForResource:self.storeName ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return [ReadingList modelObjectWithDictionary:dict];
}

- (void)saveReadingList:(ReadingList *)readingList
{
    NSDictionary *dict = [readingList dictionaryRepresentation];
    NSString *path = RELPathForDocument(self.storeName, @"plist");
    [dict writeToFile:path atomically:YES];
}

@end
