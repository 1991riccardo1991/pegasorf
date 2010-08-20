package rf.pegaso.gui.internalframe;

import it.infolabs.hibernate.Articolo;
import it.infolabs.hibernate.Pannelli;
import it.infolabs.hibernate.PannelliHome;
import it.infolabs.hibernate.exception.FindAllEntityException;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.Rectangle;
import java.awt.Toolkit;

import javax.swing.AbstractAction;
import javax.swing.InputMap;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.KeyStroke;
import javax.swing.WindowConstants;

import rf.pegaso.db.tabelle.DettaglioScarico;
import rf.pegaso.gui.vendita.panel.JButtonEvent;
import rf.pegaso.gui.vendita.panel.JButtonEventListener;
import rf.pegaso.gui.vendita.panel.JPanelArticoli;
import rf.pegaso.gui.vendita.panel.JPanelRiepilogoVendita;
import rf.utility.ControlloDati;
import rf.utility.MathUtility;
import rf.utility.db.DBManager;
import rf.utility.gui.text.UpperTextDocument;

import java.awt.Font;
import java.text.ParseException;
import java.util.LinkedList;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;

import javax.swing.JTabbedPane;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;



public class VenditaInternalFrame extends JInternalFrame implements TableModelListener{

	private static final long serialVersionUID = 1L;
	private JPanel jContentPane = null;
	private JPanel pnlPulsantiFunzioni = null;
	private JButton btnElaboraScontrinoFiscale = null;
	private JTextField txtFieldRicerca = null;
	private JPanel pnlFunzioniCassa = null;
	private JPanelRiepilogoVendita pannelloCarrello = null;
	private JLabel lblCodiceProdotto = null;
	private JButton btnZero = null;
	private JButton btnUno = null;
	private JButton btnDue = null;
	private JButton btnTre = null;
	private JButton btnQuattro = null;
	private JButton btnCinque = null;
	private JButton btnSei = null;
	private JButton btnSette = null;
	private JButton btnOtto = null;
	private JButton btnNove = null;
	private JButton btnVirgola = null;
	private JButton btnCancella = null;
	private JButton btnAzzera = null;
	private JButton btnMoltiplica = null;
	private JButton btnRep1 = null;
	private JButton btnRep2 = null;
	private JButton btnRep3 = null;
	private JButton btnRep4 = null;
	private JTextField txtFldImporto = null;
	private JLabel lblPer = null;
	private JTextField txtQta = null;
	
	private boolean tastieraCassaAttiva = false;
	private boolean inserimentoContanti = false;
	private JButton btnAnnullaVendita = null;
	private JButton btnStorno = null;
	private JButton btnInsManuale = null;
	private JPanel pnlContenitore = null;
	private JTextField txtFldTotale = null;
	private JTextField txtFldContanti = null;
	private JTextField txtFldResto = null;
	private JButton btnElaboraScontrino = null;
	private JButton btnContanti = null;
	
	// Queste tre variabili sono usate per controllare lo stato dell'applicazione
    private int m_iNumberStatus;
    private int m_iNumberStatusInput;
	
	// Variabili numeriche
    private final static int NUMBERZERO = 0;
    private final static int NUMBERVALID = 1;
    
    private final static int NUMBER_INPUTZERO = 0;
    private final static int NUMBER_INPUTZERODEC = 1;
    private final static int NUMBER_INPUTINT = 2;
    private final static int NUMBER_INPUTDEC = 3;
    
    // Variabile che contiene l'importo digitato da tastiera
    private String importo = "";  //  @jve:decl-index=0:
	private JTabbedPane jTabbedPane = null;
	private JTabbedPane tbdPnCarrelli = null;
	private JPanel pnlRiepilogo = null;
	private JButton btnStorno1 = null;
//	private LinkedList<JPanelRiepilogoVendita> listaPannelliRiepilogo = null;
//	private int numCasse = 0;

	public VenditaInternalFrame(JFrame padre) {
		initialize();
	}

	private void initialize() {
		initializeKeyFunction();
		this.setSize(new Dimension(1024, 800));
		this.setDefaultCloseOperation(WindowConstants.HIDE_ON_CLOSE);
		this.setTitle("Vendita al Banco");
		this.setMaximizable(true);
		this.setClosable(true);
		this.setIconifiable(true);
		this.setContentPane(getJContentPane());
		initializeCarrello();
		initializePannelliRapidi();
		txtFieldRicerca.requestFocus();
		pannelloCarrello.addTableModelListener(this);
	}
	
	private void initializeCarrello(){
//		listaPannelliRiepilogo = new LinkedList<JPanelRiepilogoVendita>();
//		JPanelRiepilogoVendita defaultPanelRiepilogo = new JPanelRiepilogoVendita("Cassa Principale");
//		listaPannelliRiepilogo.add(defaultPanelRiepilogo);
		pannelloCarrello = new JPanelRiepilogoVendita();
		
		tbdPnCarrelli.addTab("Cassa Principale", null, pannelloCarrello, null);
//		tbdPnCarrelli.addTab("Nuova Cassa", null, null, null);
//		numCasse = 2;
		
		pannelloCarrello.setVisible(true);
	}
	
