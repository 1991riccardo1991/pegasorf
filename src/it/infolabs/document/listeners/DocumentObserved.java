package it.infolabs.document.listeners;

import it.infolabs.document.listeners.DocumentEvent;
import it.infolabs.listeners.DocumentListener;
import rf.utility.db.DBEvent;
import rf.utility.db.DBStateChange;

public interface DocumentObserved {
	
		public void addDocumentListeners(DocumentListener listener);
		
		public void removeDocumentListeners(DocumentListener listener);

		public void notifyEvent(DocumentEvent event);

}
