const String domainName = '192.168.29.174';
const String post = '4545';

const String domainURL = 'http://' + domainName + ':' + post + '/';

const String chatroomURL = domainURL + 'chatroom/';
const String messageURL = domainURL + 'message/';

const String loginURL = domainURL + 'auth/login/';
const String verifyURL = domainURL + 'auth/verify/';
const String getMyChatroomsURL = chatroomURL + 'room/';
const String startChatroomURL = chatroomURL + 'room/';
const String getChatroomMessagesURL = messageURL + 'get/';
const String sendChatroomMessageURL = messageURL + 'send/';

const List<int> errorTokenStatusCodes = [475, 474, 408];
