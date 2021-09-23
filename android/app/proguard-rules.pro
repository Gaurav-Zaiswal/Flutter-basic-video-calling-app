# added this file to integrate Jitsi 
# If we do not create the proguard-rules.pro file, then 
# your app will crash when you try to join a meeting or 
# the meeting screen tries to open but closes immediately

-ignorewarnings
-keep class * {
    public private *;
}