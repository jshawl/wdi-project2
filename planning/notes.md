## Map based tool for deciding where friends should go out

1. I have a group of friends, and we all want to go out
2. We each can propose locations to go out
3. We can each vote on or rank proposed locations
4. Some algorithm runs to present top choices given raking/voting
5. Voting closes at determined time
6. You go out!

## events
One friend will initiate event, with a title and description
As you're invited to an event, you can invite others
Anyone invited can propose times and places
Anyone invited can vote on times and places
One voting deadline is over, app alerts attendees of final plan


## map yik yak -- upvotes and downvotes
show tags, upvotes downvotes, and users attending
if vote threshold is reached, event is gone
if nobody votes in an hour, event is gone
--user has to be able to edit event, event must belong to user in model

users#index could return json for searchable like locations#index
tags#index could return json for searchable like locations#index

users get karma based on the cumulative value of events they propose

users#show should have user, followers and followings, events hosted, events attended
map should be filterable by tags
if an hour goes by with no action, event should be destroyed
