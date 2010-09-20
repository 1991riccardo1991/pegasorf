package it.infolabs.document.listeners;

public class DocumentEvent {
	
	// Azioni possibili
	public enum DocumentAction{
		SAVE, DELETE, NOTHING, UPDATE, PRINT;
	}
	
	public enum DocumentType {
		
		FATTURA, SCONTRINO, BOLLA, BUONO, DEFAULT;

	}
	
	private Object source;
	private DocumentAction action=DocumentAction.NOTHING;
	private DocumentType document=DocumentType.DEFAULT;
	
	public DocumentEvent(){
		
	}

	public DocumentAction getAction() {
		return action;
	}

	public void setAction(DocumentAction action) {
		this.action = action;
	}

	public DocumentType getDocument() {
		return document;
	}

	public void setDocument(DocumentType document) {
		this.document = document;
	}

	public void setSource(Object source) {
		this.source = source;
	}

	public DocumentEvent(DocumentType document, DocumentAction action, Object source){
		this.source=source;
		this.document=document;
		this.action=action;
	}
	
	public Object getSource(){
		return source;
	}

}