	private void initializePannelliRapidi(){
		try {
			for ( Pannelli pan : PannelliHome.getInstance().allPannelli() ){
				if ( pan.getArticolos().size() > 0 ){
					JPanelArticoli pnlArticolo = new JPanelArticoli(new Integer((int)Toolkit.getDefaultToolkit().getScreenSize().getWidth()) - 650);
					pnlArticolo.caricaArticoli(new LinkedList<Articolo>(pan.getArticolos()));
					pnlArticolo.addJButtonEventListener(new JButtonEventListener() {
						public void keyPerformed(JButtonEvent evt) {
							inserisciNelCarrello(evt.getArticolo().getCodbarre());
						}
					});
					DBManager.getIstanceSingleton().addDBStateChange(pnlArticolo);
					jTabbedPane.addTab(pan.getNome(), null, pnlArticolo, null);
				}
			}
		} catch (HeadlessException e) {
			e.printStackTrace();
			messaggioAVideo("Si \u00E8 verificato un errore inaspettato!!!", "ERRORE");
		} catch (FindAllEntityException e) {
			e.printStackTrace();
			messaggioAVideo("Si \u00E8 verificato un errore inaspettato!!!", "ERRORE");
		}
	}
	
	private void inserisciDaRepo(String repo){
		try {
			DettaglioScarico dv = new DettaglioScarico();
			dv.loadRepartoByCB(repo);
			double prezzo = ControlloDati.convertPrezzoToDouble(ControlloDati.costruisciPrezzoLikePOS(importo));
			if (repo.equals("REPARTO 5")){
				dv.setPrezzoVendita(prezzo);
				dv.setIva(0);
			}
			else {
				dv.setPrezzoVendita(prezzo-MathUtility.scontoPercentuale(prezzo, 16.666666666666667));
				dv.setIva(20);
			}
			if ( txtQta.getText().trim().equals("")){
				dv.setQta(1);
			}
			else{
				dv.setQta(Double.valueOf(txtQta.getText().trim()));
			}
			dv.setDisponibilita(dv.getQta());
			pannelloCarrello.addDettaglioOrdine(dv, true);
			txtFldTotale.setText(ControlloDati.convertDoubleToPrezzo(pannelloCarrello.getTotaleCarrello()));
			aggiornaResto();
			importo = "";
			txtQta.setText("");
			txtFldImporto.setText("");
			m_iNumberStatus = NUMBER_INPUTZERO;
			m_iNumberStatusInput = NUMBERZERO;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	private void inserisciNelCarrello(String codeBarre){
		if ( codeBarre == null || codeBarre.trim().equals("") ){
			messaggioAVideo("Codice inserito non valido!", "INFO");
		}
		else{
			DettaglioScarico dv = new DettaglioScarico();
			int esito = dv.loadByCB(codeBarre);
			if ( esito == 1 ){
				if ( pannelloCarrello.addDettaglioOrdine(dv, false) == -1){
					messaggioAVideo("Quantita' richiesta non disponibile.", "INFO");
				}
			}
			else{
				messaggioAVideo("Articolo non disponibile", "INFO");
			}
		}
		txtFldTotale.setText(ControlloDati.convertDoubleToPrezzo(pannelloCarrello.getTotaleCarrello()));
		aggiornaResto();
		importo = "";
	}
	
	private void aggiornaResto(){
		try {
			if ( !txtFldContanti.getText().equals("") ){
				double d = ControlloDati.convertPrezzoToDouble(txtFldContanti.getText());
				txtFldResto.setText(ControlloDati.convertDoubleToPrezzo(d - pannelloCarrello.getTotaleCarrello()));
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	private void elaboraScontrino(boolean scontrino){
		if ( pannelloCarrello.registraScarico(scontrino) ){
			messaggioAVideo("Vendita effettuata con successo", "INFO");
			resetGUI();
		}
		else{
			messaggioAVideo("Si e' verificato un errore durante la registrazione della vendita. Si prega di riprovare", "ERROR");
		}
		txtFieldRicerca.requestFocusInWindow();
	}
	
	

	//inizializza o resetta le variabili iniziali di sistema
	 private void stateToZero(){
		 importo = "";
		 txtQta.setText("");
		 txtFldImporto.setText("");
		 txtFldContanti.setText("");
		 txtFldResto.setText("");
		 m_iNumberStatus = NUMBER_INPUTZERO;
		 m_iNumberStatusInput = NUMBERZERO;
	 }
	 
	private void stateTransition(char cTrans) {
		try {			
			// Gestiamo l'evento cancella ultima cifra
			if ( cTrans == '\n' ){
				if ( importo.length() > 0 ){
					importo = importo.substring(0, importo.length() - 1);
				}
//				if ( importo.length() > 1 && importo.charAt(importo.length()-1) != ',' ){
//					importo = importo.substring(0, importo.length() - 1);
//				}
//				else if ( importo.length() > 1 && importo.charAt(importo.length()-1) == ',' ){
//					importo = importo.substring(0, importo.length() - 1);
//					m_iNumberStatus = NUMBER_INPUTINT;
//				}
//				else{
//					stateToZero();
//				}
			}
			// Il primo numero inserito e' zero
			else if ((cTrans == '0') 
					&& (m_iNumberStatus == NUMBER_INPUTZERO)) {
				importo = "";
			} 
			// Il primo numero inserito e' diverso da zero, si setta lo stato parte iniziale intera (m_iNumberStatus = NUMBER_INPUTINT;) 
			else if ((cTrans == '1' || cTrans == '2' || cTrans == '3' || cTrans == '4' || cTrans == '5' || cTrans == '6' || cTrans == '7' || cTrans == '8' || cTrans == '9')
					&& (m_iNumberStatus == NUMBER_INPUTZERO)) { 
				// Un numero intero
				importo = Character.toString(cTrans);
				m_iNumberStatus = NUMBER_INPUTINT;    
				m_iNumberStatusInput = NUMBERVALID;
			}
			// Se la parte iniziale e' intera, si accoda il nuovo numero inserito
			else if ((cTrans == '0' || cTrans == '1' || cTrans == '2' || cTrans == '3' || cTrans == '4' || cTrans == '5' || cTrans == '6' || cTrans == '7' || cTrans == '8' || cTrans == '9')
					&& (m_iNumberStatus == NUMBER_INPUTINT)) { 
				// Un numero intero
				importo = importo + cTrans;
			} 
			// Se il primo carattere digitato e' la virgola, si inserisce lo zero in testa, e si setta lo stato in zero iniziale con parte decimale
			else if (cTrans == ',' && m_iNumberStatus == NUMBER_INPUTZERO) {
				importo = "0,";
				m_iNumberStatus = NUMBER_INPUTZERODEC;            
			} 
			// Se sono stati digitati dei numeri iniziali e si inserisce la virgola, lo stato cambia in intero iniziale e parte decimale
			else if (cTrans == ',' && m_iNumberStatus == NUMBER_INPUTINT) {
				importo = importo + ",";
				m_iNumberStatus = NUMBER_INPUTDEC;
			} 
			// Si aggiunge il numero selezionato nella parte decimale del numero se i numeri inseriti non sono pi� di 2		
			else if ((cTrans == '0' || cTrans == '1' || cTrans == '2' || cTrans == '3' || cTrans == '4' || cTrans == '5' || cTrans == '6' || cTrans == '7' || cTrans == '8' || cTrans == '9')
					&& (m_iNumberStatus == NUMBER_INPUTZERODEC || m_iNumberStatus == NUMBER_INPUTDEC)) { 
				String decimalPart = importo.substring(importo.indexOf(",") + 1);
				if ( decimalPart.length() < 2 ){
					importo = importo + cTrans;
				}
				m_iNumberStatus = NUMBER_INPUTDEC;
				m_iNumberStatusInput = NUMBERVALID;
			}
			if ( inserimentoContanti || tastieraCassaAttiva ){				
//				double d = ControlloDati.convertPrezzoToDouble(ControlloDati.costruisciPrezzoLikePOS(importo));
				if ( inserimentoContanti ){				
					txtFldContanti.setText(ControlloDati.costruisciPrezzoLikePOS(importo));
				}
				else {
					txtFldImporto.setText(ControlloDati.costruisciPrezzoLikePOS(importo));
				}
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	
	private void annullaVendita(){
		pannelloCarrello.azzeraCarrello();
		txtFldTotale.setText("");
		txtFieldRicerca.setText("");
		((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlArticoli");
		btnInsManuale.setSelected(false);
		tastieraCassaAttiva = false;
		inserimentoContanti = false;
		txtFieldRicerca.requestFocusInWindow();
		stateToZero();
	}
	
	private void resetGUI(){
		// Visualizziamo l'elenco degli articoli se era stato selezionato il pannello funzioni cassa
		((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlArticoli");
		btnInsManuale.setSelected(false);
		tastieraCassaAttiva = false;
		inserimentoContanti = false;
		txtFieldRicerca.setText("");
		txtFldContanti.setText("");
		txtFldImporto.setText("");
		txtFldResto.setText("");
		txtFldTotale.setText("");
		txtQta.setText("");
		importo = "";
	}
	
	private void messaggioAVideo(String testo, String tipo) {
		JOptionPane.showMessageDialog(this, testo, tipo,
				JOptionPane.INFORMATION_MESSAGE);
	}
	
	class MyButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if ( e.getSource() == btnAzzera ){
				stateToZero();
			}
			else if ( e.getSource() == btnMoltiplica ){
				if ( !inserimentoContanti ){
					int qta = Integer.valueOf(txtQta.getText().equals("") ? "1" : txtQta.getText());
					txtQta.setText(String.valueOf(qta+1));
				}
			}
			else if ( e.getSource() == btnVirgola ){
				stateTransition(',');
			}
			else if ( e.getSource() == btnZero ){
				stateTransition('0');
			}
			else if ( e.getSource() == btnCancella ){
				stateTransition('\n');
			}
			else if ( e.getSource() == btnUno ){
				stateTransition('1');
			}
			else if ( e.getSource() == btnDue ){
				stateTransition('2');
			}
			else if ( e.getSource() == btnTre ){
				stateTransition('3');
			}
			else if ( e.getSource() == btnQuattro ){
				stateTransition('4'); 
			}
			else if ( e.getSource() == btnCinque ){
				stateTransition('5');
			}
			else if ( e.getSource() == btnSei ){
				stateTransition('6');
			}
			else if ( e.getSource() == btnSette ){
				stateTransition('7');
			}
			else if ( e.getSource() == btnOtto ){
				stateTransition('8'); 
			}
			else if ( e.getSource() == btnNove ){
				stateTransition('9');
			}
			else if ( e.getSource() == btnRep1 ){
				inserisciDaRepo("REPARTO 1");
			}
			else if ( e.getSource() == btnRep2 ){
				inserisciDaRepo("REPARTO 5");
			}
			else if ( e.getSource() == btnRep3 ){
				inserisciDaRepo("REPARTO 3");
			}
			else if ( e.getSource() == btnRep4 ){
				inserisciDaRepo("REPARTO 4");
			}
			else if ( e.getSource() == btnInsManuale ){
				apriChiudiInserimentoManuale();
			}
			else if ( e.getSource() == btnElaboraScontrino ){
				// Registriamo la vendita
				elaboraScontrino(false);
			}
			else if(e.getSource()==btnElaboraScontrinoFiscale){
				elaboraScontrino(true);
			}
			else if ( e.getSource() == btnContanti ){
				if ( !tastieraCassaAttiva ){
					((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlFunzioniCassa");
					btnInsManuale.setSelected(false);
					tastieraCassaAttiva = true;
				}
				inserimentoContanti = true;
				txtFieldRicerca.setText("");
				txtFldContanti.requestFocusInWindow();
				txtFieldRicerca.setBackground(Color.white);
				txtFldImporto.setBackground(Color.white);
				txtFldContanti.setBackground(Color.pink);
				importo = "";
			}
			else if ( e.getSource() == btnStorno ){
				pannelloCarrello.stornoArticolo();
				txtFldTotale.setText(ControlloDati.convertDoubleToPrezzo(pannelloCarrello.getTotaleCarrello()));
			}
			else if ( e.getSource() == btnStorno1 ){
				pannelloCarrello.stornoQtaArticolo();
				txtFldTotale.setText(ControlloDati.convertDoubleToPrezzo(pannelloCarrello.getTotaleCarrello()));
			}
			else if ( e.getSource() == btnAnnullaVendita ){
				annullaVendita();
			}
		}
	}
	
	class MyFocusListener implements FocusListener {

		/*
		 * (non-Javadoc)
		 *
		 * @see java.awt.event.FocusListener#focusGained(java.awt.event.FocusEvent)
		 */
		public void focusGained(FocusEvent e) {
			if ( e.getSource() == txtFieldRicerca ){
				((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlArticoli");
				btnInsManuale.setSelected(false);
				tastieraCassaAttiva = false;
				inserimentoContanti = false;
				importo = "";
				txtQta.setText("");
				txtFldImporto.setText("");
				txtFieldRicerca.setBackground(Color.pink);
				txtFldImporto.setBackground(Color.white);
				txtFldContanti.setBackground(Color.decode("435445"));
				m_iNumberStatus = NUMBER_INPUTZERO;
				m_iNumberStatusInput = NUMBERZERO;
			}
		}

		/*
		 * (non-Javadoc)
		 *
		 * @see java.awt.event.FocusListener#focusLost(java.awt.event.FocusEvent)
		 */
		public void focusLost(FocusEvent e) {
		}

	}
	
	private void initializeKeyFunction(){
		// impostiamo la finestra per ascoltare i tasti funzione da F1 in su
		// ed altri pulsanti
		InputMap im = this.getRootPane().getInputMap(
				JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, 0), "OK");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F1, 0), "F1");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F2, 0), "F2");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F3, 0), "F3");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F4, 0), "F4");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F5, 0), "F5");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F8, 0), "F8");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), "ESC");
//		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_COMMA, 0), ",");
//		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_PERIOD, 0), ",");
//		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_DECIMAL, 0), ",");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_PLUS, 0), "+");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_ADD, 0), "+");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_DELETE, 0), "CANC");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_BACK_SPACE, 0), "CANC");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_0, 0), "0");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_1, 0), "1");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_2, 0), "2");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_3, 0), "3");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_4, 0), "4");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_5, 0), "5");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_6, 0), "6");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_7, 0), "7");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_8, 0), "8");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_9, 0), "9");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD0, 0), "0");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD1, 0), "1");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD2, 0), "2");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD3, 0), "3");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD4, 0), "4");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD5, 0), "5");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD6, 0), "6");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD7, 0), "7");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD8, 0), "8");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_NUMPAD9, 0), "9");

