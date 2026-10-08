#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/org/jabref/gui/fieldeditors/identifier/IdentifierEditor.java`:

This pull request introduces the defect later reported as "Exception thrown when fetching DOI". The
problem a user observed, and its root cause:

### JabRef version

Latest development branch build (please note build date below)

### Operating system

GNU / Linux

### Details on version and operating system

_No response_

### Checked with the latest development build (copy version output from About dialog)

- [X] I made a backup of my libraries before testing the latest development version.
- [X] I have tested the latest development version and the problem persists

### Steps to reproduce the behaviour

 1. Click on the DOI fetch icon in the entry editor (for an entry without DOI).

```
JabRef 5.12--2023-11-07--2afd1f6
Linux 6.2.0-36-generic amd64 
Java 21.0.1 
JavaFX 21.0.1+6
```

Then, you might see the following exception:

```
java.lang.RuntimeException: java.lang.reflect.InvocationTargetException
	at org.jabref.merged.module@5.12.115/javafx.fxml.FXMLLoader$MethodHandler.invoke(Unknown Source)
	at org.jabref.merged.module@5.12.115/javafx.fxml.FXMLLoader$ControllerMethodEventHandler.handle(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.CompositeEventHandler.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventHandlerManager.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventHandlerManager.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.CompositeEventDispatcher.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventUtil.fireEventImpl(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventUtil.fireEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/javafx.event.Event.fireEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/javafx.scene.Node.fireEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/javafx.scene.control.Button.fire(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.scene.control.behavior.ButtonBehavior.mouseReleased(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.scene.control.inputmap.InputMap.handle(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.CompositeEventHandler$NormalEventHandlerRecord.handleBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.CompositeEventHandler.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventHandlerManager.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventHandlerManager.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.CompositeEventDispatcher.dispatchBubblingEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.BasicEventDispatcher.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.javafx.event.EventDispatchChainImpl.dispatchEvent(Unknown Source)
	at org.jabref.merged.module@5.12.115/com.sun.java

This same root cause must be fixed before merging.
REVIEW_EOF
