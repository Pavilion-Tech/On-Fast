abstract class ChatStates{}

class ChatInitState extends ChatStates{}

class EmitState extends ChatStates{}

class ImageWrong extends ChatStates{}

class SendMessageLoadingState extends ChatStates {}
class SendMessageWithFileLoadingState extends ChatStates {}
class SendMessageSuccessState extends ChatStates {}
class SendMessageWrongState extends ChatStates {}
class SendMessageErrorState extends ChatStates {}

class CreateChatSuccessState extends ChatStates {}
class CreateChatWrongState extends ChatStates {}
class CreateChatErrorState extends ChatStates {}

class EndChatLoadingState extends ChatStates {}
class EndChatSuccessState extends ChatStates {}
class EndChatWrongState extends ChatStates {}
class EndChatErrorState extends ChatStates {}