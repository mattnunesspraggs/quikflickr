#import "FlickrPublicFeedResponse.h"

#import "FlickrPhoto.h"

@implementation FlickrPublicFeedResponse
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.descriptionText forKey:@"descriptionText"];
    [encoder encodeObject:self.generator forKey:@"generator"];
    [encoder encodeObject:self.items forKey:@"items"];
    [encoder encodeObject:self.link forKey:@"link"];
    [encoder encodeObject:self.modified forKey:@"modified"];
    [encoder encodeObject:self.title forKey:@"title"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.descriptionText = [decoder decodeObjectForKey:@"descriptionText"];
        self.generator = [decoder decodeObjectForKey:@"generator"];
        self.items = [decoder decodeObjectForKey:@"items"];
        self.link = [decoder decodeObjectForKey:@"link"];
        self.modified = [decoder decodeObjectForKey:@"modified"];
        self.title = [decoder decodeObjectForKey:@"title"];
    }
    return self;
}

+ (FlickrPublicFeedResponse *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    FlickrPublicFeedResponse *instance = [[FlickrPublicFeedResponse alloc] init];
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

- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"items"]) {

        if ([value isKindOfClass:[NSArray class]])
{

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                FlickrPhoto *populatedMember = [FlickrPhoto instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.items = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descriptionText"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


- (NSDictionary *)dictionary
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.descriptionText) {
        [dictionary setObject:self.descriptionText forKey:@"descriptionText"];
    }

    if (self.generator) {
        [dictionary setObject:self.generator forKey:@"generator"];
    }

    if (self.items) {
        [dictionary setObject:self.items forKey:@"items"];
    }

    if (self.link) {
        [dictionary setObject:self.link forKey:@"link"];
    }

    if (self.modified) {
        [dictionary setObject:self.modified forKey:@"modified"];
    }

    if (self.title) {
        [dictionary setObject:self.title forKey:@"title"];
    }

    return dictionary;

}


@end
