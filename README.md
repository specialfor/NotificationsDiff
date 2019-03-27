# NotificationsDiff
Compare `UILocalNotification` and `User Notifications` API and capabilities

## Takeaway

It is better to use `User Notifications` framework because it is more powerful.

## `UILocalNotification` disadvantages

1. Maximum number of scheduled local notifications is 64. The earliest notifications will be removed, if we try to send a new one.
2. Can't notify about "Dismiss" ("Clear") action, only about custom actions.
3. Has limited values for repeat interval. We can set repeat interval to 1 minute, 1 hour, 1 weak, etc.
4. Can't show notifications in foreground (need to implement custom in-app notification view).