		this.getRootPane().getActionMap().put("OK", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				if ( a.getSource() != txtFieldRicerca && tastieraCassaAttiva && !inserimentoContanti && importo.length() > 0 ){
					inserisciDaRepo("REPARTO 1");
				}
				else if ( a.getSource() != txtFieldRicerca && tastieraCassaAttiva && inserimentoContanti && importo.length() > 0 ){
					try{
						txtFldResto.setText(ControlloDati.convertDoubleToPrezzo(ControlloDati.convertPrezzoToDouble(ControlloDati.costruisciPrezzoLikePOS(importo)) - pannelloCarrello.getTotaleCarrello()));
						txtFieldRicerca.requestFocusInWindow();
					}catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
		});
		this.getRootPane().getActionMap().put("F1", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				txtFieldRicerca.requestFocusInWindow();				
			}
		});
		this.getRootPane().getActionMap().put("F2", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				elaboraScontrino(false);
			}
		});
		this.getRootPane().getActionMap().put("F1", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				elaboraScontrino(true);
			}
		});
		this.getRootPane().getActionMap().put("F3", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				if ( !tastieraCassaAttiva ){
					((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlFunzioniCassa");
					btnInsManuale.setSelected(false);
					tastieraCassaAttiva = true;
				}
				inserimentoContanti = true;
				txtFieldRicerca.setText("");
				txtFldContanti.requestFocusInWindow();
				txtFieldRicerca.setBackground(Color.white);
				txtFldImporto.setBackground(Color.white);
				txtFldContanti.setBackground(Color.pink);
				importo = "";
			}
		});
		this.getRootPane().getActionMap().put("F4", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				apriChiudiInserimentoManuale();
			}
		});
		this.getRootPane().getActionMap().put("F5", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				
			}
		});
		this.getRootPane().getActionMap().put("F8", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				annullaVendita();
			}
		});	
		this.getRootPane().getActionMap().put("ESC", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				resetGUI();
				doDefaultCloseAction();
			}
		});
		this.getRootPane().getActionMap().put("CANC", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('\n');
			}
		});
		this.getRootPane().getActionMap().put("+", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				if ( !inserimentoContanti ){
					int qta = Integer.valueOf(txtQta.getText().equals("") ? "1" : txtQta.getText());
					txtQta.setText(String.valueOf(qta+1));
				}
			}
		});
