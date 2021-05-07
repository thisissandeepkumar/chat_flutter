const String domainName = '35.154.254.131';
const String post = '8000';
const String websocketPort = '4545';

const String domainURL = 'http://' + domainName + ':' + post + '/';
const String websocketURL = 'ws://' + domainName + ':' + websocketPort + '/';

const String chatroomURL = domainURL + 'chatroom/';
const String messageURL = domainURL + 'message/';

const String loginURL = domainURL + 'auth/login/';
const String verifyURL = domainURL + 'auth/verify/';
const String uniqueCheckURL = domainURL + 'auth/unique/';
const String registerURL = domainURL + 'auth/register/';
const String getMyChatroomsURL = chatroomURL + 'room/';
const String startChatroomURL = chatroomURL + 'room/';
const String getChatroomMessagesURL = messageURL + 'get/';
const String sendChatroomMessageURL = messageURL + 'send/';

const List<int> errorTokenStatusCodes = [475, 474, 408];
