#import "FlickrPhotoItemMedia.h"

@implementation FlickrPhotoItemMedia
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.m forKey:@"m"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.m = [decoder decodeObjectForKey:@"m"];
    }
    return self;
}

+ (FlickrPhotoItemMedia *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    FlickrPhotoItemMedia *instance = [[FlickrPhotoItemMedia alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (NSDictionary *)dictionary
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.m) {
        [dictionary setObject:self.m forKey:@"m"];
    }

    return dictionary;

}


@end
