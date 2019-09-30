@startuml
Client->TweetView: request tweet view
TweetView -> TweetPresenter: request tweet list
TweetPresenter -> Service: request tweets data
Service -> Server: request tweets data
Server -> Service: response tweets data
Service -> TweetPresenter: response tweets data
TweetPresenter -> TweetView: response tweet list
TweetView -> Client: response tweet view

Client -> TweetView: select tweet item
TweetView -> UserView: send the userId of the selected user and tweet List
UserView -> UserPresenter: request user by userId
UserPresenter -> Service: request user data by UserId
Service -> Server: request user data by userId
Server -> Service: response user data
Service -> UserPresenter: response user data
UserPresenter -> UserView: send user
UserView -> Client: response user view
Client -> UserView: press the save button
UserView -> UserPresenter: send user parameters
note right of UserView: parameters: userId, firstName, lastName, userName, age
UserPresenter -> Service: request edit user
Service -> Server: request edit user
Server -> Service: response message
note left of Server: messages: success, failure
Service -> UserPresenter: response message
UserPresenter -> UserView: response message
UserView -> Client: response message
UserView -> TweetView: send updated tweet list
note left of UserView: change tweet list by userId
destroy UserView
TweetView -> Client: response of updated tweet view
@enduml