//		this.getRootPane().getActionMap().put(",", new AbstractAction() {
//			public void actionPerformed(ActionEvent a) {
//				stateTransition(',');
//			}
//		});
		this.getRootPane().getActionMap().put("0", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('0');
			}
		});
		this.getRootPane().getActionMap().put("1", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('1');
			}
		});
		this.getRootPane().getActionMap().put("2", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('2');
			}
		});
		this.getRootPane().getActionMap().put("3", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('3');
			}
		});
		this.getRootPane().getActionMap().put("4", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('4');
			}
		});
		this.getRootPane().getActionMap().put("5", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('5');
			}
		});
		this.getRootPane().getActionMap().put("6", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('6');
			}
		});
		this.getRootPane().getActionMap().put("7", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('7');
			}
		});
		this.getRootPane().getActionMap().put("8", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('8');
			}
		});
		this.getRootPane().getActionMap().put("9", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				stateTransition('9');
			}
		});
	}
	
	private void m_jButtonKeysKeyPerformed(JButtonEvent evt) {
			 DettaglioScarico dv = new DettaglioScarico();
             dv.loadByID((int)evt.getArticolo().getIdarticolo());
             if ( pannelloCarrello.addDettaglioOrdine(dv, false) == -1){
 				messaggioAVideo("Quantita' richiesta non disponibile.", "INFO");
 			} 			
	}

	private void apriChiudiInserimentoManuale(){
		// Verifichiamo se il pannello e' chiuso
		if ( !tastieraCassaAttiva && !inserimentoContanti){
			((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlFunzioniCassa");
			btnInsManuale.setSelected(true);
			tastieraCassaAttiva = true;
			inserimentoContanti = false;
			importo = "";
			txtFieldRicerca.setText("");
			txtFieldRicerca.setBackground(Color.white);
			txtFldImporto.setBackground(Color.pink);
			txtFldContanti.setBackground(Color.decode("435445"));
			txtFldImporto.requestFocusInWindow();
		}
		else if ( tastieraCassaAttiva && inserimentoContanti ){
			inserimentoContanti = false;
			importo = "";
			txtFieldRicerca.setText("");
			txtFldImporto.requestFocusInWindow();
			txtFieldRicerca.setBackground(Color.white);
			txtFldImporto.setBackground(Color.pink);
			txtFldContanti.setBackground(Color.decode("435445"));
		}
		// Verifichiamo se il pannello e' aperto, quindi lo chiudiamo
		else if ( tastieraCassaAttiva ){
			((CardLayout) pnlContenitore.getLayout()).show(pnlContenitore, "pnlArticoli");
			btnInsManuale.setSelected(false);
			tastieraCassaAttiva = false;
			inserimentoContanti = false;
//			stateToZero();
			txtFieldRicerca.requestFocusInWindow();
		}
	}
	
	public void setFocusRicerca(){
		txtFieldRicerca.requestFocus();
		txtFieldRicerca.setBackground(Color.pink);
	}
	
	/**
	 * This method initializes jContentPane
	 * 
	 * @return javax.swing.JPanel
	 */
	private JPanel getJContentPane() {
		if (jContentPane == null) {
			jContentPane = new JPanel();
			jContentPane.setLayout(new BorderLayout());
			jContentPane.add(getPnlPulsantiFunzioni(), BorderLayout.NORTH);
			jContentPane.add(getPnlContenitore(), BorderLayout.EAST);
			jContentPane.add(getPnlRiepilogo(), BorderLayout.WEST);
		}
		return jContentPane;
	}

	/**
	 * This method initializes pnlPulsantiFunzioni
	 * 
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlPulsantiFunzioni() {
		if (pnlPulsantiFunzioni == null) {
			lblCodiceProdotto = new JLabel();
			lblCodiceProdotto.setBounds(new Rectangle(33, 34, 125, 16));
			lblCodiceProdotto.setText("Codice Prodotto");
			pnlPulsantiFunzioni = new JPanel();
			pnlPulsantiFunzioni.setLayout(null);
			pnlPulsantiFunzioni.setPreferredSize(new Dimension(1000, 150));
			pnlPulsantiFunzioni.add(getBtnRicercaAvanzata(), null);
			pnlPulsantiFunzioni.add(getTxtFieldRicerca(), null);
			pnlPulsantiFunzioni.add(lblCodiceProdotto, null);
			pnlPulsantiFunzioni.add(getBtnInsManuale(), null);
			pnlPulsantiFunzioni.add(getTxtFldTotale(), null);
			pnlPulsantiFunzioni.add(getTxtFldContanti(), null);
			pnlPulsantiFunzioni.add(getTxtFldResto(), null);
			pnlPulsantiFunzioni.add(getBtnElaboraScontrino(), null);
			pnlPulsantiFunzioni.add(getBtnContanti(), null);
		}
		return pnlPulsantiFunzioni;
	}

	/**
	 * This method initializes btnRicercaAvanzata
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnRicercaAvanzata() {
		if (btnElaboraScontrinoFiscale == null) {
			btnElaboraScontrinoFiscale = new JButton();
			btnElaboraScontrinoFiscale.setBounds(new Rectangle(240, 25, 130, 50));
			btnElaboraScontrinoFiscale.setText("<html>Stampa (F1)<P>Scontrino</html>");
			btnElaboraScontrinoFiscale.addActionListener(new MyButtonListener());
		}
		return btnElaboraScontrinoFiscale;
	}

	/**
	 * This method initializes txtFieldRicerca
	 * 
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtFieldRicerca() {
		if (txtFieldRicerca == null) {
			txtFieldRicerca = new JTextField();
			txtFieldRicerca.setBounds(new Rectangle(30, 62, 182, 28));
			txtFieldRicerca.addActionListener(new MyButtonListener());
			txtFieldRicerca.setDocument(new UpperTextDocument());
			txtFieldRicerca.addFocusListener(new MyFocusListener());
			txtFieldRicerca.addKeyListener(new java.awt.event.KeyAdapter() {
				public void keyPressed(java.awt.event.KeyEvent e) {
					if ( e.getKeyCode() == KeyEvent.VK_ENTER ) {
						inserisciNelCarrello(txtFieldRicerca.getText());
						txtFieldRicerca.setText("");
					}
				}
			});
		}
		return txtFieldRicerca;
	}

	/**
	 * This method initializes pnlFunzioniCassa
	 * 
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlFunzioniCassa() {
		if (pnlFunzioniCassa == null) {
			lblPer = new JLabel();
			lblPer.setBounds(new Rectangle(248, 17, 15, 16));
			lblPer.setFont(new Font("Lucida Grande", Font.BOLD, 14));
			lblPer.setText("X");
			pnlFunzioniCassa = new JPanel();
			pnlFunzioniCassa.setLayout(null);
			pnlFunzioniCassa.setPreferredSize(new Dimension(400, 600));
			pnlFunzioniCassa.setName("pnlFunzioniCassa");
			pnlFunzioniCassa.add(getBtnZero(), null);
			pnlFunzioniCassa.add(getBtnUno(), null);
			pnlFunzioniCassa.add(getBtnDue(), null);
			pnlFunzioniCassa.add(getBtnTre(), null);
			pnlFunzioniCassa.add(getBtnQuattro(), null);
			pnlFunzioniCassa.add(getBtnCinque(), null);
			pnlFunzioniCassa.add(getBtnSei(), null);
			pnlFunzioniCassa.add(getBtnSette(), null);
			pnlFunzioniCassa.add(getBtnOtto(), null);
			pnlFunzioniCassa.add(getBtnNove(), null);
			pnlFunzioniCassa.add(getBtnVirgola(), null);
			pnlFunzioniCassa.add(getBtnCancella(), null);
			pnlFunzioniCassa.add(getBtnAzzera(), null);
			pnlFunzioniCassa.add(getBtnMoltiplica(), null);
			pnlFunzioniCassa.add(getBtnRep1(), null);
			pnlFunzioniCassa.add(getBtnRep2(), null);
			pnlFunzioniCassa.add(getBtnRep3(), null);
			pnlFunzioniCassa.add(getBtnRep4(), null);
			pnlFunzioniCassa.add(getTxtFldImporto(), null);
			pnlFunzioniCassa.add(lblPer, null);
			pnlFunzioniCassa.add(getTxtQta(), null);
		}
		return pnlFunzioniCassa;
	}

	/**
	 * This method initializes btnZero
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnZero() {
		if (btnZero == null) {
			btnZero = new JButton();
			btnZero.setBounds(new Rectangle(130, 375, 75, 70));
			btnZero.setText("0");
			btnZero.addActionListener(new MyButtonListener());
		}
		return btnZero;
	}

	/**
	 * This method initializes btnUno
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnUno() {
		if (btnUno == null) {
			btnUno = new JButton();
			btnUno.setBounds(new Rectangle(40, 295, 75, 70));
			btnUno.setText("1");
			btnUno.addActionListener(new MyButtonListener());
		}
		return btnUno;
	}

	/**
	 * This method initializes btnDue
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnDue() {
		if (btnDue == null) {
			btnDue = new JButton();
			btnDue.setBounds(new Rectangle(130, 295, 75, 70));
			btnDue.setText("2");
			btnDue.addActionListener(new MyButtonListener());
		}
		return btnDue;
	}

	/**
	 * This method initializes btnTre
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnTre() {
		if (btnTre == null) {
			btnTre = new JButton();
			btnTre.setBounds(new Rectangle(220, 295, 75, 70));
			btnTre.setText("3");
			btnTre.addActionListener(new MyButtonListener());
		}
		return btnTre;
	}

	/**
	 * This method initializes btnQuattro
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnQuattro() {
		if (btnQuattro == null) {
			btnQuattro = new JButton();
			btnQuattro.setBounds(new Rectangle(40, 215, 75, 70));
			btnQuattro.setText("4");
			btnQuattro.addActionListener(new MyButtonListener());
		}
		return btnQuattro;
	}

	/**
	 * This method initializes btnCinque
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnCinque() {
		if (btnCinque == null) {
			btnCinque = new JButton();
			btnCinque.setBounds(new Rectangle(130, 215, 75, 70));
			btnCinque.setText("5");
			btnCinque.addActionListener(new MyButtonListener());
		}
		return btnCinque;
	}

	/**
	 * This method initializes btnSei
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnSei() {
		if (btnSei == null) {
			btnSei = new JButton();
			btnSei.setBounds(new Rectangle(220, 215, 75, 70));
			btnSei.setText("6");
			btnSei.addActionListener(new MyButtonListener());
		}
		return btnSei;
	}

	/**
	 * This method initializes btnSette
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnSette() {
		if (btnSette == null) {
			btnSette = new JButton();
			btnSette.setBounds(new Rectangle(40, 135, 75, 70));
			btnSette.setText("7");
			btnSette.addActionListener(new MyButtonListener());
		}
		return btnSette;
	}

	/**
	 * This method initializes btnOtto
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnOtto() {
		if (btnOtto == null) {
			btnOtto = new JButton();
			btnOtto.setBounds(new Rectangle(130, 135, 75, 70));
			btnOtto.setText("8");
			btnOtto.addActionListener(new MyButtonListener());
		}
		return btnOtto;
	}

	/**
	 * This method initializes btnNove
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnNove() {
		if (btnNove == null) {
			btnNove = new JButton();
			btnNove.setBounds(new Rectangle(220, 135, 75, 70));
			btnNove.setText("9");
			btnNove.addActionListener(new MyButtonListener());
		}
		return btnNove;
	}

	/**
	 * This method initializes btnVirgola
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnVirgola() {
		if (btnVirgola == null) {
			btnVirgola = new JButton();
			btnVirgola.setBounds(new Rectangle(40, 375, 75, 70));
			btnVirgola.setText(",");
			btnVirgola.addActionListener(new MyButtonListener());
		}
		return btnVirgola;
	}

	/**
	 * This method initializes btnDoppioZero
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnCancella() {
		if (btnCancella == null) {
			btnCancella = new JButton();
			btnCancella.setBounds(new Rectangle(220, 375, 75, 70));
			btnCancella.setText("Canc");
			btnCancella.addActionListener(new MyButtonListener());
		}
		return btnCancella;
	}

	/**
	 * This method initializes btnAzzera
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnAzzera() {
		if (btnAzzera == null) {
			btnAzzera = new JButton();
			btnAzzera.setBounds(new Rectangle(40, 65, 160, 55));
			btnAzzera.setText("AZZERA");
			btnAzzera.addActionListener(new MyButtonListener());
		}
		return btnAzzera;
	}

	/**
	 * This method initializes btnMoltiplica	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnMoltiplica() {
		if (btnMoltiplica == null) {
			btnMoltiplica = new JButton();
			btnMoltiplica.setBounds(new Rectangle(220, 65, 75, 55));
			btnMoltiplica.setText("X1");
			btnMoltiplica.addActionListener(new MyButtonListener());
		}
		return btnMoltiplica;
	}

	/**
	 * This method initializes btnRep1	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnRep1() {
		if (btnRep1 == null) {
			btnRep1 = new JButton();
			btnRep1.setBounds(new Rectangle(310, 375, 75, 70));
			btnRep1.setText("Repo1");
			btnRep1.addActionListener(new MyButtonListener());
		}
		return btnRep1;
	}

	/**
	 * This method initializes btnRep2	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnRep2() {
		if (btnRep2 == null) {
			btnRep2 = new JButton();
			btnRep2.setBounds(new Rectangle(310, 295, 75, 70));
			btnRep2.setText("Repo5");
			btnRep2.addActionListener(new MyButtonListener());
		}
		return btnRep2;
	}

	/**
	 * This method initializes btnRep3	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnRep3() {
		if (btnRep3 == null) {
			btnRep3 = new JButton();
			btnRep3.setBounds(new Rectangle(310, 215, 75, 70));
			btnRep3.setText("Repo3");
			btnRep3.addActionListener(new MyButtonListener());
			btnRep3.setVisible(false);
		}
		return btnRep3;
	}

	/**
	 * This method initializes btnRep4	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnRep4() {
		if (btnRep4 == null) {
			btnRep4 = new JButton();
			btnRep4.setBounds(new Rectangle(310, 135, 75, 70));
			btnRep4.setText("Repo4");
			btnRep4.addActionListener(new MyButtonListener());
			btnRep4.setVisible(false);
		}
		return btnRep4;
	}

	/**
	 * This method initializes txtFldImporto	
	 * 	
	 * @return javax.swing.JTextField	
	 */
	private JTextField getTxtFldImporto() {
		if (txtFldImporto == null) {
			txtFldImporto = new JTextField();
			txtFldImporto.setBounds(new Rectangle(40, 0, 160, 45));
			txtFldImporto.setBackground(Color.white);
			txtFldImporto.setOpaque(true);
			txtFldImporto.setEditable(false);
			txtFldImporto.setFont(new Font("Dialog", Font.BOLD, 16));
//			txtFldImporto.addKeyListener(new java.awt.event.KeyAdapter() {
//				public void keyPressed(java.awt.event.KeyEvent e) {
//					if ( e.getKeyCode() == KeyEvent.VK_ENTER && tastieraCassaAttiva && !inserimentoContanti ) {
//						inserisciDaRepo("Reparto 1");
//					}
//				}
//			});
		}
		return txtFldImporto;
	}

	/**
	 * This method initializes txtQta	
	 * 	
	 * @return javax.swing.JTextField	
	 */
	private JTextField getTxtQta() {
		if (txtQta == null) {
			txtQta = new JTextField();
			txtQta.setBounds(new Rectangle(310, 0, 75, 45));
			txtQta.setEditable(false);
			txtQta.setBackground(Color.white);
			txtQta.setFont(new Font("Dialog", Font.BOLD, 16));
		}
		return txtQta;
	}

	/**
	 * This method initializes btnAnnullaVendita	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnAnnullaVendita() {
		if (btnAnnullaVendita == null) {
			btnAnnullaVendita = new JButton();
			btnAnnullaVendita.setText("Annulla (F8)");
			btnAnnullaVendita.setBounds(new Rectangle(355, 410, 110, 35));
			btnAnnullaVendita.addActionListener(new MyButtonListener());
		}
		return btnAnnullaVendita;
	}

	/**
	 * This method initializes btnStorno	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnStorno() {
		if (btnStorno == null) {
			btnStorno = new JButton();
			btnStorno.setText("Storno");
			btnStorno.setBounds(new Rectangle(55, 410, 90, 35));
			btnStorno.addActionListener(new MyButtonListener());
		}
		return btnStorno;
	}

	/**
	 * This method initializes btnInsManuale	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnInsManuale() {
		if (btnInsManuale == null) {
			btnInsManuale = new JButton();
			btnInsManuale.setBounds(new Rectangle(240, 80, 130, 50));
			btnInsManuale.setText("<html>Inserimento<P>Manuale (F4)</html>");
			btnInsManuale.addActionListener(new MyButtonListener());
		}
		return btnInsManuale;
	}

	/**
	 * This method initializes pnlContenitore	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getPnlContenitore() {
		if (pnlContenitore == null) {
			pnlContenitore = new JPanel();
			pnlContenitore.setLayout(new CardLayout());
			pnlContenitore.setPreferredSize(new Dimension(new Integer((int)Toolkit.getDefaultToolkit().getScreenSize().getWidth()) - 620, 550));
			pnlContenitore.add(getJTabbedPane(), getJTabbedPane().getName());
			pnlContenitore.add(getPnlFunzioniCassa(), getPnlFunzioniCassa().getName());
		}
		return pnlContenitore;
	}

	/**
	 * This method initializes jTextField	
	 * 	
	 * @return javax.swing.JTextField	
	 */
	private JTextField getTxtFldTotale() {
		if (txtFldTotale == null) {
			txtFldTotale = new JTextField();
			txtFldTotale.setBounds(new Rectangle(540, 10, 250, 130));
			txtFldTotale.setOpaque(true);
			txtFldTotale.setEditable(false);
			txtFldTotale.setBackground(Color.ORANGE);
			txtFldTotale.setFont(new Font("Dialog", Font.BOLD, 30));
			txtFldTotale.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Totale \u20AC",
					javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION,
					javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, null, null));
		}
		return txtFldTotale;
	}

	/**
	 * This method initializes jTextField	
	 * 	
	 * @return javax.swing.JTextField	
	 */
	private JTextField getTxtFldContanti() {
		if (txtFldContanti == null) {
			txtFldContanti = new JTextField();
			txtFldContanti.setBounds(new Rectangle(790, 10, 220, 65));
			txtFldContanti.setOpaque(true);
			txtFldContanti.setEditable(false);
			txtFldContanti.setBackground(Color.decode("435445"));
			txtFldContanti.setFont(new Font("Dialog", Font.BOLD, 28));
			txtFldContanti.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Contanti \u20AC",
					javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION,
					javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, null, null));
		}
		return txtFldContanti;
	}

	/**
	 * This method initializes jTextField	
	 * 	
	 * @return javax.swing.JTextField	
	 */
	private JTextField getTxtFldResto() {
		if (txtFldResto == null) {
			txtFldResto = new JTextField();
			txtFldResto.setEditable(false);
			txtFldResto.setBounds(new Rectangle(790, 75, 220, 65));
			txtFldResto.setBackground(Color.decode("314467"));
			txtFldResto.setFont(new Font("Dialog", Font.BOLD, 28));
			txtFldResto.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Resto \u20AC",
					javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION,
					javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, null, null));
		}
		return txtFldResto;
	}

	/**
	 * This method initializes btlElaboraScontrino	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnElaboraScontrino() {
		if (btnElaboraScontrino == null) {
			btnElaboraScontrino = new JButton();
			btnElaboraScontrino.setBounds(new Rectangle(390, 25, 130, 50));
			btnElaboraScontrino.setText("<html>Stampa (F2)</html>");
			btnElaboraScontrino.addActionListener(new MyButtonListener());
			
		}
		return btnElaboraScontrino;
	}

	/**
	 * This method initializes btnContanti	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnContanti() {
		if (btnContanti == null) {
			btnContanti = new JButton();
			btnContanti.setBounds(new Rectangle(390, 80, 130, 50));
			btnContanti.setText("Contanti (F3)");
			btnContanti.addActionListener(new MyButtonListener());
		}
		return btnContanti;
	}

	/**
	 * This method initializes jTabbedPane	
	 * 	
	 * @return javax.swing.JTabbedPane	
	 */
	private JTabbedPane getJTabbedPane() {
		if (jTabbedPane == null) {
			jTabbedPane = new JTabbedPane();
			jTabbedPane.setName("pnlArticoli");
			jTabbedPane.setPreferredSize(new Dimension(new Integer((int)Toolkit.getDefaultToolkit().getScreenSize().getWidth()) - 620, 600));
		}
		return jTabbedPane;
	}
	

	/**
	 * This method initializes jTabbedPane	
	 * 	
	 * @return javax.swing.JTabbedPane	
	 */
	private JTabbedPane getTbdPnCarrelli() {
		if (tbdPnCarrelli == null) {
			tbdPnCarrelli = new JTabbedPane();
			tbdPnCarrelli.setName("tbdPnCarrelli");
			tbdPnCarrelli.setPreferredSize(new Dimension(600, 400));
			tbdPnCarrelli.setBounds(new Rectangle(0, 0, 600, 400));
//			tbdPnCarrelli.addChangeListener(new ChangeListener() {
//		         public void stateChanged(ChangeEvent e) {
//		        	 if ( numCasse == tbdPnCarrelli.getSelectedIndex() + 1 )
//		        		 System.out.println("tabIndex= "+tbdPnCarrelli.getSelectedIndex());
//		          }
//		       });
		}
		return tbdPnCarrelli;
	}

	/**
	 * This method initializes jPanel	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getPnlRiepilogo() {
		if (pnlRiepilogo == null) {
			pnlRiepilogo = new JPanel();
			pnlRiepilogo.setLayout(null);
			pnlRiepilogo.setPreferredSize(new Dimension(600, 550));
			pnlRiepilogo.add(getTbdPnCarrelli(), null);
//			pnlRiepilogo.add(pannelloCarrello, null);
			pnlRiepilogo.add(getBtnStorno(), null);
			pnlRiepilogo.add(getBtnAnnullaVendita(), null);
			pnlRiepilogo.add(getBtnStorno1(), null);
		}
		return pnlRiepilogo;
	}

	/**
	 * This method initializes jButton	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnStorno1() {
		if (btnStorno1 == null) {
			btnStorno1 = new JButton();
			btnStorno1.setBounds(new Rectangle(205, 410, 90, 35));
			btnStorno1.setText("Storno 1");
			btnStorno1.addActionListener(new MyButtonListener());
		}
		return btnStorno1;
	}

	@Override
	public void tableChanged(TableModelEvent e) {
		if(e.getSource()==pannelloCarrello.getModel()){
			txtFldTotale.setText(ControlloDati.convertDoubleToPrezzo(pannelloCarrello.getTotaleCarrello()));
//			txtFldContanti.setText(ControlloDati.costruisciPrezzoLikePOS(importo));
			aggiornaResto();
		}
		
	}
}