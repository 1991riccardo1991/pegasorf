/**
 *
 */
package rf.pegaso.gui.gestione;

import it.infolabs.hibernate.Articolo;
import it.infolabs.hibernate.ArticoloHome;
import it.infolabs.hibernate.CodiciIva;
import it.infolabs.hibernate.CodiciIvaHome;
import it.infolabs.hibernate.ImmagineArticolo;
import it.infolabs.hibernate.ImmagineArticoloHome;
import it.infolabs.hibernate.Pannelli;
import it.infolabs.hibernate.PannelliHome;
import it.infolabs.hibernate.RepartoHome;
import it.infolabs.hibernate.Um;
import it.infolabs.hibernate.UmHome;
import it.infolabs.hibernate.exception.FindAllEntityException;
import it.infolabs.hibernate.exception.FindByNotFoundException;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.BorderFactory;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFormattedTextField;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.BevelBorder;
import javax.swing.border.TitledBorder;
import javax.swing.text.JTextComponent;

import rf.pegaso.db.tabelle.Carico;
import rf.pegaso.db.tabelle.Reparto;
import rf.pegaso.db.tabelle.Scarico;
import rf.pegaso.db.tabelle.UnitaDiMisura;
import rf.pegaso.gui.utility.UtilityImage;
import rf.pegaso.gui.viste.ViewDocCarico;
import rf.utility.ControlloDati;
import rf.utility.db.DBManager;
import rf.utility.gui.UtilGUI;
import rf.utility.gui.text.AutoCompletion;
import rf.utility.gui.text.UpperTextDocument;
import rf.utility.number.Arrays;
import javax.swing.JRadioButton;
import javax.swing.JCheckBox;

import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeException;
import net.sourceforge.barbecue.BarcodeFactory;

/**
 * @author Hunter
 *
 */
