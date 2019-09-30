@startuml
Client->TweetView: request tweet view
TweetView -> TweetPresenter: request tweet list
TweetPresenter -> Repository: request tweets data
Repository -> Server: request tweets data
Server -> Repository: response tweets data
Repository -> TweetPresenter: response tweets data
TweetPresenter -> TweetView: response tweet list
TweetView -> Client: response tweet view

Client -> TweetView: select tweet item
TweetView -> UserView: send the userId of the selected user and tweet List
UserView -> UserPresenter: request user by userId
UserPresenter -> Repository: request user data by UserId
Repository -> Server: request user data by userId
Server -> Repository: response user data
Repository -> UserPresenter: response user data
UserPresenter -> UserView: send user
UserView -> Client: response user view
Client -> UserView: press the save button
UserView -> UserPresenter: send user parameters
note right of UserView: parameters: userId, firstName, lastName, userName, age
UserPresenter -> Repository: request edit user
Repository -> Server: request edit user
Server -> Repository: response message
note left of Server: messages: success, failure
Repository -> UserPresenter: response message
UserPresenter -> UserView: response message
UserView -> Client: response message
UserView -> TweetView: send updated tweet list
note left of UserView: change tweet list by userId
destroy UserView
TweetView -> Client: response of updated tweet view
@enduml