public class ArticoloAddMod extends JFrame implements PropertyChangeListener,WindowListener {
	class MyActionListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource() == btnChiudi) {
				dispose();
			}
			if (e.getSource() == btnInsMod) {
				if (modalita == MOD)
					modifica();
				else
					inserisci();
			}  else if (e.getSource() == btnNewReparto) {
				apriNuovaCategoria();
			} else if (e.getSource() == btnNewPannello) {
				apriNuovoPannello();
			} else if (e.getSource() == btnNewUM) {
				apriNuovoUM();
			} else if (e.getSource() == btnDocCarico) {
				apriDocCarico();
			}else if(e.getSource()==btnSuggerimento){
				suggerimentoCodice();
			}
			else if ( e.getSource() == rbtnSi ){
				txtCodBarre.setEditable(true);
				txtCodFornitore.setEditable(true);
				btnSuggerimento.setEnabled(true);
			}
			else if ( e.getSource() == rbtnNo ){
				txtCodBarre.setEditable(false);
				txtCodFornitore.setEditable(false);
				btnSuggerimento.setEnabled(false);
			}
			else if ( e.getSource() == btnAddImage ){
				caricaImmagine();
			}
			else if ( e.getSource() == btnRemoveImage ){
				rimuoviImmagine();
			}
		}

	}

	class MyFocusListener implements FocusListener {

		/*
		 * (non-Javadoc)
		 *
		 * @see java.awt.event.FocusListener#focusGained(java.awt.event.FocusEvent)
		 */
		public void focusGained(FocusEvent arg0) {

		}

		/*
		 * (non-Javadoc)
		 *
		 * @see java.awt.event.FocusListener#focusLost(java.awt.event.FocusEvent)
		 */
		public void focusLost(FocusEvent e) {
			if (e.getSource() == txtRicaricoListino) {
				calcolaPrezzo();
			}

		}

	}

	public static final int ADD = 0;
	public static final int MOD = 1;

	private static final long serialVersionUID = 1L;

	private JButton btnChiudi = null;

	private JButton btnDocCarico = null;

	private JButton btnInsMod = null;

	private JButton btnNewReparto = null;

	private JButton btnNewUM = null;

	private JComboBox cmbMisura = null;

	private JComboBox cmbReparto = null;

	private DBManager dbm;

	private int idArticolo;

	private int idCliente;

	private JPanel jContentPane = null;

	private JPanel jPanel = null;

	private JPanel jPanel1 = null;

	private JPanel jPanel2 = null;

	private JScrollPane jScrollPane1 = null;

	private JTabbedPane jTabbedPane = null;

	private JLabel lblCodBarre = null;

	private JLabel lblCodFornitore = null;

	private JLabel lblDescrizione = null;

	private JLabel lblIngrosso = null;

	private JLabel lblIva = null;

	private JLabel lblNota = null;

	private JLabel lblPrezzoAcquisto = null;

	private JLabel lblPrezzoIngrosso = null;

	private JLabel lblQta = null;

	private JLabel lblReaprto = null;

	private JLabel lblRicaricoIngrosso = null;

	private JLabel lblUnitaMisura = null;

	private int modalita;

	private JPanel pnlCentrale = null;

	private JPanel pnlDatiPersonali = null;

	private JTextField txtCodBarre = null;

	private JTextField txtCodFornitore = null;

	private JTextField txtDescrizione = null;

	private JFormattedTextField txtPrezzoFinale = null;
	private JTextArea txtNote = null;
	private JFormattedTextField txtPrezzoAcquisto = null;
	private JFormattedTextField txtPrezzoListino = null;
	private JTextField txtQta = null;
	private JFormattedTextField txtRicaricoListino = null;
	private String[] codReparti;
	private String[] descReparti;
	private String[] codUnitaDiMisura;
	private String[] descUnitaDiMisura;
	private String[] codCodiceIva;
	private String[] descCodiceIva;
	private String[] codPannelli;
	private String[] descPannelli;
	private JButton btnSuggerimento = null;
	private String[] ultimoArticolo;
	private boolean close=false;
	private JLabel lblrButtonSiNo = null;
	private JLabel lblSi = null;
	private JLabel lblNo = null;
	private JRadioButton rbtnSi = null;
	private JRadioButton rbtnNo = null;
	private JLabel lblPannelli = null;
	private JComboBox cmbPannelli = null;
	private JButton btnNewPannello = null;
	private JCheckBox chkBoxQtaInfinita = null;
	private JLabel lblQtaInfinita = null;
	private JPanel pnlImage = null;
	private JLabel lbl1 = null;
	private JButton btnAddImage = null;
	private JButton btnRemoveImage = null;
	private ImmagineArticolo imgArticolo;
	private JPanel pnlBarcode = null;
	private Barcode barcode;
	private JButton btnStampaCodBarre = null;
	private JComboBox cmbCodiciIva = null;

	/**
	 * @param owner
	 */
	public ArticoloAddMod(JFrame owner, int modalita) {
		//super(owner, true);
		this.dbm = DBManager.getIstanceSingleton();
		this.idArticolo = idArticolo;
		this.idCliente = idCliente;
		this.modalita = modalita;
		initialize();
	}

	public ArticoloAddMod(JFrame owner, int idArticolo,int modalita) {
		//super(owner, true);
		this.dbm = DBManager.getIstanceSingleton();
		this.idArticolo = idArticolo;
		this.idCliente = idCliente;
		this.modalita = modalita;
		this.ultimoArticolo=new String[1];
		initialize();
	}


	// in questo metodo costruttore passiamo oltre i vari parametri
	// che già abbiamo inpostato anche un terzo parametro che
	// ci serve per memorizzare l'ultimo codArticolo lavorato
	// questo viene particolarmente usato nel caso di un nuovo articolo
	// quando ci si trova nel carico merce.
	public ArticoloAddMod(JFrame owner,int modalita, String[] codArticolo){
		//super(owner, true);
		this.dbm = DBManager.getIstanceSingleton();
		this.idArticolo = idArticolo;
		this.idCliente = idCliente;
		this.modalita = modalita;
		initialize();
		this.ultimoArticolo=codArticolo;
	}

	// in questo metodo costruttore passiamo oltre i vari parametri
	// che già abbiamo inpostato anche un quarto parametro che
	// ci serve per memorizzare l'ultimo codArticolo lavorato
	// questo viene particolarmente usato nel caso di un nuovo articolo
	// quando ci si trova nel carico merce.
	public ArticoloAddMod(JFrame owner,int idArticolo, int modalita, String[] codArticolo){
		//super(owner, true);
		this.dbm = DBManager.getIstanceSingleton();
		this.idArticolo = idArticolo;
		this.idCliente = idCliente;
		this.modalita = modalita;
		initialize();
		this.ultimoArticolo=codArticolo;
	}



	public void suggerimentoCodice() {
		// usato per passaggio valore di riferimento
		// vecchio codice che visualizzava la maschera
		// per la visualizzazione dei codici
//		String[] codice=new String[1];
//		codice[0]="";
//		SuggerimentoCodice s=new SuggerimentoCodice(this,dbm,codice);
//		s.setVisible(true);
//		txtCodBarre.setText(codice[0]);
		
		// nuovo codice per la generazione random dei codici a barre
		txtCodBarre.setText("");
		String code=ArticoloHome.getInstance().getRandomBarcode();
		txtCodBarre.setText(code);
		pnlBarcode.removeAll();
		try {
			barcode=BarcodeFactory.createCode128(code);
			pnlBarcode.add(barcode);
			pnlBarcode.repaint();
		} catch (BarcodeException e) {
			e.printStackTrace();
		}
	}

	// questo metodo permette di chiudere
	// se vero la finestra nel momento in cui si preme
	// il pulsante OK e viene appunto effettuata la modifica
	// o l'inserimento di  un articolo.
	public void setCloseOnOk(boolean close){
		this.close=close;
	}

	public boolean getCloseOnOk(){
		return this.close;
	}

	/**
	 *
	 */
	private void calcolaPrezzoPubblico() {
		int iva = 0;
		double pListino = 0.0;
		double sconto = 0.0;
		try {
			if(txtPrezzoFinale == null)
				return;
			if (txtPrezzoListino.getText().equals("")) {
				pListino = ControlloDati.convertPrezzoToDouble("0.00");
			} else {
				if (txtPrezzoListino.getValue() instanceof Double) {
					pListino = ((Double) txtPrezzoListino.getValue())
							.doubleValue();
				} else {
					long value = ((Long) txtPrezzoListino.getValue())
							.longValue();
					pListino = new Double(value).doubleValue();
				}
			}
			// pListino = ((Double)txtPrezzoListino.getValue()).doubleValue();
			
			if (((String) cmbCodiciIva.getSelectedItem()).equalsIgnoreCase("")) {
				iva = 0;
			} else{
				CodiciIvaHome.getInstance().begin();
				int cod = new Integer(codCodiceIva[(cmbCodiciIva.getSelectedIndex() - 1)]);
				iva = Integer.parseInt(CodiciIvaHome.getInstance().findById(cod).getCodice());
			}

			// sconto = ((Double)txtSconto.getValue()).doubleValue();

		} catch (NumberFormatException e) {
			JOptionPane.showMessageDialog(this, "Numero malformato",
					"NUMERO ERRATO", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		} catch (ParseException e) {
			JOptionPane.showMessageDialog(this, "Campo prezzo errato",
					"ERRORE", JOptionPane.ERROR_MESSAGE);

			e.printStackTrace();
		}

		double ptot = pListino + (pListino / 100 * iva);
		ptot = ptot - (ptot / 100 * sconto);
		txtPrezzoFinale.setValue(new Double(ptot));

	}



	/**
	 *
	 */
	public void apriDocCarico() {
		ViewDocCarico view = new ViewDocCarico(this, dbm, idArticolo);
		view.setVisible(true);

	}

	/**
	 *
	 */
//	public void apriNuovoFornitore() {
//		FornitoriAdd add = new FornitoriAdd(this);
//		add.setVisible(true);
//		caricaCmbFornitori();
//		// caricaFornitori(cmbFornitori);
//
//	}

	/**
	 *
	 */
	public void apriNuovaCategoria() {
		RepartiGestione add = new RepartiGestione(this);
		add.setVisible(true);
		caricaCmbCategoria();
		// caricaReparti(cmbReparto);
	}
	
	public void apriNuovoPannello() {
		PannelloAdd add = new PannelloAdd(this, dbm);
		add.setVisible(true);
		caricaCmbPannelli();
		// caricaReparti(cmbReparto);

	}

	/**
	 *
	 */
	public void apriNuovoUM() {
		UnitaMisuraAdd add = new UnitaMisuraAdd(this, dbm);
		add.setVisible(true);
		caricaCmbUnitaDiMisura();
		// caricaUnitaMisura(cmbMisura);

	}

	/**
	 * @return the modalita
	 */
	public int getModalita() {
		return modalita;
	}

	public void messaggioCampoErrato(String messaggio) {
		JOptionPane.showMessageDialog(this, messaggio, "ERRORE",
				JOptionPane.ERROR_MESSAGE);
	}

	private void calcolaPrezzo() {
		double per = 0;
		try {
			if (txtRicaricoListino.getText().equalsIgnoreCase("")) {
				per = 0.0;
			} else
				per = new Double(txtRicaricoListino.getText()).doubleValue();
		} catch (NumberFormatException e) {
			messaggioCampoErrato("Campo Errato (###.##): " + e.getMessage());
			// handle
			// exception
		}

		double a = 0;
		try {
			if (txtPrezzoAcquisto.getValue() instanceof Double) {
				a = ((Double) txtPrezzoAcquisto.getValue()).doubleValue();
			} else {
				long value = ((Long) txtPrezzoAcquisto.getValue()).longValue();
				a = new Double(value).doubleValue();
			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		double p = ((a * per) / 100) + a;
		try {
			// String prezzo = (ControlloDati.convertDoubleToPrezzo(p));
			txtPrezzoListino.setValue(new Double(p));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

	}

	private void calcolaPrezzoDettaglio() {
		double pDettaglio = 0.0;
		double sconto = 0.0;

		int iva = 0;
		if (!((String) cmbCodiciIva.getSelectedItem()).equalsIgnoreCase("")) {
			CodiciIvaHome.getInstance().begin();
			int cod = new Integer(codCodiceIva[(cmbCodiciIva.getSelectedIndex() - 1)]);
			iva = Integer.parseInt(CodiciIvaHome.getInstance().findById(cod).getCodice());
		}
		double ptot = pDettaglio + (pDettaglio / 100 * iva);
		ptot = ptot - (ptot / 100 * sconto);
		// txtDettaglio.setText(ControlloDati.convertDoubleToPrezzo(ptot));
	}

	private void calcolaPrezzoListinoByPrezzoAcquisto() {
		double pAcquisto = 0.0;
		double sconto = 0.0;
		double ricarico = 0.0;
		try {
			if (txtPrezzoAcquisto.getText().equals("")) {
				pAcquisto = ControlloDati.convertPrezzoToDouble("0.00");
			} else {
				if (txtPrezzoAcquisto.getValue() instanceof Double) {
					pAcquisto = ((Double) txtPrezzoAcquisto.getValue())
							.doubleValue();
				} else {
					long value = ((Long) txtPrezzoAcquisto.getValue())
							.longValue();
					pAcquisto = new Double(value).doubleValue();
				}
			}
			// pAcquisto = ((Double)txtPrezzoAcquisto.getValue()).doubleValue();

			if (txtRicaricoListino.getText().equals("")) {
				ricarico = ControlloDati.convertPrezzoToDouble("0.00");
			} else {
				if (txtRicaricoListino.getValue() instanceof Double) {
					ricarico = ((Double) txtRicaricoListino.getValue())
							.doubleValue();
				} else {
					long value = ((Long) txtRicaricoListino.getValue())
							.longValue();
					ricarico = new Double(value).doubleValue();
				}
			}
			// ricarico = ((Double)txtRicaricoListino.getValue()).doubleValue();
		} catch (NumberFormatException e) {
			JOptionPane.showMessageDialog(this, "Numero malformato",
					"NUMERO ERRATO", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		} catch (ParseException e) {
			JOptionPane.showMessageDialog(this, "Campo prezzo errato",
					"ERRORE", JOptionPane.ERROR_MESSAGE);

			e.printStackTrace();
		}
		double ptot = pAcquisto + (pAcquisto / 100 * ricarico);
		txtPrezzoListino.setValue(new Double(ptot));
	}

	private void calcolaPrezzoListinoByPrezzoPubblico() {
		double pAcquisto = 0.0;
		int iva = 0;
		try {
			if (txtPrezzoFinale.getText().equals("")) {
				pAcquisto = ControlloDati.convertPrezzoToDouble("0.00");
			} else {
				if (txtPrezzoFinale.getValue() instanceof Double) {
					pAcquisto = ((Double) txtPrezzoFinale.getValue())
							.doubleValue();
				} else {
					long value = ((Long) txtPrezzoFinale.getValue())
							.longValue();
					pAcquisto = new Double(value).doubleValue();
				}
			}
			if (cmbCodiciIva == null)
				return;
			if (((String) cmbCodiciIva.getSelectedItem()).equalsIgnoreCase("")) {
				return;
			} else{
				CodiciIvaHome.getInstance().begin();
				int cod = new Integer(codCodiceIva[(cmbCodiciIva.getSelectedIndex() - 1)]);
				iva = Integer.parseInt(CodiciIvaHome.getInstance().findById(cod).getCodice());
			}

		} catch (NumberFormatException e) {
			JOptionPane.showMessageDialog(this, "Numero malformato",
					"NUMERO ERRATO", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		} catch (ParseException e) {
			JOptionPane.showMessageDialog(this, "Campo prezzo errato",
					"ERRORE", JOptionPane.ERROR_MESSAGE);

			e.printStackTrace();
		}
		double perc = (double) (iva + 100) / 100;
		double ptot = pAcquisto / perc;
		txtPrezzoListino.setValue(new Double(ptot));
	}

	private void calcoloPercentualeRicarico() {
		double pPubblico = 0.0;
		double pAcquisto = 0.0;
		try {
			if(txtRicaricoListino == null)
				return;
			if (txtPrezzoListino.getText().equals("")) {
				pPubblico = new Double(0.00);
			} else {
				if (txtPrezzoListino.getValue() instanceof Double) {
					pPubblico = ((Double) txtPrezzoListino.getValue())
							.doubleValue();
				} else {
					long value = ((Long) txtPrezzoListino.getValue())
							.longValue();
					pPubblico = new Double(value).doubleValue();
				}
			}
			// pPubblico = ((Double)txtPrezzoListino.getValue()).doubleValue();

			if (txtPrezzoAcquisto == null || txtPrezzoAcquisto.getText().equals("")) {
				pAcquisto = new Double(0.00);
			} else {
				if (txtPrezzoAcquisto.getValue() instanceof Double) {
					pAcquisto = ((Double) txtPrezzoAcquisto.getValue())
							.doubleValue();
				} else {
					long value = ((Long) txtPrezzoAcquisto.getValue())
							.longValue();
					pAcquisto = new Double(value).doubleValue();
				}
			}
			// pAcquisto = ((Double)txtPrezzoAcquisto.getValue()).doubleValue();

		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		double d = 0.0;
		if ((pPubblico - pAcquisto) > 0 && pAcquisto > 0)
			d = ((pPubblico - pAcquisto) / pAcquisto) * 100;
		// d = ControlloDati.arrotondaPrezzo(d);
		txtRicaricoListino.setValue(new Double(d));
	}

	/**
	 * @param cmbFornitori2
	 */
//	private void caricaFornitori(JComboBox cmbFornitori) {
//		Fornitore f = new Fornitore();
//		try {
//			// cmbFornitori=new JComboBox(f.allFornitori());
//			cmbFornitori.removeAllItems();
//			cmbFornitori.addItem("");
//			for (String fornitore : (String[]) f.allFornitori()) {
//				cmbFornitori.addItem(fornitore);
//			}
//		} catch (SQLException e) {
//			JOptionPane.showMessageDialog(this,
//					"Errore caricamento fornitori nel combobox", "ERRORE",
//					JOptionPane.ERROR_MESSAGE);
//			e.printStackTrace();
//		}
//
//	}

	/**
	 *
	 */
	private void caricaQtaMagazzino() {
		int qta = 0;
		try {
			qta = rf.pegaso.db.tabelle.Articolo.caricaQtaMagazzino(idArticolo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		txtQta.setText(new Integer(qta).toString());

	}

	/**
	 * @param cmbReparto2
	 */
	private void caricaReparti(JComboBox cmbReparto) {
		Reparto f = new Reparto();
		try {

			cmbReparto.removeAllItems();
			cmbReparto.addItem("");
			for (String reparto : (String[]) f.allReparti()) {
				cmbReparto.addItem(reparto);
			}
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento reparti nel combobox", "ERRORE",
					JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		}

	}

	/**
	 * @param cmbMisura2
	 */
	private void caricaUnitaMisura(JComboBox cmbMisura) {
		UnitaDiMisura f = new UnitaDiMisura();
		try {
			// cmbFornitori=new JComboBox(f.allFornitori());
			cmbMisura.removeAllItems();
			cmbMisura.addItem("");
			for (String misura : (String[]) f.allUnitaDiMisura()) {
				cmbMisura.addItem(misura);
			}
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento unita di misura nel combobox",
					"ERRORE", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		}

	}

	/**
	 * @param string
	 * @return
	 */
	private int estraiCodice(String string) {
		int index = string.indexOf("-");
		if (index != -1) {
			string = string.substring(0, index - 1);
			return Integer.parseInt(string);
		}
		return 0;

	}

	/**
	 * This method initializes btnChiudi
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnChiudi() {
		if (btnChiudi == null) {
			try {
				btnChiudi = new JButton();
				btnChiudi.setText("Chiudi");
				btnChiudi.setPreferredSize(new Dimension(83, 26)); // Generated
				btnChiudi.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {

			}
		}
		return btnChiudi;
	}

	/**
	 * This method initializes btnDocCarico
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnDocCarico() {
		if (btnDocCarico == null) {
			try {
				btnDocCarico = new JButton();
				btnDocCarico.setText("Doc. di Carico");
				btnDocCarico.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnDocCarico;
	}

	/**
	 * This method initializes btnInsMod
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnInsMod() {
		if (btnInsMod == null) {
			try {
				btnInsMod = new JButton();
				if (modalita == MOD)
					btnInsMod.setText("OK");
				else
					btnInsMod.setText("OK");
				btnInsMod.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnInsMod;
	}

	/**
	 * This method initializes btnNewReparto
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnNewReparto() {
		if (btnNewReparto == null) {
			try {
				btnNewReparto = new JButton();
				btnNewReparto.setBounds(new Rectangle(192, 196, 69, 26)); // Generated
				btnNewReparto.setText("Nuovo");
				btnNewReparto.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnNewReparto;
	}

	/**
	 * This method initializes btnNewUM
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnNewUM() {
		if (btnNewUM == null) {
			try {
				btnNewUM = new JButton();
				btnNewUM.setBounds(new Rectangle(312, 109, 69, 26)); // Generated
				btnNewUM.setText("Nuovo");
				btnNewUM.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnNewUM;
	}

	/**
	 * This method initializes cmbMisura
	 *
	 * @return javax.swing.JComboBox
	 */
	private JComboBox getCmbMisura() {
		if (cmbMisura == null) {
			try {
				cmbMisura = new JComboBox();
				cmbMisura.setPreferredSize(new Dimension(70, 25)); // Generated
				cmbMisura.setBounds(new Rectangle(232, 109, 70, 25)); // Generated
				// caricaUnitaMisura(cmbMisura);
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return cmbMisura;
	}

	/**
	 * This method initializes cmbReparto
	 *
	 * @return javax.swing.JComboBox
	 */
	private JComboBox getCmbReparto() {
		if (cmbReparto == null) {
			try {
				cmbReparto = new JComboBox();
				cmbReparto.setPreferredSize(new Dimension(150, 25)); // Generated
				cmbReparto.setBounds(new Rectangle(7, 197, 169, 25)); // Generated
				// caricaReparti(cmbReparto);
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return cmbReparto;
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
			jContentPane.add(getPnlCentrale(), BorderLayout.CENTER); // Generated
			jContentPane.add(getJPanel(), BorderLayout.NORTH); // Generated
		}
		return jContentPane;
	}

	/**
	 * This method initializes jPanel
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getJPanel() {
		if (jPanel == null) {
			try {
				FlowLayout flowLayout = new FlowLayout();
				flowLayout.setAlignment(FlowLayout.LEFT); // Generated
				jPanel = new JPanel();
				jPanel.setBorder(BorderFactory
						.createBevelBorder(BevelBorder.RAISED)); // Generated
				jPanel.setLayout(flowLayout); // Generated
				jPanel.setPreferredSize(new Dimension(0, 40)); // Generated
				jPanel.add(getBtnInsMod(), null); // Generated
				jPanel.add(getBtnChiudi(), null); // Generated
				jPanel.add(getBtnDocCarico(), null); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jPanel;
	}

	/**
	 * This method initializes jPanel1
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getJPanel1() {
		if (jPanel1 == null) {
			try {
				lblIngrosso = new JLabel();
				lblIngrosso.setBounds(new Rectangle(8, 20, 73, 21)); // Generated
				lblIngrosso.setText("Pubblico \u20AC"); // Generated
				jPanel1 = new JPanel();
				jPanel1.setLayout(null); // Generated
				jPanel1.setBounds(new Rectangle(321, 162, 201, 64)); // Generated
				jPanel1.setBorder(BorderFactory.createTitledBorder(
						BorderFactory.createBevelBorder(BevelBorder.RAISED),
						"Prezzo al Pubblico",
						TitledBorder.DEFAULT_JUSTIFICATION,
						TitledBorder.DEFAULT_POSITION, new Font("Dialog",
								Font.BOLD, 12), new Color(51, 51, 51))); // Generated
				jPanel1.add(lblIngrosso, null); // Generated
				jPanel1.add(getTxtIngrosso(), null); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jPanel1;
	}

	/**
	 * This method initializes jPanel2
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getJPanel2() {
		if (jPanel2 == null) {
			try {
				lblQta = new JLabel();
				lblQta.setBounds(new Rectangle(8, 24, 57, 21)); // Generated
				lblQta.setText("Quantit\u00E0"); // Generated
				jPanel2 = new JPanel();
				jPanel2.setLayout(null); // Generated
				jPanel2.setBounds(new Rectangle(529, 162, 201, 65)); // Generated
				jPanel2.setBorder(BorderFactory.createTitledBorder(
						BorderFactory.createBevelBorder(BevelBorder.RAISED),
						"Magazzino", TitledBorder.DEFAULT_JUSTIFICATION,
						TitledBorder.DEFAULT_POSITION, new Font("Dialog",
								Font.BOLD, 12), new Color(51, 51, 51))); // Generated
				jPanel2.add(lblQta, null); // Generated
				jPanel2.add(getTxtQta(), null); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jPanel2;
	}

	/**
	 * This method initializes jScrollPane1
	 *
	 * @return javax.swing.JScrollPane
	 */
	private JScrollPane getJScrollPane1() {
		if (jScrollPane1 == null) {
			try {
				jScrollPane1 = new JScrollPane();
				jScrollPane1.setBounds(new Rectangle(6, 290, 297, 41)); // Generated
				jScrollPane1.setViewportView(getTxtNote()); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jScrollPane1;
	}

	/**
	 * This method initializes jTabbedPane
	 *
	 * @return javax.swing.JTabbedPane
	 */
	private JTabbedPane getJTabbedPane() {
		if (jTabbedPane == null) {
			try {
				jTabbedPane = new JTabbedPane();
				jTabbedPane.addTab("Articolo", null, getPnlDatiPersonali(),
						null); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jTabbedPane;
	}

	/**
	 * This method initializes pnlCentrale
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlCentrale() {
		if (pnlCentrale == null) {
			try {
				pnlCentrale = new JPanel();
				pnlCentrale.setLayout(new BorderLayout()); // Generated
				pnlCentrale.add(getJTabbedPane(), BorderLayout.CENTER); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return pnlCentrale;
	}

	/**
	 * This method initializes pnlDatiPersonali
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlDatiPersonali() {
		if (pnlDatiPersonali == null) {
			try {
				lblQtaInfinita = new JLabel();
				lblQtaInfinita.setBounds(new Rectangle(287, 137, 99, 16));
				lblQtaInfinita.setText("Qta Infinita");
				lblPannelli = new JLabel();
				lblPannelli.setBounds(new Rectangle(7, 230, 120, 16));
				lblPannelli.setText("Pannello Rapido");
				lblNo = new JLabel();
				lblNo.setBounds(new Rectangle(432, 30, 15, 16));
				lblNo.setText("No");
				lblSi = new JLabel();
				lblSi.setBounds(new Rectangle(372, 30, 11, 16));
				lblSi.setText("Si");
				lblrButtonSiNo = new JLabel();
				lblrButtonSiNo.setBounds(new Rectangle(372, 12, 86, 16));
				lblrButtonSiNo.setText("Modificabili");
				lblNota = new JLabel();
				lblNota.setText("Note"); // Generated
				lblNota.setBounds(new Rectangle(6, 274, 40, 16)); // Generated
				lblReaprto = new JLabel();
				lblReaprto.setText("Categoria Merceologica"); // Generated
				lblReaprto.setBounds(new Rectangle(7, 181, 149, 16)); // Generated
				lblRicaricoIngrosso = new JLabel();
				lblRicaricoIngrosso.setText("Ricarico Listino %"); // Generated
				lblRicaricoIngrosso.setBounds(new Rectangle(147, 137, 112, 16)); // Generated
				lblUnitaMisura = new JLabel();
				lblUnitaMisura.setText("UM"); // Generated
				lblUnitaMisura.setBounds(new Rectangle(232, 93, 28, 16)); // Generated
				lblIva = new JLabel();
				lblIva.setText("% Iva"); // Generated
				lblIva.setBounds(new Rectangle(147, 95, 38, 16)); // Generated
				lblPrezzoIngrosso = new JLabel();
				lblPrezzoIngrosso.setText("Prezzo di Listino"); // Generated
				lblPrezzoIngrosso.setBounds(new Rectangle(6, 137, 113, 16)); // Generated
				lblPrezzoAcquisto = new JLabel();
				lblPrezzoAcquisto.setText("Prezzo Acquisto"); // Generated
				lblPrezzoAcquisto.setBounds(new Rectangle(7, 95, 110, 16)); // Generated
				lblDescrizione = new JLabel();
				lblDescrizione.setText("Descrizione"); // Generated
				lblDescrizione.setBounds(new Rectangle(7, 54, 80, 16)); // Generated
				lblCodFornitore = new JLabel();
				lblCodFornitore.setText("Codice Fornitore"); // Generated
				lblCodFornitore.setBounds(new Rectangle(206, 12, 110, 16)); // Generated
				lblCodBarre = new JLabel();
				lblCodBarre.setText("Codice Barre"); // Generated
				lblCodBarre.setBounds(new Rectangle(7, 13, 110, 16)); // Generated
				pnlDatiPersonali = new JPanel();
				pnlDatiPersonali.setLayout(null); // Generated
				pnlDatiPersonali.setBorder(BorderFactory
						.createBevelBorder(BevelBorder.RAISED)); // Generated
				pnlDatiPersonali.add(getTxtCodBarre(), null); // Generated
				pnlDatiPersonali.add(getTxtCodFornitore(), null); // Generated
				pnlDatiPersonali.add(lblCodBarre, null); // Generated
				pnlDatiPersonali.add(lblCodFornitore, null); // Generated
				pnlDatiPersonali.add(lblDescrizione, null); // Generated
				pnlDatiPersonali.add(lblPrezzoAcquisto, null); // Generated
				pnlDatiPersonali.add(getTxtDescrizione(), null); // Generated
				pnlDatiPersonali.add(getTxtPrezzoAcquisto(), null); // Generated
				pnlDatiPersonali.add(lblPrezzoIngrosso, null); // Generated
				pnlDatiPersonali.add(getTxtPrezzoIngrosso(), null); // Generated
				pnlDatiPersonali.add(lblIva, null); // Generated
				pnlDatiPersonali.add(lblUnitaMisura, null); // Generated
				pnlDatiPersonali.add(getCmbMisura(), null); // Generated
				pnlDatiPersonali.add(lblRicaricoIngrosso, null); // Generated
				pnlDatiPersonali.add(getTxtRicaricoIngrosso(), null); // Generated
				pnlDatiPersonali.add(lblReaprto, null); // Generated
				pnlDatiPersonali.add(getCmbReparto(), null); // Generated
				pnlDatiPersonali.add(lblNota, null); // Generated
				pnlDatiPersonali.add(getJScrollPane1(), null); // Generated
				pnlDatiPersonali.add(getJPanel1(), null); // Generated
				pnlDatiPersonali.add(getBtnNewUM(), null); // Generated
				pnlDatiPersonali.add(getBtnNewReparto(), null); // Generated
				pnlDatiPersonali.add(getJPanel2(), null); // Generated
				pnlDatiPersonali.add(getBtnSuggerimento(), null);  // Generated
				pnlDatiPersonali.add(lblrButtonSiNo, null);
				pnlDatiPersonali.add(lblSi, null);
				pnlDatiPersonali.add(lblNo, null);
				pnlDatiPersonali.add(getRbtnSi(), null);
				pnlDatiPersonali.add(getRbtnNo(), null);
				pnlDatiPersonali.add(lblPannelli, null);
				pnlDatiPersonali.add(getCmbPannelli(), null);
				pnlDatiPersonali.add(getBtnNewPannello(), null);
				pnlDatiPersonali.add(getChkBoxQtaInfinita(), null);
				pnlDatiPersonali.add(lblQtaInfinita, null);
				pnlDatiPersonali.add(getPnlImage(), null);
				pnlDatiPersonali.add(getPnlBarcode(), null);
				pnlDatiPersonali.add(getBtnStampaCodBarre(), null);
				pnlDatiPersonali.add(getCmbCodiciIva(), null);
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return pnlDatiPersonali;
	}

	/**
	 * This method initializes txtCodBarre
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtCodBarre() {
		if (txtCodBarre == null) {
			try {
				txtCodBarre = new JTextField();
				txtCodBarre.setPreferredSize(new Dimension(140, 20)); // Generated
				txtCodBarre.setBounds(new Rectangle(7, 29, 154, 20)); // Generated
				txtCodBarre.setDocument(new UpperTextDocument());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtCodBarre;
	}

	/**
	 * This method initializes txtCodFornitore
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtCodFornitore() {
		if (txtCodFornitore == null) {
			try {
				txtCodFornitore = new JTextField();
				txtCodFornitore.setPreferredSize(new Dimension(140, 20)); // Generated
				txtCodFornitore.setBounds(new Rectangle(206, 28, 154, 20)); // Generated
				txtCodFornitore.setDocument(new UpperTextDocument());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtCodFornitore;
	}

	/**
	 * This method initializes txtDescrizione
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtDescrizione() {
		if (txtDescrizione == null) {
			try {
				txtDescrizione = new JTextField();
				txtDescrizione.setPreferredSize(new Dimension(140, 20)); // Generated
				txtDescrizione.setBounds(new Rectangle(7, 70, 472, 20)); // Generated
				txtDescrizione.setDocument(new UpperTextDocument());
				
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtDescrizione;
	}

	/**
	 * This method initializes txtIngrosso
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtIngrosso() {
		if (txtPrezzoFinale == null) {
			try {
				DecimalFormat formatPrice = new DecimalFormat();
				formatPrice.setMaximumFractionDigits(2);
				formatPrice.setMinimumFractionDigits(2);
				txtPrezzoFinale = new JFormattedTextField(formatPrice){
					@Override
					protected void processFocusEvent(FocusEvent e) {
						// modifica effettuata per permettere l'evidenziazione delle
						// caselle quando si guadagna il focus
						super.processFocusEvent(e);
						if ( e.getID() == FocusEvent.FOCUS_GAINED )
						selectAll() ;
					}
				};
				txtPrezzoFinale.setBounds(new Rectangle(84, 20, 97, 21)); // Generated
				txtPrezzoFinale.setEditable(true); // Generated
				txtPrezzoFinale.setBackground(Color.green); // Generated
				/*
				 * txtPrezzoFinale.addFocusListener(new
				 * java.awt.event.FocusAdapter() { public void
				 * focusLost(java.awt.event.FocusEvent e) {
				 * calcolaPrezzoListinoByPrezzoPubblico();
				 * calcoloPercentualeRicarico(); } });
				 */

				txtPrezzoFinale.addPropertyChangeListener("value", this);
				txtPrezzoFinale.setValue(new Double(0));
				txtPrezzoFinale.addFocusListener(new java.awt.event.FocusAdapter() {
					public void focusGained(java.awt.event.FocusEvent e) {
						selezionaTestoIntero(txtPrezzoFinale);
					}
				});
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtPrezzoFinale;
	}

	/**
	 * This method initializes txtNote
	 *
	 * @return javax.swing.JTextArea
	 */
	private JTextArea getTxtNote() {
		if (txtNote == null) {
			try {
				txtNote = new JTextArea();
				txtNote.setLineWrap(true);
				txtNote.setDocument(new UpperTextDocument());

			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtNote;
	}

	/**
	 * This method initializes txtPrezzoAcquisto
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtPrezzoAcquisto() {
		if (txtPrezzoAcquisto == null) {
			try {
				DecimalFormat formatPrice = new DecimalFormat();
				formatPrice.setMaximumFractionDigits(2);
				formatPrice.setMinimumFractionDigits(2);
				txtPrezzoAcquisto = new JFormattedTextField(formatPrice){
					protected void processFocusEvent(FocusEvent e) {
						// modifica effettuata per permettere l'evidenziazione delle
						// caselle quando si guadagna il focus
						super.processFocusEvent(e);
						if ( e.getID() == FocusEvent.FOCUS_GAINED )
						selectAll() ;
					}
				};
				txtPrezzoAcquisto.setPreferredSize(new Dimension(100, 20)); // Generated
				txtPrezzoAcquisto.setBounds(new Rectangle(7, 111, 101, 20)); // Generated
				txtPrezzoAcquisto.setDocument(new UpperTextDocument());
				txtPrezzoAcquisto.addPropertyChangeListener("value", this);
				txtPrezzoAcquisto.setValue(new Double(0));
				txtPrezzoAcquisto.addFocusListener(new java.awt.event.FocusAdapter() {
					public void focusGained(java.awt.event.FocusEvent e) {
						txtPrezzoAcquisto.selectAll();
						
					}
				});
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtPrezzoAcquisto;
	}

	protected void selezionaTestoIntero(JTextField txt) {
		txt.requestFocusInWindow();
		txt.selectAll();
		
	}

	/**
	 * This method initializes txtPrezzoIngrosso
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtPrezzoIngrosso() {
		if (txtPrezzoListino == null) {
			try {
				DecimalFormat formatPrice = new DecimalFormat();
				formatPrice.setMaximumFractionDigits(2);
				formatPrice.setMinimumFractionDigits(2);
				txtPrezzoListino = new JFormattedTextField(formatPrice){
					@Override
					protected void processFocusEvent(FocusEvent e) {
						// modifica effettuata per permettere l'evidenziazione delle
						// caselle quando si guadagna il focus
						super.processFocusEvent(e);
						if ( e.getID() == FocusEvent.FOCUS_GAINED )
						selectAll() ;
					}
				};
				txtPrezzoListino.setPreferredSize(new Dimension(100, 20)); // Generated
				txtPrezzoListino.setBounds(new Rectangle(6, 153, 113, 20)); // Generated
				/*
				 * txtPrezzoListino.addFocusListener(new
				 * java.awt.event.FocusAdapter() { public void
				 * focusLost(java.awt.event.FocusEvent e) {
				 * calcoloPercentualeRicarico(); calcolaPrezzoPubblico(); } });
				 */
				txtPrezzoListino.addPropertyChangeListener("value", this);
				txtPrezzoListino.setValue(new Double(0));
				txtPrezzoListino.addFocusListener(new java.awt.event.FocusAdapter() {
					public void focusGained(java.awt.event.FocusEvent e) {
						selezionaTestoIntero(txtPrezzoListino);
					}
				});
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtPrezzoListino;
	}

	/**
	 * This method initializes txtQta
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtQta() {
		if (txtQta == null) {
			try {
				txtQta = new JTextField();
				txtQta.setBounds(new Rectangle(67, 24, 58, 20)); // Generated
				txtQta.setBackground(Color.green); // Generated
				txtQta.setEditable(false); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtQta;
	}

	/**
	 * This method initializes txtRicaricoIngrosso
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtRicaricoIngrosso() {
		if (txtRicaricoListino == null) {
			try {
				DecimalFormat formatPrice = new DecimalFormat();
				formatPrice.setMaximumFractionDigits(2);
				formatPrice.setMinimumFractionDigits(2);
				txtRicaricoListino = new JFormattedTextField(formatPrice){
					@Override
					protected void processFocusEvent(FocusEvent e) {
						// modifica effettuata per permettere l'evidenziazione delle
						// caselle quando si guadagna il focus
						super.processFocusEvent(e);
						if ( e.getID() == FocusEvent.FOCUS_GAINED )
						selectAll() ;
					}
				};
				txtRicaricoListino.setPreferredSize(new Dimension(100, 20)); // Generated
				txtRicaricoListino.setBounds(new Rectangle(147, 153, 112, 20));
				/*
				 * txtRicaricoListino.addFocusListener(new
				 * java.awt.event.FocusAdapter() { public void
				 * focusLost(java.awt.event.FocusEvent e) {
				 * calcolaPrezzoListinoByPrezzoAcquisto();
				 * calcolaPrezzoPubblico(); } });
				 */

				txtRicaricoListino.addPropertyChangeListener("value", this);
				txtRicaricoListino.setValue(new Double(0));
				txtRicaricoListino.addFocusListener(new java.awt.event.FocusAdapter() {
					public void focusGained(java.awt.event.FocusEvent e) {
						selezionaTestoIntero(txtRicaricoListino);
					}
				});
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return txtRicaricoListino;
	}

	private void impostaCampi(Articolo art) {
		this.txtCodBarre.setText(art.getCodbarre());
		this.txtCodFornitore.setText(art.getCodfornitore());
		this.txtDescrizione.setText(art.getDescrizione());
		this.txtNote.setText(art.getNote());
		this.txtPrezzoAcquisto.setValue(art.getPrezzoAcquisto());
		this.txtPrezzoListino.setValue(art.getPrezzoIngrosso());
		int pos;
		// cerchiamo la pos del codice nell'array fornitori
//		if ( art.getFornitori() != null ){
//			pos = Arrays.ricercaLineare(codFornitori, new Long(art.getFornitori().getIdfornitore()).toString());
//			this.cmbFornitori.setSelectedIndex(pos+1);
//		}
		// cerchiamo la pos del codice nell'array unità di misura
		pos = Arrays.ricercaLineare(codUnitaDiMisura, new Long(art.getUm().getIdum()).toString());
		this.cmbMisura.setSelectedIndex(pos+1);
		// cerchiamo la pos del codice nell'array reparti
		pos = Arrays.ricercaLineare(codReparti, new Long(art.getReparto().getIdreparto()).toString());
		this.cmbReparto.setSelectedIndex(pos+1);
		// cerchiamo la pos del codice nell'array codici iva
		pos = Arrays.ricercaLineare(codCodiceIva, new Long(art.getCodiciIva().getId()).toString());
		this.cmbCodiciIva.setSelectedIndex(pos+1);
		// cerchiamo la pos del codice nell'array pannelli
		if ( art.getPannelli() != null ){
			pos = Arrays.ricercaLineare(codPannelli, new Long(art.getPannelli().getIdpannelli()).toString());
			this.cmbPannelli.setSelectedIndex(pos+1);
		}
		this.chkBoxQtaInfinita.setSelected(art.getQtaInfinita());
	}

	/**
	 * This method initializes this
	 *
	 * @return void
	 */
	private void initialize() {
		this.setSize(750, 444);
		this.setResizable(false); // Generated

		this.setContentPane(getJContentPane());
		UtilGUI.centraFrame(this);
		// Modifichiamo l'editor e aggiorniamo
		// Combo box con i relativi dati dal DB
		caricaComboBox();
		this.addWindowListener(this);
		
		inizializzaRadioButton();

		// se selezionata la modalità modifica
		// carichiamo i cari dati negli oggetti
		if (modalita == MOD) {
			this.setTitle("Modifica Articolo");
			Articolo art;
			art = ArticoloHome.getInstance().findById(idArticolo);
			ultimoArticolo[0]=art.getCodbarre();
			impostaCampi(art);
//			calcoloPercentualeRicarico();
//			calcolaPrezzoListinoByPrezzoAcquisto();
//			calcolaPrezzoPubblico();
			caricaQtaMagazzino();
			// Verifichiamo se il codice a barre e' diverso da nullo rendiamo il campo editabile
			if ( art.getCodbarre() != null && !art.getCodbarre().trim().equals("") ){
				rbtnNo.setSelected(true);
				txtCodBarre.setEditable(false);
				txtCodFornitore.setEditable(false);
				btnSuggerimento.setEnabled(false);
			}
			else{
				rbtnSi.setSelected(true);
				txtCodBarre.setEditable(true);
				txtCodFornitore.setEditable(true);
				btnSuggerimento.setEnabled(true);
			}
			if ( art != null && art.getImmagineArticolos().size() != 0 ){
				ArrayList<ImmagineArticolo> imgList = new ArrayList(art.getImmagineArticolos());
				imgArticolo = imgList.get(0);
				lbl1.setIcon(UtilityImage.resizeImage(new ImageIcon(imgArticolo.getFile()), 50, 50));
			}
		} else {
			this.setTitle("Inserisci Articoli");
			// Si tratta di un nuovo articolo quindi il codice dev'essere editabile
			rbtnSi.setSelected(true);
			txtCodBarre.setEditable(true);
			txtCodFornitore.setEditable(true);
			btnSuggerimento.setEnabled(true);
		}// fine impostazione tipo finestra

	}
	
	private void inizializzaRadioButton() {
		ButtonGroup g = new ButtonGroup();
		g.add(rbtnSi);
		g.add(rbtnNo);
	}

	/**
	 *
	 */
	private void caricaComboBox() {
//		caricaCmbFornitori();
		caricaCmbCategoria();
		caricaCmbUnitaDiMisura();
		caricaCmbPannelli();
		caricaCmbCodiciIva();
	}

	/**
	 *
	 */
	private void caricaCmbUnitaDiMisura() {
		cmbMisura.removeAllItems();
		UnitaDiMisura f = new UnitaDiMisura();
		String allUnita[] = null;

		try {
			allUnita = (String[]) f.allUnitaDiMisura();
		} catch (SQLException e2) {
			messaggioErroreCampo("Errore caricamento dati fornitori");
			e2.printStackTrace();
		}

		// questi due array li usiamo per tenere
		// traccia dei codici del fornitore in
		// base alla posizione che si trovano nel combo
		int size = allUnita.length;
		codUnitaDiMisura = new String[size];
		descUnitaDiMisura = new String[size];

		// Impostiamo e carichiamo i dati nel combobox
		cmbMisura.setEditable(true);
		cmbMisura.addItem("");
		for (int i = 0; i < size; i++) {
			String cod = allUnita[i].substring(0, allUnita[i].indexOf("-") - 1);
			String des = allUnita[i].substring(allUnita[i].indexOf("-") + 2);
			codUnitaDiMisura[i] = cod;
			descUnitaDiMisura[i] = des;
			cmbMisura.addItem(descUnitaDiMisura[i]);
		}
		// cambiamo l'edito del combo
		JTextComponent editor = (JTextComponent) cmbMisura.getEditor()
				.getEditorComponent();
		//new ComboBoxAutoComplete(cmbMisura);
		AutoCompletion.enable(cmbMisura);

	}
	
	private void caricaCmbCodiciIva() {
		cmbCodiciIva.removeAllItems();
		UnitaDiMisura f = new UnitaDiMisura();
		String allCodiciIva[] = null;
		CodiciIvaHome.getInstance().begin();
		try {
			List<CodiciIva> result = CodiciIvaHome.getInstance().findAll();
			allCodiciIva = new String[result.size()];
			for(int i = 0; i < result.size(); i++){
				CodiciIva ci = result.get(i);
				allCodiciIva[i] = ci.getId() + " - " +ci.getDescrizione();
			}
		} catch (FindAllEntityException e) {
			messaggioErroreCampo("Errore caricamento dati Codici Iva.");
			e.printStackTrace();
		}

		// questi due array li usiamo per tenere
		// traccia dei codici del fornitore in
		// base alla posizione che si trovano nel combo
		int size = allCodiciIva.length;
		codCodiceIva = new String[size];
		descCodiceIva = new String[size];

		// Impostiamo e carichiamo i dati nel combobox
		cmbCodiciIva.setEditable(true);
		cmbCodiciIva.addItem("");
		for (int i = 0; i < size; i++) {
			String cod = allCodiciIva[i].substring(0, allCodiciIva[i].indexOf("-") - 1);
			String des = allCodiciIva[i].substring(allCodiciIva[i].indexOf("-") + 2);
			codCodiceIva[i] = cod;
			descCodiceIva[i] = des;
			cmbCodiciIva.addItem(descCodiceIva[i]);
		}
		// cambiamo l'edito del combo
		JTextComponent editor = (JTextComponent) cmbCodiciIva.getEditor()
				.getEditorComponent();
		//new ComboBoxAutoComplete(cmbMisura);
		AutoCompletion.enable(cmbCodiciIva);

	}

	/**
	 *
	 */
	private void caricaCmbCategoria() {
		cmbReparto.removeAllItems();
		Reparto f = new Reparto();
		String allReparti[] = null;

		try {
			allReparti = (String[]) f.allReparti();
		} catch (SQLException e2) {
			messaggioErroreCampo("Errore caricamento dati fornitori");
			e2.printStackTrace();
		}

		// questi due array li usiamo per tenere
		// traccia dei codici del fornitore in
		// base alla posizione che si trovano nel combo
		int size = allReparti.length;
		codReparti = new String[size];
		descReparti = new String[size];

		// Impostiamo e carichiamo i dati nel combobox
		cmbReparto.setEditable(true);
		cmbReparto.addItem("");
		for (int i = 0; i < size; i++) {
			String cod = allReparti[i].substring(0,
					allReparti[i].indexOf("-") - 1);
			String des = allReparti[i]
					.substring(allReparti[i].indexOf("-") + 2);
			codReparti[i] = cod;
			descReparti[i] = des;
			cmbReparto.addItem(descReparti[i]);
		}
		//new ComboBoxAutoComplete(cmbReparto);
		AutoCompletion.enable(cmbReparto);

	}
	
	private void caricaCmbPannelli() {
		cmbPannelli.removeAllItems();
		PannelliHome.getInstance().begin();
		ArrayList<Pannelli> pannelli = new ArrayList<Pannelli>();
		try {
			pannelli = PannelliHome.getInstance().allPannelli();
		} catch (FindAllEntityException e) {
			e.printStackTrace();
		}
		String [] allPannelli = new String[pannelli.size()];
		// questi due array li usiamo per tenere
		// traccia dei codici del fornitore in
		// base alla posizione che si trovano nel combo
		codPannelli = new String[pannelli.size()];
		descPannelli = new String[pannelli.size()];
		// Impostiamo e carichiamo i dati nel combobox
		cmbPannelli.setEditable(true);
		cmbPannelli.addItem("");
		int count = 0;
		for (Pannelli p : pannelli){
			allPannelli[count] = p.getIdpannelli()+"-"+p.getNome();
			codPannelli[count] = String.valueOf(p.getIdpannelli());
			descPannelli[count] = p.getNome();
			cmbPannelli.addItem(p.getNome());
			count++;
		}
		
		//new ComboBoxAutoComplete(cmbReparto);
		AutoCompletion.enable(cmbPannelli);

	}

//	/**
//	 *
//	 */
//	private void caricaCmbFornitori() {
//		cmbFornitori.removeAllItems();
//		Fornitore f = new Fornitore();
//		String allFornitori[] = null;
//
//		try {
//			allFornitori = (String[]) f.allFornitori();
//		} catch (SQLException e2) {
//			messaggioErroreCampo("Errore caricamento dati fornitori");
//			e2.printStackTrace();
//		}
//
//		// questi due array li usiamo per tenere
//		// traccia dei codici del fornitore in
//		// base alla posizione che si trovano nel combo
//		int size = allFornitori.length;
//		codFornitori = new String[size];
//		descFornitori = new String[size];
//
//		// Impostiamo e carichiamo i dati nel combobox
//		cmbFornitori.setEditable(true);
//		cmbFornitori.addItem("");
//		for (int i = 0; i < size; i++) {
//			String cod = allFornitori[i].substring(0, allFornitori[i]
//					.indexOf("-") - 1);
//			String des = allFornitori[i]
//					.substring(allFornitori[i].indexOf("-") + 2);
//			codFornitori[i] = cod;
//			descFornitori[i] = des;
//			cmbFornitori.addItem(descFornitori[i]);
//		}
//		// cambiamo l'edito del combo
//		JTextComponent editor = (JTextComponent) cmbFornitori.getEditor()
//				.getEditorComponent();
//		AutoCompletion.enable(cmbFornitori);
//
//	}
	
	private void caricaImmagine(){
		JFileChooser chooser = new JFileChooser(System.getProperty("user.dir"));
		int scelta = chooser.showOpenDialog(this);
		if (scelta == JFileChooser.APPROVE_OPTION) {
			imgArticolo = new ImmagineArticolo();
			imgArticolo.setNome(chooser.getSelectedFile().getName());
			UtilityImage.loadImageFromURL(chooser.getSelectedFile().getPath(), imgArticolo, this);
			ImageIcon img = new ImageIcon(imgArticolo.getFile());
			lbl1.setIcon(UtilityImage.resizeImage(img, 50, 50));
		}
	}
	
	private void rimuoviImmagine(){
		lbl1.setIcon(null);
		imgArticolo = null;
	}

	private void inserisci() {
		try{
			Articolo a = new Articolo();
			boolean ok = recuperaDatiCampi(a);
			if (ok) {
				ArticoloHome.getInstance().begin();
				if ( !ArticoloHome.getInstance().codBarreEsistenteForInsert(a.getCodbarre()) ){
					a.setIdarticolo(dbm.getNewID("articolo","idarticolo"));
					ArticoloHome.getInstance().begin();
					ArticoloHome.getInstance().persist(a);
					ArticoloHome.getInstance().begin();
					ArticoloHome.getInstance().commitAndClose();
					Scarico sc = new Scarico();
					Carico c = new Carico();
					try {
						a.setQtaInfinita(chkBoxQtaInfinita.isSelected());
						if ( a.getQtaInfinita() ){
							c.setIdCarico(0);
							c.insertArticolo((int)a.getIdarticolo(), 0, a.getPrezzoAcquisto());
						}
						sc.insertScaricoInizialeZero((int)a.getIdarticolo());					
					} catch (SQLException e) {
						e.printStackTrace();
					}
					svuotaCampi();
				}
				else {
					JOptionPane.showMessageDialog(this, "Codice a Barre gi\u00E0 presente in magazzino.",
							"ERRORE", JOptionPane.ERROR_MESSAGE);
					return;
				}
			}

			// chiusura della finestra se selezionata
			//opzione closeOnOK
			if(this.close)
				dispose();
		}
		catch(FindByNotFoundException fe){
			JOptionPane.showMessageDialog(this, fe.toString(),
					"ERRORE", JOptionPane.ERROR_MESSAGE);
			fe.printStackTrace();
		}
	}
	
	private void modifica() {
		if (idArticolo <= 0)
			JOptionPane.showMessageDialog(this, "Codice idArticolo errato",
					"ERRORE", JOptionPane.ERROR_MESSAGE);
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler modificare\nl'articolo selezionato?",
				"AVVISO", JOptionPane.YES_NO_OPTION,
				JOptionPane.INFORMATION_MESSAGE);
		if (scelta != JOptionPane.YES_OPTION)
			return;
		try{
			ArticoloHome.getInstance().begin();
			Articolo a = ArticoloHome.getInstance().findById(idArticolo);
			String oldCodBarre = a.getCodbarre();
			boolean ok = recuperaDatiCampi(a);
			if ( ok ){
				ArticoloHome.getInstance().begin();
				// Se il codice a barre e' stato modificato
				if ( !a.getCodbarre().equals(oldCodBarre) ){
					// Dobbiamo verificare se quel codice a barre e' utilizzabile
					if ( ArticoloHome.getInstance().codBarreEsistenteForUpdate(a.getCodbarre(), a.getIdarticolo()) ){
						// codice a barre non inseribile
						JOptionPane.showMessageDialog(this, "Codice a Barre gi\u00E0 presente in magazzino.",
								"ERRORE", JOptionPane.ERROR_MESSAGE);
					}
					else {
						// Possiamo persistere le modifiche
						ArticoloHome.getInstance().persist(a);
						ArticoloHome.getInstance().commit();
					}
				}
				// Il codice a barre non e' stato modificato quindi si puo' salvare
				else{
					ArticoloHome.getInstance().persist(a);
					ArticoloHome.getInstance().commit();
				}
			}else{
				return;
			}

			this.ultimoArticolo[0]=a.getCodbarre();
			this.dispose();
		}
		catch(FindByNotFoundException fe){
			JOptionPane.showMessageDialog(this, fe.toString(),
					"ERRORE", JOptionPane.ERROR_MESSAGE);
			fe.printStackTrace();
		}

	}
	
	/**
	 * @throws FindByNotFoundException 
	 *
	 */
	private boolean recuperaDatiCampi(Articolo a) throws FindByNotFoundException {

		if ( txtCodBarre.getText().trim().equals("") || txtCodBarre.getText().length() < 4 ){
			JOptionPane.showMessageDialog(this, "Codice a Barre non valido.",
					"ERRORE", JOptionPane.ERROR_MESSAGE);
			return false;
		}
		
		a.setCodbarre(txtCodBarre.getText());
		a.setCodfornitore(txtCodFornitore.getText());
		// Controllo se è stato selezionato l'unità di misura
		if (((String) cmbMisura.getSelectedItem()).equalsIgnoreCase("")) {
			messaggioCampoErrato("Selezionare l'unit\u00E0 di misura");
			return false;
		}
		
		if (((String) cmbCodiciIva.getSelectedItem()).equalsIgnoreCase("")) {
			messaggioCampoErrato("Selezionare il Codice Iva.");
			return false;
		}

		// Preleviamo il codice unità di misura
		int pos = cmbMisura.getSelectedIndex();
		if (pos == 0)
			return false;
		// descrementiamo di uno perchè nel combobox è presente
		// anche un oggetto vuoto
		pos--;
		int cod = new Integer(codUnitaDiMisura[pos]);
		Um um = UmHome.getInstance().findById(cod);
		a.setUm(um);

		a.setDescrizione(txtDescrizione.getText());
		// controllo se è stato selezionato il
		// fornitore
//		if (((String) cmbFornitori.getSelectedItem()).equalsIgnoreCase("")) {
//			messaggioCampoErrato("Selezionare il fornitore");
//			return false;
//		}

		// Preleviamo il codice fornitore
//		pos = cmbFornitori.getSelectedIndex();
//		if (pos != 0){
//			// descrementiamo di uno perchè nel combobox è presente
//			// anche un oggetto vuoto
//			pos--;
//			cod = new Integer(codFornitori[pos]);
//			a.setFornitori(FornitoreHome.getInstance().findById(cod));
//		}

		// controllo se è stato selezionato il reparto
		if (((String) cmbReparto.getSelectedItem()).equalsIgnoreCase("")) {
			messaggioCampoErrato("Selezionare la categoria");
			return false;
		}

		// Preleviamo il codice unità di misura
		pos = cmbReparto.getSelectedIndex();
		if (pos == 0)
			return false;
		// descrementiamo di uno perchè nel combobox è presente
		// anche un oggetto vuoto
		pos--;
		cod = new Integer(codReparti[pos]);
		a.setReparto(RepartoHome.getInstance().findById(cod));
		
		// Preleviamo il codice del pannello
		if ( cmbPannelli.getSelectedIndex() > 0 ){
			cod = new Integer(codPannelli[(cmbPannelli.getSelectedIndex() - 1)]);
			a.setPannelli(PannelliHome.getInstance().findById(cod));
		}
		else {
			a.setPannelli(null);
		}
		
		CodiciIvaHome.getInstance().begin();		
		cod = new Integer(codCodiceIva[(cmbCodiciIva.getSelectedIndex() - 1)]);
		CodiciIva iva = CodiciIvaHome.getInstance().findById(cod);
		a.setCodiciIva(iva);

		try {
			if (txtPrezzoAcquisto.getText().equalsIgnoreCase("")) {
				a.setPrezzoAcquisto(0.00);
			} else {
				if (txtPrezzoAcquisto.getValue() instanceof Double) {
					a.setPrezzoAcquisto(((Double) txtPrezzoAcquisto.getValue())
							.doubleValue());
				} else {
					long value = ((Long) txtPrezzoAcquisto.getValue())
							.longValue();
					a.setPrezzoAcquisto(new Double(value).doubleValue());
				}
			}

			// a.setPrezzoDettaglio((ControlloDati.convertPrezzoToDouble(txtPrezzoDettaglio.getText())));
			if (txtPrezzoListino.getText().equalsIgnoreCase("")) {
				a.setPrezzoIngrosso(0.0);
			} else {
				if (txtPrezzoListino.getValue() instanceof Double) {
					a.setPrezzoIngrosso(((Double) txtPrezzoListino.getValue())
							.doubleValue());
				} else {
					long value = ((Long) txtPrezzoListino.getValue())
							.longValue();
					a.setPrezzoIngrosso(new Double(value).doubleValue());
				}
			}
			a.setPrezzoDettaglio(a.getPrezzoIngrosso());
		} catch (NumberFormatException e) {
			JOptionPane.showMessageDialog(this, "Numero malformato",
					"NUMERO ERRATO", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		} 

		a.setNote(txtNote.getText());
		a.setQtaInfinita(chkBoxQtaInfinita.isSelected());
		if ( imgArticolo != null ){
			if ( imgArticolo.getId() == 0 ){
				for ( ImmagineArticolo img : new ArrayList<ImmagineArticolo>(a.getImmagineArticolos()) ){
					ImmagineArticoloHome.getInstance().begin();
					ImmagineArticoloHome.getInstance().delete(img);
					ImmagineArticoloHome.getInstance().commit();
				}
				imgArticolo.setArticolo(a);
				imgArticolo.setId(dbm.getNewID("immagine_articolo", "id"));
				ImmagineArticoloHome.getInstance().begin();
				ImmagineArticoloHome.getInstance().persist(imgArticolo);
				a.getImmagineArticolos().add(imgArticolo);
			}
		}
		return true;

	}

	/**
	 *
	 */
	private void svuotaCampi() {
		Component[] component = pnlDatiPersonali.getComponents();
		for (int i = 0; i < component.length; i++) {
			if (component[i] instanceof JTextField) {
				JTextField tmp = (JTextField) component[i];
				tmp.setText("");
			} else if (component[i] instanceof JComboBox) {
				JComboBox tmp = (JComboBox) component[i];
				tmp.setSelectedIndex(0);
			}
		}
		txtNote.setText("");

	}

	/**
	 * @param string
	 */
	private void messaggioErroreCampo(String testo) {
		JOptionPane.showMessageDialog(this, testo, "ERRORE",
				JOptionPane.ERROR_MESSAGE);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see java.beans.PropertyChangeListener#propertyChange(java.beans.PropertyChangeEvent)
	 */

	public void propertyChange(PropertyChangeEvent e) {
		Object source = e.getSource();
		if (source == txtPrezzoListino) {
			calcoloPercentualeRicarico();
			calcolaPrezzoPubblico();
		} else if (source == txtRicaricoListino) {
			calcolaPrezzoListinoByPrezzoAcquisto();
			calcolaPrezzoPubblico();
		} else if (source == txtPrezzoFinale) {
			calcolaPrezzoListinoByPrezzoPubblico();
			calcoloPercentualeRicarico();
		} else if (source == txtPrezzoAcquisto) {
			calcoloPercentualeRicarico();
		}
	}

	/**
	 * This method initializes btnSuggerimento
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnSuggerimento() {
		if (btnSuggerimento == null) {
			try {
				btnSuggerimento = new JButton();
				btnSuggerimento.setBounds(new Rectangle(162, 28, 37, 21));  // Generated
				btnSuggerimento.setText(". . .");
				btnSuggerimento.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnSuggerimento;
	}

	/**
	 * This method initializes rbtnSi	
	 * 	
	 * @return javax.swing.JRadioButton	
	 */
	private JRadioButton getRbtnSi() {
		if (rbtnSi == null) {
			rbtnSi = new JRadioButton("Si");
			rbtnSi.setBounds(new Rectangle(392, 28, 21, 21));
			rbtnSi.addActionListener(new MyActionListener());
		}
		return rbtnSi;
	}

	/**
	 * This method initializes rbtnNo	
	 * 	
	 * @return javax.swing.JRadioButton	
	 */
	private JRadioButton getRbtnNo() {
		if (rbtnNo == null) {
			rbtnNo = new JRadioButton();
			rbtnNo.setBounds(new Rectangle(452, 28, 21, 21));
			rbtnNo.addActionListener(new MyActionListener());
		}
		return rbtnNo;
	}

	/**
	 * This method initializes cmbPannelli	
	 * 	
	 * @return javax.swing.JComboBox	
	 */
	private JComboBox getCmbPannelli() {
		if (cmbPannelli == null) {
			cmbPannelli = new JComboBox();
			cmbPannelli.setBounds(new Rectangle(7, 246, 169, 25));
		}
		return cmbPannelli;
	}

	/**
	 * This method initializes btnNewPannello	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnNewPannello() {
		if (btnNewPannello == null) {
			btnNewPannello = new JButton();
			btnNewPannello.setBounds(new Rectangle(192, 245, 75, 29));
			btnNewPannello.setText("Nuovo");
			btnNewPannello.addActionListener(new MyActionListener());
		}
		return btnNewPannello;
	}

	/**
	 * This method initializes chkBoxQtaInfinita	
	 * 	
	 * @return javax.swing.JCheckBox	
	 */
	private JCheckBox getChkBoxQtaInfinita() {
		if (chkBoxQtaInfinita == null) {
			chkBoxQtaInfinita = new JCheckBox();
			chkBoxQtaInfinita.setBounds(new Rectangle(287, 151, 28, 23));
		}
		return chkBoxQtaInfinita;
	}

	/**
	 * This method initializes pnlImage	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getPnlImage() {
		if (pnlImage == null) {
			lbl1 = new JLabel();
			lbl1.setBounds(new Rectangle(0, 0, 80, 80));
			pnlImage = new JPanel();
			pnlImage.setLayout(null);
			pnlImage.setBounds(new Rectangle(402, 251, 200, 80));
			pnlImage.setBorder(BorderFactory.createTitledBorder(
					BorderFactory.createBevelBorder(BevelBorder.RAISED),
					"Immagine",
					TitledBorder.DEFAULT_JUSTIFICATION,
					TitledBorder.DEFAULT_POSITION, new Font("Dialog",
							Font.BOLD, 12), new Color(51, 51, 51))); // Generated
			if ( imgArticolo != null ){
				lbl1.setIcon(new ImageIcon(imgArticolo.getFile()));
			}
			lbl1.setVerticalAlignment(0);
			lbl1.setHorizontalAlignment(0);
			pnlImage.add(lbl1, null);
			pnlImage.add(getBtnAddImage(), null);
			pnlImage.add(getBtnRemoveImage(), null);
		}
		return pnlImage;
	}

	/**
	 * This method initializes btnAddImage	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnAddImage() {
		if (btnAddImage == null) {
			btnAddImage = new JButton();
			btnAddImage.setBounds(new Rectangle(90, 12, 90, 29));
			btnAddImage.setText("Aggiungi");
			btnAddImage.addActionListener(new MyActionListener());
		}
		return btnAddImage;
	}

	/**
	 * This method initializes btnRemoveImage	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnRemoveImage() {
		if (btnRemoveImage == null) {
			btnRemoveImage = new JButton();
			btnRemoveImage.setBounds(new Rectangle(90, 45, 90, 29));
			btnRemoveImage.setText("Rimuovi");
			btnRemoveImage.addActionListener(new MyActionListener());
		}
		return btnRemoveImage;
	}

	/**
	 * This method initializes pnlBarcode	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getPnlBarcode() {
		if (pnlBarcode == null) {
			pnlBarcode = new JPanel();
			pnlBarcode.setLayout(new BorderLayout());
			pnlBarcode.setBounds(new Rectangle(484, 8, 246, 85));
		}
		return pnlBarcode;
	}

	@Override
	public void windowActivated(WindowEvent arg0) {
		
	}

	@Override
	public void windowClosed(WindowEvent arg0) {
		
	}

	@Override
	public void windowClosing(WindowEvent arg0) {
		
	}

	@Override
	public void windowDeactivated(WindowEvent arg0) {
		
	}

	@Override
	public void windowDeiconified(WindowEvent arg0) {
		
	}

	@Override
	public void windowIconified(WindowEvent arg0) {
		
	}

	@Override
	public void windowOpened(WindowEvent arg0) {
		// portiamo il focus sul cosice a barre
		txtCodBarre.requestFocusInWindow();
		// se l'articolo ha il codice a barre creiamo l'immagine dello stesso a video
		if(txtCodBarre.getText()!=null && !txtCodBarre.getText().equalsIgnoreCase("")){
			// Always get a Barcode from the BarcodeFactory
	        barcode = null;
	        try {
	            barcode = BarcodeFactory.createCode128(txtCodBarre.getText());
	        } catch (BarcodeException e) {
	            // Error handling
	        }

	        /* Because Barcode extends Component, you can use it just like any other
			 * Swing component. In this case, we can add it straight into a panel
			 * and it will be drawn and layed out according to the layout of the panel.
			 */
			pnlBarcode.add(barcode,BorderLayout.CENTER);
	        //pnlBarcode.add(barcode);
			pnlBarcode.repaint();
		}
		
	}

	/**
	 * This method initializes btnStampaCodBarre	
	 * 	
	 * @return javax.swing.JButton	
	 */
	private JButton getBtnStampaCodBarre() {
		if (btnStampaCodBarre == null) {
			btnStampaCodBarre = new JButton();
			btnStampaCodBarre.setBounds(new Rectangle(485, 96, 245, 37));
			btnStampaCodBarre.setText("Stampa Codice a Barre");
			btnStampaCodBarre.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					stampaCodiceBarre();
				}
			});
		}
		return btnStampaCodBarre;
	}

	protected void stampaCodiceBarre() {
		
	}

	/**
	 * This method initializes cmbCodiciIva	
	 * 	
	 * @return javax.swing.JComboBox	
	 */
	private JComboBox getCmbCodiciIva() {
		if (cmbCodiciIva == null) {
			cmbCodiciIva = new JComboBox();
			cmbCodiciIva.setBounds(new Rectangle(147, 111, 80, 20));
			cmbCodiciIva.addItemListener(new java.awt.event.ItemListener() {
				public void itemStateChanged(java.awt.event.ItemEvent e) {
					calcoloPercentualeRicarico();
					calcolaPrezzoPubblico();
				}
			});
		}
		return cmbCodiciIva;
	}

}