package rf.pegaso.gui.gestione;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Vector;

import javax.swing.AbstractAction;
import javax.swing.BorderFactory;
import javax.swing.ButtonGroup;
import javax.swing.InputMap;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JFormattedTextField;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.KeyStroke;
import javax.swing.SwingConstants;
import javax.swing.WindowConstants;
import javax.swing.border.BevelBorder;
import javax.swing.border.TitledBorder;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;
import javax.swing.text.JTextComponent;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.view.JasperViewer;

import org.jdesktop.swingx.JXTable;
import org.jdesktop.swingx.decorator.AlternateRowHighlighter;

import rf.myswing.IDJComboBox;
import rf.myswing.util.DoubleEditor;
import rf.pegaso.db.exception.CodiceBarreInesistente;
import rf.pegaso.db.exception.ResultSetVuoto;
import rf.pegaso.db.model.CarichiViewModel;
import rf.pegaso.db.model.CaricoModel;
import rf.pegaso.db.model.DdtCaricoModel;
import rf.pegaso.db.model.DdtFatturaModel;
import rf.pegaso.db.tabelle.Articolo;
import rf.pegaso.db.tabelle.Carico;
import rf.pegaso.db.tabelle.Documento;
import rf.pegaso.db.tabelle.Fornitore;
import rf.pegaso.db.tabelle.UnitaDiMisura;
import rf.pegaso.db.tabelle.exception.NumeroCaricoEsistente;
import rf.pegaso.gui.utility.ModificaQuantitaRiga;
import rf.utility.Constant;
import rf.utility.ControlloDati;
import rf.utility.db.DBManager;
import rf.utility.db.UtilityDBManager;
import rf.utility.db.eccezzioni.CodiceBarreEsistente;
import rf.utility.db.eccezzioni.IDNonValido;
import rf.utility.gui.SospesiColorRenderer;
import rf.utility.gui.UtilGUI;
import rf.utility.gui.text.AutoCompleteTextComponent;
import rf.utility.gui.text.AutoCompletion;
import rf.utility.gui.text.UpperAutoCompleteDocument;
import rf.utility.gui.text.UpperTextDocument;

import com.sun.org.apache.xerces.internal.impl.xs.models.CMBuilder;
import com.toedter.calendar.JDateChooser;
import com.toedter.calendar.JTextFieldDateEditor;

// Referenced classes of package rf.pegaso.gui.gestione:
//            ArticoliAddMod, ArticoliGestione

public class CaricoGui extends JFrame implements TableModelListener {
	class MyButtonListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource() == btnInserisci)
				inserisci();
			else if (e.getSource() == btnElimina)
				eliminaArticolo();
			else if (e.getSource() == btnChiudi)
				dispose();
			else if (e.getSource() == btnModifica)
				modifica();
			else if (e.getSource() == btnEliminaCarico)
				eliminaCarico();
			else if (e.getSource() == btnAzzera)
				azzeraTuttiCampi();
			else if (e.getSource() == btnStampa)
				stampaTuttiCarichi();
		}

	}
	
	class MyMouseAdapter extends MouseAdapter{

		@Override
		public void mouseClicked(MouseEvent e) {
			if(e.getSource()==tblViewCarichi && e.getClickCount()==2){
				modifica();
			}
		}
		
	}

	class MyComboBoxListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource() == cmbFornitori) {
				// int idfornitore =
				// ComboBoxUtil.estraiCodice((String)cmbFornitori.getSelectedItem());
				int idfornitore = new Integer(cmbFornitori.getIDSelectedItem())
						.intValue();
				caricaArticoliByIdFornitore(idfornitore);
				azzeraTesto();
			} else if (e.getSource() == cmbProdotti) {
				if (cmbProdotti.getIDSelectedItem() != null) {
					int id = new Integer(cmbProdotti.getIDSelectedItem())
							.intValue();
					caricaArticoloByID(id);
				}

			}
		}

	}

	private MyMouseAdapter myMouseadapter;

	public CaricoGui(Frame frame) {
		btnAzzera = null;
		btnChiudi = null;
		btnElimina = null;
		btnEliminaCarico = null;
		btnInserisci = null;
		btnModifica = null;
		carichiView = null;
		caricoModel = null;
		chkInsRapido = null;
		cmbFornitori = null;
		cmbProdotti = null;
		cmbTipoDocumento = null;
		idcarico = 0;
		jContentPane = null;
		jScrollPane = null;
		jScrollPane1 = null;
		jScrollPane2 = null;
		lblCodBarre = null;
		lblDataCarico = null;
		lblDescrizioneProdotto = null;
		lblFornitore = null;
		lblInsRapido = null;
		lblNote = null;
		lblNumDocumento = null;
		lblNumeroCarico = null;
		lblPrezzo = null;
		lblQta = null;
		lblTipoDocumento = null;
		lblUm = null;
		pnlCentrale = null;
		pnlNord = null;
		pnlProdotto = null;
		pnlSud = null;
		pnlViewCarichi = null;
		tblCarico = null;
		tblViewCarichi = null;
		tbp = null;
		txtCodBarre = null;
		dataDocumento = null;
		txtNote = null;
		txtNumDocumento = null;
		txtNumeroCarico = null;
		txtPrezzo = null;
		txtQta = null;
		cmbMisura = null;
		lblDataDocumento = null;
		btnNewArticolo = null;
		dataCarico = null;
		btnStampa = null;
		btnVisualizzaArt = null;
		pnlNord1 = null;
		pnlCentro = null;
		padre = frame;
		dbm = DBManager.getIstanceSingleton();
		initialize();
	}

	private void salvaFattura() {
		String doc = cmbTipoDocumento.getSelectedItem().toString();
		if (doc.equalsIgnoreCase("")) {
			messaggioCampoMancante("Tipo di documento non selezionato");
			return;
		}
		if (txtNumDocumento.getText().equalsIgnoreCase("")) {
			messaggioCampoMancante("Numero documento non inserito");
			return;
		}
		Carico c = new Carico();
		try {
			c.setIdCarico((new Integer(txtNumeroCarico.getText())).intValue());
			c.setIdFornitore((new Integer(cmbFornitori.getIDSelectedItem()))
					.intValue());
			c.setDataCarico(new Date(dataCarico.getDate().getTime()));
			c.setDataDocumento(new Date(dataDocumento.getDate().getTime()));
			c.setNumDocumento(txtNumDocumento.getText());
			c
					.setIdDocumento((new Integer(cmbTipoDocumento
							.getIDSelectedItem())).intValue());
			c.setOraCarico(new Time((new java.util.Date()).getTime()));
			c.setNote(txtNote.getText());


			c.setSconto(((Number) txtSconto.getValue()).intValue());
			double tot = Carico
					.getTotAcquistoImponibileByOrder(c.getIdCarico())
					+ Carico.getTotAcquistoImpostaByOrder(c.getIdCarico());
			int sconto = c.getSconto();
			if (sconto > 0) {
				tot -= (tot / 100 * sconto);
			}
			c.setTotaleDocumentoIvato(tot);
			if (rbtnNo.isSelected())
				c.setSospeso(0);
			else
				c.setSospeso(1);
			if (!c
					.isInsert((new Integer(txtNumeroCarico.getText()))
							.intValue()))
				c.insertCarico();
			else
				try {
					c.updateCarico();
				} catch (IDNonValido e) {
					e.printStackTrace();
				}
		} catch (Exception exception) {
		}
	}

	public void modificaArticolo() {
		if (tblCarico.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", 1);
			return;
		}
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler\nmodificare i dati Articolo?", "AVVISO",
				0, 1);
		if (scelta != JOptionPane.YES_OPTION)
			return;

		// PUNTO DI BACKUP DA ATTIVARE DA CONFIGURAZIONI
		try {
			UtilityDBManager.getSingleInstance().backupDataBase(
					UtilityDBManager.UPDATE);
		} catch (FileNotFoundException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		} catch (IOException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		}
		// FINE PUNTO BACKUP

		int riga = tblCarico.getSelectedRow();
		String codbarre = (String) tblCarico.getValueAt(riga, 0);
		int id = -1;
		try {
			id = Articolo.idByCodiceBarre(codbarre);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, e.getMessage(), "ERRORE", 0);
			e.printStackTrace();
		}
		if (id == -1) {
			JOptionPane.showMessageDialog(this, "Codice a barre non trovato",
					"RICERCA FALLITA", 1);
			return;
		}
		ArticoloAddMod a = new ArticoloAddMod(this, id, 1);
		a.setVisible(true);
		double prezzo = 0.0D;
		try {
			prezzo = Articolo.prezzoAcquistoByID(id);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, e.getMessage(), "ERRORE", 0);
			e.printStackTrace();
		}
		Carico c = new Carico();
		idcarico = (new Integer(txtNumeroCarico.getText())).intValue();
		try {
			c.caricaDati(idcarico);
			c.updateArticolo(id, c.getQuantitaCaricata(id), prezzo);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, e.getMessage(), "ERRORE", 0);
			e.printStackTrace();
		} catch (IDNonValido e) {
			e.printStackTrace();
		} catch (ResultSetVuoto e) {
			e.printStackTrace();
		}
		ricaricaTableCarico(idcarico);
	}

	protected void stampaTuttiCarichi() {
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler stampare l'elenco carichi?", "AVVISO", 0,
				3);
		if (scelta != JOptionPane.YES_OPTION)
			return;
		try {
			JasperViewer.viewReport(
					JasperFillManager.fillReport(
							"report/elenco_carichi.jasper", null, dbm
									.getConnessione()), false);
		} catch (JRException e) {
			e.printStackTrace();
		}
	}

	protected void modificaRiga() {
		if (tblCarico.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", 1);
			return;
		}
		int riga = tblCarico.getSelectedRow();
		String codBarre = (String) tblCarico.getValueAt(riga, 0);
		double n = ((Double) tblCarico.getValueAt(riga, 4)).doubleValue();
		double qta[] = new double[1];
		qta[0] = n;
		ModificaQuantitaRiga mod = new ModificaQuantitaRiga(qta, this);
		mod.setVisible(true);

		// PUNTO DI BACKUP DA ATTIVARE DA CONFIGURAZIONI
		try {
			UtilityDBManager.getSingleInstance().backupDataBase(
					UtilityDBManager.UPDATE);
		} catch (FileNotFoundException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		} catch (IOException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		}
		// FINE PUNTO BACKUP

		Articolo a = new Articolo();
		try {
			a.caricaDatiByCodBarre(codBarre);
			Carico c = new Carico();
			c.caricaDati((new Integer(txtNumeroCarico.getText())).intValue());
			String o = (String) tblCarico.getValueAt(riga, 5);
			Double d = new Double(0.0D);
			try {
				o = ControlloDati.eliminaPunti(o);
				o = ControlloDati.sostituisciVirgola(o);
				d = new Double(o);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
			double prezzo = d.doubleValue();
			c.updateArticolo(a.getIdArticolo(), qta[0], prezzo);
			calcoli(c);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IDNonValido e) {
			e.printStackTrace();
		}
	}

	public void erroreCaricamentoDatiDB() {
		JOptionPane.showMessageDialog(this, "Errore caricamento dati db",
				"ERRORE", 0);
	}

	private void avvisoCodBarreInesistente() {
		JOptionPane.showMessageDialog(this,
				"Codice barre articolo inesistente", "Codice inesistente", 1);
	}

	private void azzeraCampi() {
		txtCodBarre.setText("");
		cmbMisura.setSelectedIndex(0);
		txtQta.setValue(0.0);
		txtPrezzo.setValue(0.0);
		cmbProdotti.setSelectedIndex(0);
//		cmbFornitori.setSelectedIndex(0);
		txtNote.setText("");

	}

	private void azzeraTesto() {
		txtCodBarre.setText("");
		cmbMisura.setSelectedIndex(0);
		txtQta.setValue(new Double(0.0));
		txtPrezzo.setText("");
		txtNote.setText("");
	}

	private void azzeraTuttiCampi() {
		Carico c = new Carico();
		idcarico = c.getNewID();
		txtNumeroCarico.setText((new Integer(idcarico)).toString());
		dataCarico.setDate(new java.util.Date());
		txtNumDocumento.setText("");
		cmbTipoDocumento.setSelectedIndex(0);
		ricaricaTableCarico(idcarico);
		cmbFornitori.setSelectedIndex(0);
		azzeraCampi();
	}

	private void caricaArticoli(JComboBox cmbProdotti) {
		cmbProdotti.removeAllItems();
		Articolo f = new Articolo();
		try {
			String as[] = (String[]) f.allArticoli();
			// carichiamo tutti i dati in due array
			// da passre al combobox
			((IDJComboBox) cmbProdotti).caricaNewValueComboBox(as, true);

		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento articolo nel combobox", "ERRORE", 0);
			e.printStackTrace();
		}
		// per abilitare autocompletamento
		AutoCompletion.enable(cmbProdotti);
	}

	private void caricaArticoliByIdFornitore(int idfornitore) {
		// Articolo f = new Articolo();
		// cmbProdotti.removeAllItems();
		// cmbProdotti.addItem("");
		// String tmpArticoli[] = null;
		// String tmpCodici[] = null;
		// try {
		// String as[] = f.allArticoliByFornitore(idfornitore);
		// tmpArticoli = new String[as.length];
		// tmpCodici = new String[as.length];
		// // carichiamo tutti i dati in due array
		// // da passre al combobox
		// for (int i = 0; i < as.length; i++) {
		// String tmp[] = as[i].split("-",2);
		// tmpArticoli[i] = tmp[1].trim();
		// tmpCodici[i] = tmp[0].trim();
		// }
		// ((IDJComboBox) cmbProdotti).caricaIDAndOggetti(tmpCodici,
		// tmpArticoli);
		//
		// } catch (SQLException e) {
		// JOptionPane.showMessageDialog(this,
		// "Errore caricamento articoli nel combobox", "ERRORE", 0);
		// e.printStackTrace();
		// } catch (LunghezzeArrayDiverse e) {
		// JOptionPane.showMessageDialog(this, "Errore lunghezza array",
		// "ERRORE LUNGHEZZA", 0);
		// e.printStackTrace();
		// }

		Articolo f = new Articolo();
		try {
			String as[] = f.allArticoliByFornitore(idfornitore);
			// carichiamo tutti i dati in due array
			// da passre al combobox
			((IDJComboBox) cmbProdotti).caricaNewValueComboBox(as, true);

		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento articoli nel combobox", "ERRORE", 0);
			e.printStackTrace();
		}
		AutoCompletion.enable(cmbProdotti);
	}

	private void caricaArticoloByCodBarre() {
		String codBarre = txtCodBarre.getText();
		if (codBarre.equalsIgnoreCase(""))
			return;
		Articolo a = new Articolo();
		try {
			if (a.findByCodBarre(codBarre)) {
				Fornitore f = new Fornitore();
				f.caricaDati(a.getIdFornitore());
				// non avviene più la selezione del fornitore
				// in quanto non più in relazione diretta con
				// l'articolo ma solo attraverso il carico.
//				cmbFornitori.setSelectedItem(f.getNome());
				cmbProdotti.setSelectedItem(a.getDescrizione());
				cmbMisura.setSelectedIndex(a.getUm());
				txtQta.setValue((new Double(1.0)));
				txtPrezzo.setValue(new Double(a.getPrezzoAcquisto()));
				txtCodBarre.setText(codBarre);
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (CodiceBarreInesistente e1) {
			avvisoCodBarreInesistente();
			e1.printStackTrace();
		}
	}

	public void tableChanged(TableModelEvent arg0) {
		// TODO Auto-generated method stub

		Carico c = new Carico();
		try {
			c.caricaDati(new Integer(txtNumeroCarico.getText()).intValue());
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		calcoli(c);

	}

	private void caricaDati(Carico c) {
		txtNumeroCarico.setText((new Integer(c.getIdCarico())).toString());
		dataCarico.setDate(c.getDataCarico());
		txtNumDocumento.setText(c.getNumDocumento());
		dataDocumento.setDate(c.getDataDocumento());
		txtNote.setText(c.getNote());
		Documento d = new Documento();
		Fornitore f = new Fornitore();
		try {
			d.caricaDati(c.getIdDocumento());
			f.caricaDati(c.getIdFornitore());
		} catch (SQLException e) {
			messaggioErroreCampo("Errore caricamento dati db");
			e.printStackTrace();
		}

		cmbTipoDocumento.setSelectedItem(d.getDescrizione());
		// cmbFornitori.setSelectedItem(f.getNome());
		cmbFornitori.setSelectedItemByID(f.getIdFornitore());
		int sosp = c.getSospeso();
		if (sosp == 0)
			rbtnNo.setSelected(true);
		else
			rbtnSi.setSelected(true);
		txtSconto.setValue(c.getSconto());
		ricaricaTableCarico(c.getIdCarico());
		tbp.setSelectedIndex(0);
		calcoli(c);
	}

	private void caricaDatiArticolo() {
		int idarticolo = new Integer(cmbProdotti.getIDSelectedItem());
		Articolo a = new Articolo();
		try {
			a.caricaDati(idarticolo);
			txtCodBarre.setText(a.getCodBarre());
			cmbMisura.setSelectedIndex(a.getUm());
			txtQta.setValue((new Double(1.0)));
			txtPrezzo.setValue(new Double(a.getPrezzoAcquisto()));
		} catch (SQLException e1) {
			erroreCaricamentoDatiDB();
			e1.printStackTrace();
		}
	}

	private void caricaDocumenti(JComboBox cmbDocumenti) {

		Documento f = new Documento();
		try {

			String as[] = (String[]) f.allDocumentiConDescrizione();
			// carichiamo tutti i dati in due array
			// da passre al combobox
			((IDJComboBox) cmbDocumenti).caricaNewValueComboBox(as, true);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento documenti nel combobox", "ERRORE", 0);
			e.printStackTrace();
		}
		AutoCompletion.enable(cmbDocumenti);
	}

	private void caricaFornitori(JComboBox cmbFornitori) {
		cmbFornitori.removeAllItems();
		Fornitore f = new Fornitore();
		try {

			String as[] = (String[]) f.allFornitori();
			// carichiamo tutti i dati in due array
			// da passre al combobox
			((IDJComboBox) cmbFornitori).caricaNewValueComboBox(as, true);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento fornitori nel combobox", "ERRORE", 0);
			e.printStackTrace();
		}
		AutoCompletion.enable(cmbFornitori);
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
//		Articolo a = new Articolo();
//		try {
//			a.caricaDati(idArticolo);
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		cmbMisura.setSelectedIndex(a.getUm());

	}

	private void controlloAggPrezzo() {
		Articolo a = new Articolo();
		try {
			try {
				a.caricaDatiByCodBarre(txtCodBarre.getText());
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (IDNonValido e) {
			JOptionPane.showMessageDialog(this, "Id non valido", "AVVISO", 1);
			e.printStackTrace();
		}
		double pNuovo = 0.0D;
		if (txtPrezzo.getValue() instanceof Long)
			pNuovo = ((Long) txtPrezzo.getValue()).longValue();
		else
			pNuovo = ((Double) txtPrezzo.getValue()).doubleValue();
		if (!prezzoUguale(pNuovo, a.getIdArticolo())) {
			int scelta = JOptionPane
					.showConfirmDialog(
							this,
							"Vuoi aggiornare il prezzo del prodotto\ncon il prezzo corrente di acquisto?",
							"AVVISO DI AGGIORNAMENTO", 0);
			if (scelta == JOptionPane.YES_OPTION) {
				try {
					a.setPrezzoAcquisto(pNuovo);
				} catch (NumberFormatException e) {
					JOptionPane.showMessageDialog(this, "Numero malformato",
							"NUMERO ERRATO", 0);
					e.printStackTrace();
				}
				try {
					a.updateArticolo();
				} catch (IDNonValido e) {
					e.printStackTrace();
				} catch (CodiceBarreEsistente e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void eliminaArticolo() {
		if (tblCarico.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", 1);
			return;
		}
		if (tblCarico.getSelectedRow() <= -1) {
			int ok = JOptionPane.showConfirmDialog(this,
					"Sei sicuro si voler eliminare?", "AVVISO", 0, 1);
			if (ok != JOptionPane.YES_OPTION)
				return;
		}

		// PUNTO DI BACKUP DA ATTIVARE DA CONFIGURAZIONI
		try {
			UtilityDBManager.getSingleInstance().backupDataBase(
					UtilityDBManager.DELETE);
		} catch (FileNotFoundException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		} catch (IOException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		}
		// FINE PUNTO BACKUP

		int riga = tblCarico.getSelectedRow();
		TableColumn col = tblCarico.getColumn("codice");
		int colonna = col.getModelIndex();
		String codBarre = (String) tblCarico.getValueAt(riga, colonna);
		Articolo a = new Articolo();
		try {
			a.caricaDatiByCodBarre(codBarre);
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (IDNonValido e1) {
			e1.printStackTrace();
		}
		Carico c = new Carico();
		c.setIdCarico((new Integer(txtNumeroCarico.getText())).intValue());
		try {
			c.deleteArticolo(a.getIdArticolo());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		calcoli(c);
	}

	private void eliminaCarico() {
		if (tblViewCarichi.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", 1);
			return;
		}
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler\neliminare il carico selezionato?",
				"AVVISO", 0, 1);
		if (scelta == JOptionPane.NO_OPTION
				|| scelta == JOptionPane.CANCEL_OPTION
				|| scelta == JOptionPane.CLOSED_OPTION)
			return;
		// PUNTO DI BACKUP DA ATTIVARE DA CONFIGURAZIONI
		try {
			UtilityDBManager.getSingleInstance().backupDataBase(
					UtilityDBManager.DELETE);
		} catch (FileNotFoundException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		} catch (IOException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		}
		// FINE PUNTO BACKUP

		int riga = tblViewCarichi.getSelectedRow();
		int idcarico = ((Long) tblViewCarichi.getValueAt(riga, 0)).intValue();
		Carico c = new Carico();
		try {
			c.caricaDati(idcarico);
			int rifdoc = c.getRiferimentoDoc();
			int doc = c.getIdDocumento();
			// in caso il doc è un ddt ed ha un riferimanto ad una
			// fattura facciamo un update degli articoli impostando
			// nel dettaglio carico il codce da quello del ddt
			// a quello della fattura
			if (rifdoc != -1 && (doc == 2 || doc == 1)) {
				c.moveCaricoToRiferimentoDoc();
			}

			// dopo gli aggiornamenti cancelliamo il tutto
			c.deleteAllArticoliCaricati();
			c.deleteCarico(idcarico);

			// se il doc eliminato è una fattura quindi 1 lo eliminiamo ma
			// reimpostiamo
			// il ddt come senza fattura.
			if (rifdoc != -1 && doc == 1) {
				c = new Carico();
				c.caricaDati(rifdoc);
				c.setRiferimentoDoc(-1);
				if (c.getIdDocumento() == 2)
					c.updateCarico();

			}
		} catch (IDNonValido e) {
			JOptionPane.showMessageDialog(this, "Valore idCliente errato",
					"ERRORE", 2);
			e.printStackTrace();
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, "Errore nel db", "ERRORE", 2);
			e.printStackTrace();
		}
	}

	private JButton getBtnAzzera() {
		if (btnAzzera == null)
			try {
				btnAzzera = new JButton();
				btnAzzera.setBounds(new Rectangle(725, 45, 103, 29));
				btnAzzera.setText("Azzera (F1)");
				btnAzzera.addActionListener(new MyButtonListener());
			} catch (Throwable throwable) {
			}
		return btnAzzera;
	}

	private JButton getBtnChiudi() {
		if (btnChiudi == null)
			try {
				btnChiudi = new JButton();
				btnChiudi.setBounds(new Rectangle(725, 10, 104, 29));
				btnChiudi.setText("Chiudi (ESC)");
			} catch (Throwable throwable) {
			}
		return btnChiudi;
	}

	private JButton getBtnElimina() {
		if (btnElimina == null)
			try {
				btnElimina = new JButton();
				btnElimina.setBounds(new Rectangle(495, 155, 126, 26));
				btnElimina.setText("Elimina Art. (F5)");
				btnElimina.addActionListener(myButtonListener);
			} catch (Throwable throwable) {
			}
		return btnElimina;
	}

	private JButton getBtnEliminaCarico() {
		if (btnEliminaCarico == null)
			try {
				btnEliminaCarico = new JButton();
				btnEliminaCarico.setText("Elimina");
				btnEliminaCarico.addActionListener(new MyButtonListener());
			} catch (Throwable throwable) {
			}
		return btnEliminaCarico;
	}

	private JButton getBtnInserisci() {
		if (btnInserisci == null)
			try {
				btnInserisci = new JButton();
				btnInserisci.setBounds(new Rectangle(370, 125, 121, 26));
				btnInserisci.setText("Inserisci (F2)");
			} catch (Throwable throwable) {
			}
		return btnInserisci;
	}

	private JButton getBtnModifica() {
		if (btnModifica == null)
			try {
				btnModifica = new JButton();
				btnModifica.setText("Modifica");
				btnModifica.addActionListener(new MyButtonListener());
			} catch (Throwable throwable) {
			}
		return btnModifica;
	}

	private JCheckBox getChkInsRapido() {
		if (chkInsRapido == null)
			try {
				chkInsRapido = new JCheckBox();
				chkInsRapido.setBounds(new Rectangle(222, 106, 18, 19));
			} catch (Throwable throwable) {
			}
		return chkInsRapido;
	}

	private JComboBox getCmbFornitori() {
		if (cmbFornitori == null)
			try {
				cmbFornitori = new IDJComboBox();
				cmbFornitori.setBounds(new Rectangle(68, 108, 436, 25));
			} catch (Throwable throwable) {
			}
		return cmbFornitori;
	}

	private IDJComboBox getCmbProdotti() {
		if (cmbProdotti == null)
			try {
				cmbProdotti = new IDJComboBox();
				cmbProdotti.setBounds(new Rectangle(148, 40, 473, 21));

			} catch (Throwable throwable) {
			}
		return cmbProdotti;
	}

	protected void caricaArticoloByID(int id) {
		// TODO Auto-generated method stub
		Articolo a = new Articolo();

		try {
			a.caricaDati(id);
			Fornitore f = new Fornitore();
			f.caricaDati(a.getIdFornitore());
//			cmbFornitori.setSelectedItem(f.getNome());
			cmbMisura.setSelectedIndex(a.getUm());
			txtQta.setValue((new Double(1.0)));
			txtPrezzo.setValue(new Double(a.getPrezzoAcquisto()));
			txtCodBarre.setText(a.getCodBarre());

		} catch (SQLException e1) {
			e1.printStackTrace();
		}
	}

	private IDJComboBox getCmbTipoDocumento() {
		if (cmbTipoDocumento == null)
			try {
				cmbTipoDocumento = new IDJComboBox();
				cmbTipoDocumento.setBounds(new Rectangle(108, 48, 313, 25));
			} catch (Throwable throwable) {
			}
		return cmbTipoDocumento;
	}

	private JPanel getJContentPane() {
		if (jContentPane == null) {
			jContentPane = new JPanel();
			jContentPane.setLayout(new BorderLayout());
			jContentPane.add(getTbp(), "Center");
		}
		return jContentPane;
	}

	private JScrollPane getJScrollPane() {
		if (jScrollPane == null)
			try {
				jScrollPane = new JScrollPane();
				jScrollPane.setPreferredSize(new Dimension(453, 130));
				jScrollPane.setHorizontalScrollBarPolicy(30);
				jScrollPane.setViewportView(getTblCarico());
			} catch (Throwable throwable) {
			}
		return jScrollPane;
	}

	private JScrollPane getJScrollPane1() {
		if (jScrollPane1 == null)
			try {
				jScrollPane1 = new JScrollPane();
				jScrollPane1.setBounds(new Rectangle(8, 128, 356, 56));
				jScrollPane1.setViewportView(getTxtNote());
			} catch (Throwable throwable) {
			}
		return jScrollPane1;
	}

	private JScrollPane getJScrollPane2() {
		if (jScrollPane2 == null)
			try {
				jScrollPane2 = new JScrollPane();
				jScrollPane2.setViewportView(getTblViewCarichi());
			} catch (Throwable throwable) {
			}
		return jScrollPane2;
	}

	private JPanel getPnlCentrale() {
		if (pnlCentrale == null)
			try {
				pnlCentrale = new JPanel();
				pnlCentrale.setLayout(new BorderLayout());
				pnlCentrale.add(getPnlNord(), "North");
				pnlCentrale.add(getPnlSud(), "Center");
			} catch (Throwable throwable) {
			}
		return pnlCentrale;
	}

	private JPanel getPnlNord() {
		if (pnlNord == null)
			try {
				lblDataDocumento = new JLabel();
				lblDataDocumento.setBounds(new Rectangle(200, 80, 101, 25));
				lblDataDocumento.setText("Data Documento");
				lblNumDocumento = new JLabel();
				lblNumDocumento.setBounds(new Rectangle(8, 80, 89, 25));
				lblNumDocumento.setText("N. Documento");
				lblFornitore = new JLabel();
				lblFornitore.setBounds(new Rectangle(8, 108, 57, 25));
				lblFornitore.setText("Fornitore");
				lblDataCarico = new JLabel();
				lblDataCarico.setBounds(new Rectangle(145, 20, 69, 25));
				lblDataCarico.setText("Data Carico");
				lblNumeroCarico = new JLabel();
				lblNumeroCarico.setBounds(new Rectangle(9, 20, 57, 25));
				lblNumeroCarico.setText("N\260 Carico");
				pnlNord = new JPanel();
				pnlNord.setLayout(null);
				pnlNord.setPreferredSize(new Dimension(1, 340));
				pnlNord.add(lblNumeroCarico, null);
				pnlNord.add(getTxtNumeroCarico(), null);
				pnlNord.add(lblDataCarico, null);
				pnlNord.add(lblFornitore, null);
				pnlNord.add(getCmbFornitori(), null);
				pnlNord.add(getPnlProdotto(), null);
				pnlNord.add(getBtnChiudi(), null);
				pnlNord.add(lblTipoDocumento, null);
				pnlNord.add(getCmbTipoDocumento(), null);
				pnlNord.add(lblNumDocumento, null);
				pnlNord.add(getTxtNumDocumento(), null);
				pnlNord.add(getBtnAzzera(), null);
				pnlNord.add(getDateChooserDocumento(), null);
				pnlNord.add(lblDataDocumento, null);
				pnlNord.add(getDataCarico(), null);
				pnlNord.add(getBtnNuovoForn(), null);
				pnlNord.add(getJPanel1(), null);
				pnlNord.add(getPnlSconto(), null);
			} catch (Throwable throwable) {
			}
		return pnlNord;
	}

	private JPanel getPnlProdotto() {
		if (pnlProdotto == null)
			try {
				lblTipoDocumento = new JLabel();
				lblTipoDocumento.setText("Tipo Documento");
				lblTipoDocumento.setBounds(new Rectangle(8, 48, 97, 25));
				lblTipoDocumento.setHorizontalAlignment(2);
				lblInsRapido = new JLabel();
				lblInsRapido.setBounds(new Rectangle(243, 103, 121, 21));
				lblInsRapido.setText("Inserimento Rapido");
				lblNote = new JLabel();
				lblNote.setBounds(new Rectangle(8, 108, 111, 20));
				lblNote.setText("Note");
				lblPrezzo = new JLabel();
				lblPrezzo.setBounds(new Rectangle(153, 65, 74, 16));
				lblPrezzo.setHorizontalAlignment(0);
				lblPrezzo.setText("Prezzo");
				lblQta = new JLabel();
				lblQta.setBounds(new Rectangle(88, 65, 60, 16));
				lblQta.setHorizontalTextPosition(0);
				lblQta.setHorizontalAlignment(0);
				lblQta.setText("qt\340");
				lblUm = new JLabel();
				lblUm.setBounds(new Rectangle(8, 65, 44, 16));
				lblUm.setHorizontalAlignment(0);
				lblUm.setText("U.M.");
				lblDescrizioneProdotto = new JLabel();
				lblDescrizioneProdotto
						.setBounds(new Rectangle(148, 24, 82, 13));
				lblDescrizioneProdotto.setText("Descrizione");
				lblCodBarre = new JLabel();
				lblCodBarre.setBounds(new Rectangle(8, 24, 69, 13));
				lblCodBarre.setText("Codice");
				pnlProdotto = new JPanel();
				pnlProdotto.setLayout(null);
				pnlProdotto.setBorder(BorderFactory.createTitledBorder(
						BorderFactory.createBevelBorder(0), "Dati prodotto", 0,
						0, new Font("Dialog", 1, 12), new Color(51, 51, 51)));
				pnlProdotto.setLocation(new Point(6, 140));
				pnlProdotto.setSize(new Dimension(825, 192));
				pnlProdotto.add(lblCodBarre, null);
				pnlProdotto.add(getTxtCodBarre(), null);
				pnlProdotto.add(lblDescrizioneProdotto, null);
				pnlProdotto.add(getCmbProdotti(), null);
				pnlProdotto.add(getBtnInserisci(), null);
				pnlProdotto.add(getCmbMisura(), null);
				pnlProdotto.add(lblUm, null);
				pnlProdotto.add(lblQta, null);
				pnlProdotto.add(getTxtQta(), null);
				pnlProdotto.add(lblPrezzo, null);
				pnlProdotto.add(getTxtPrezzo(), null);
				pnlProdotto.add(getBtnElimina(), null);
				pnlProdotto.add(getJScrollPane1(), null);
				pnlProdotto.add(lblNote, null);
				pnlProdotto.add(getChkInsRapido(), null);
				pnlProdotto.add(lblInsRapido, null);
				pnlProdotto.add(getBtnNewArticolo(), null);
				pnlProdotto.add(getBtnNewArticolo1(), null);
			} catch (Throwable throwable) {
			}
		return pnlProdotto;
	}

	private JPanel getPnlSud() {
		if (pnlSud == null)
			try {
				pnlSud = new JPanel();
				pnlSud.setLayout(new BorderLayout());
				pnlSud.add(getJScrollPane(), "Center");
				pnlSud.add(getJPanel(), BorderLayout.SOUTH);
			} catch (Throwable throwable) {
			}
		return pnlSud;
	}

	private JPanel getPnlViewCarichi() {
		if (pnlViewCarichi == null)
			try {
				pnlViewCarichi = new JPanel();
				pnlViewCarichi.setLayout(new BorderLayout());
				pnlViewCarichi.setBorder(BorderFactory.createBevelBorder(0));
				pnlViewCarichi.add(getPnlNord1(), "North");
				pnlViewCarichi.add(getPnlCentro(), "Center");
			} catch (Throwable throwable) {
			}
		return pnlViewCarichi;
	}

	private JTable getTblCarico() {
		if (tblCarico == null)
			try {
				caricoModel = new CaricoModel(idcarico);
				dbm.addDBStateChange(caricoModel);
				tblCarico = new JXTable();
				tblCarico.setDefaultEditor(Double.class, new DoubleEditor());
				tblCarico.setSelectionMode(0);
				tblCarico.setModel(caricoModel);
				caricoModel.addTableModelListener(this);
				tblCarico.setHighlighters(new AlternateRowHighlighter());

				// impostiamo le varie colonne
				TableColumn col = tblCarico.getColumnModel().getColumn(0);
				col.setMinWidth(0);
				col.setMaxWidth(0);
				col.setPreferredWidth(0);

				col = tblCarico.getColumn("codice");
				DefaultTableCellRenderer colFormatoRenderer = new DefaultTableCellRenderer();
				colFormatoRenderer.setHorizontalAlignment(JLabel.LEFT);
				col.setCellRenderer(colFormatoRenderer);

				col = tblCarico.getColumn("descrizione");
				DefaultTableCellRenderer ColTipoRenderer = new DefaultTableCellRenderer();
				ColTipoRenderer.setHorizontalAlignment(JLabel.LEFT);
				col.setCellRenderer(ColTipoRenderer);

				col = tblCarico.getColumn("iva");
				DefaultTableCellRenderer ivaColumnRenderer = new DefaultTableCellRenderer();
				ivaColumnRenderer.setHorizontalAlignment(JLabel.CENTER);
				col.setCellRenderer(ivaColumnRenderer);
				col.setPreferredWidth(40);

				col = tblCarico.getColumn("um");
				DefaultTableCellRenderer umColumnRenderer = new DefaultTableCellRenderer();
				umColumnRenderer.setHorizontalAlignment(JLabel.CENTER);
				col.setCellRenderer(umColumnRenderer);
				col.setPreferredWidth(40);

				col = tblCarico.getColumn("qta");
				DefaultTableCellRenderer qtaColumnRenderer = new DefaultTableCellRenderer();
				qtaColumnRenderer.setHorizontalAlignment(JLabel.CENTER);
				col.setCellRenderer(qtaColumnRenderer);
				col.setPreferredWidth(40);

				col = tblCarico.getColumn("prezzo_acquisto");
				DefaultTableCellRenderer prezzoColumnRenderer = new DefaultTableCellRenderer();
				prezzoColumnRenderer.setHorizontalAlignment(JLabel.RIGHT);
				col.setCellRenderer(prezzoColumnRenderer);
				col.setPreferredWidth(40);

				col = tblCarico.getColumn("totale");
				DefaultTableCellRenderer totaleColumnRenderer = new DefaultTableCellRenderer();
				totaleColumnRenderer.setHorizontalAlignment(JLabel.RIGHT);
				col.setCellRenderer(totaleColumnRenderer);
				col.setPreferredWidth(40);

				tblCarico.setAutoResizeMode(4);
				tblCarico.packAll();
				tblCarico.getTableHeader().setReorderingAllowed(false);
			} catch (Throwable throwable) {
			}
		return tblCarico;
	}

	private JXTable getTblViewCarichi() {
		if (tblViewCarichi == null)
			try {
				carichiView = new CarichiViewModel(dbm);
				dbm.addDBStateChange(carichiView);
				tblViewCarichi = new JXTable(carichiView);
				tblViewCarichi.setSelectionMode(0);
				tblViewCarichi.setAutoResizeMode(4);
				tblViewCarichi.packAll();
				tblViewCarichi.getTableHeader().setReorderingAllowed(false);
				// tblViewCarichi.setHighlighters(new
				// AlternateRowHighlighter(Color.RED,Color.GREEN,Color.BLACK));
				// tblViewCarichi.getColumn(8).setCellRenderer(new
				// SospesiColorRenderer());
				// tblViewCarichi.getColumn(7).setCellRenderer(new
				// SospesiColorRenderer());
				tblViewCarichi.setDefaultRenderer(Object.class,
						new SospesiColorRenderer());
				TableColumn c=tblViewCarichi.getColumnModel().getColumn(1);
				c.setMaxWidth(100);
				c.setMinWidth(100);
				c.setPreferredWidth(100);

				c=tblViewCarichi.getColumnModel().getColumn(2);
				c.setMaxWidth(60);
				c.setMinWidth(60);
				c.setPreferredWidth(60);

				c=tblViewCarichi.getColumnModel().getColumn(6);
				c.setMaxWidth(60);
				c.setMinWidth(60);
				c.setPreferredWidth(60);

				c=tblViewCarichi.getColumnModel().getColumn(7);
				c.setMaxWidth(60);
				c.setMinWidth(60);
				c.setPreferredWidth(60);

			} catch (Throwable throwable) {
			}
		return tblViewCarichi;
	}

	private JTabbedPane getTbp() {
		if (tbp == null)
			try {
				tbp = new JTabbedPane();
				tbp.addTab("Carico merce", null, getPnlCentrale(), null);
				tbp.addTab("Visualizza carichi", null, getPnlViewCarichi(),
						null);
			} catch (Throwable throwable) {
			}
		return tbp;
	}

	private JTextField getTxtCodBarre() {
		if (txtCodBarre == null)
			try {
				txtCodBarre = new JTextField();
				AutoCompleteTextComponent complete = new AutoCompleteTextComponent(
						txtCodBarre, dbm, "articolo", "codbarre");
				dbm.addDBStateChange(complete);
				txtCodBarre.setDocument(new UpperAutoCompleteDocument(complete,
						true));
				txtCodBarre.setBounds(new Rectangle(8, 40, 137, 21));
				txtCodBarre.addFocusListener(new FocusAdapter() {

					public void focusLost(FocusEvent e) {
						caricaArticoloByCodBarre();
					}
				});
				txtCodBarre.addKeyListener(new KeyAdapter() {

					public void keyPressed(KeyEvent e) {
						if (e.getKeyCode() == 10) {
							caricaArticoloByCodBarre();
							if (chkInsRapido.isSelected())
								inserisci();
						}
					}
				});
			} catch (Throwable throwable) {
			}
		return txtCodBarre;
	}

	private JDateChooser getDateChooserDocumento() {
		if (dataDocumento == null)
			try {
				dataDocumento = new JDateChooser("dd/MM/yyyy", "##/##/##", '_');
				dataDocumento.setDate(new java.util.Date());
				dataDocumento.setBounds(new Rectangle(304, 80, 117, 25));
				JTextFieldDateEditor f = (JTextFieldDateEditor) dataDocumento
						.getDateEditor();
				f.addFocusListener(new java.awt.event.FocusAdapter() {
					public void focusGained(java.awt.event.FocusEvent e) {
						JTextFieldDateEditor s = (JTextFieldDateEditor) dataDocumento
								.getDateEditor();
						s.setCaretPosition(0);
					}
				});

			} catch (Throwable throwable) {
			}
		return dataDocumento;
	}

	private JTextArea getTxtNote() {
		if (txtNote == null)
			try {
				txtNote = new JTextArea();
				txtNote.setLineWrap(true);
				txtNote.setDocument(new UpperTextDocument());
			} catch (Throwable throwable) {
			}
		return txtNote;
	}

	private JTextField getTxtNumDocumento() {
		if (txtNumDocumento == null)
			try {
				txtNumDocumento = new JTextField();
				txtNumDocumento.setBounds(new Rectangle(96, 80, 101, 25));
				AutoCompleteTextComponent complete = new AutoCompleteTextComponent(
						txtNumDocumento, dbm, "carico", "num_documento", "");
				dbm.addDBStateChange(complete);
				txtNumDocumento.setDocument(new UpperAutoCompleteDocument(complete,
						false));
			} catch (Throwable throwable) {
			}
		return txtNumDocumento;
	}

	private JTextField getTxtNumeroCarico() {
		if (txtNumeroCarico == null)
			try {
				txtNumeroCarico = new JTextField();
				txtNumeroCarico.setBounds(new Rectangle(69, 20, 65, 25));
				txtNumeroCarico.setEditable(false);
				AutoCompleteTextComponent complete = new AutoCompleteTextComponent(
						txtNumeroCarico, dbm, "carico", "idcarico", "");
				dbm.addDBStateChange(complete);
				txtNumeroCarico.setDocument(new UpperAutoCompleteDocument(
						complete, false));
			} catch (Throwable throwable) {
			}
		return txtNumeroCarico;
	}

	private JFormattedTextField getTxtPrezzo() {
		if (txtPrezzo == null)
			try {
				DecimalFormat formatPrice = new DecimalFormat();
				formatPrice.setMaximumFractionDigits(2);
				formatPrice.setMinimumFractionDigits(2);
				txtPrezzo = new JFormattedTextField(formatPrice);
				txtPrezzo.setBounds(new Rectangle(153, 82, 76, 20));
				txtPrezzo.setValue(0);
			} catch (Throwable throwable) {
			}
		return txtPrezzo;
	}

	private JFormattedTextField getTxtQta() {
		if (txtQta == null)
			try {
				DecimalFormat formatPrice = new DecimalFormat();
				formatPrice.setMaximumFractionDigits(2);
				formatPrice.setMinimumFractionDigits(2);
				txtQta = new JFormattedTextField(formatPrice);
				txtQta.setBounds(new Rectangle(88, 82, 60, 20));
				txtQta.setValue(0.0);
				/*
				 * txtQta.addFocusListener(new FocusAdapter() {
				 *
				 * public void focusLost(FocusEvent e) { String numero =
				 * txtQta.getText(); if (!ControlloDati.isNumero(numero)) {
				 * txtQta.selectAll(); messaggioErroreCampo("Errore campo
				 * quantit\340"); } } });
				 */
			} catch (Throwable throwable) {
			}
		return txtQta;
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
				cmbMisura.setBounds(new Rectangle(8, 82, 70, 25)); // Generated
				// caricaUnitaMisura(cmbMisura);
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return cmbMisura;
	}

	private void initialize() {
		// impostiamo la finestra per ascoltare i tasti funzione da F1 in su
		// ed altri pulsanti
		InputMap im = this.getRootPane().getInputMap(
				JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F1, 0), "F1");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F2, 0), "F2");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F3, 0), "F3");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F4, 0), "F4");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_F4, 0), "F5");
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), "ESC");

		this.getRootPane().getActionMap().put("F1", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				azzeraTuttiCampi();
			}
		});
		this.getRootPane().getActionMap().put("F3", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				newArticolo();
			}
		});
		this.getRootPane().getActionMap().put("F4", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				visualizzaArticoli();
			}
		});
		this.getRootPane().getActionMap().put("F5", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				eliminaArticolo();
			}
		});
		this.getRootPane().getActionMap().put("F2", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				inserisci();
			}
		});
		this.getRootPane().getActionMap().put("ESC", new AbstractAction() {
			public void actionPerformed(ActionEvent a) {
				dispose();
			}
		});

		Carico c = new Carico();
		idcarico = c.getNewID();
		setSize(850, 600);
		setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
		setTitle("Carico Merce");
		setResizable(true);
		setContentPane(getJContentPane());
		addWindowListener(new WindowAdapter() {

			public void windowClosed(WindowEvent e) {
				padre.setEnabled(true);
			}

			public void windowClosing(WindowEvent e) {
				padre.setEnabled(true);
			}
		});
		UtilGUI.centraFrame(this);
		txtNumeroCarico.setText((new Integer(idcarico)).toString());
		dataCarico.setDate(new java.util.Date());
		caricaFornitori(cmbFornitori);
		caricaArticoli(cmbProdotti);
		caricaDocumenti(cmbTipoDocumento);
		caricaCmbUnitaDiMisura();
		inizializzaListeners();
		inizializzaRadioButton();

	}

	private void inizializzaRadioButton() {
		ButtonGroup g = new ButtonGroup();
		g.add(rbtnSi);
		g.add(rbtnNo);
		rbtnNo.setSelected(true);

	}

	private void inizializzaListeners() {
		myComboBoxListener = new MyComboBoxListener();
		myButtonListener = new MyButtonListener();
		myMouseadapter=new MyMouseAdapter();
		// cmbFornitori.addActionListener(myComboBoxListener);
		btnInserisci.addActionListener(myButtonListener);
		btnElimina.addActionListener(myButtonListener);
		btnChiudi.addActionListener(myButtonListener);
		cmbProdotti.addActionListener(myComboBoxListener);
		tblViewCarichi.addMouseListener(myMouseadapter);
	}

	private void inserisci() {
		if ( new Integer(txtNumeroCarico.getText()) == 0 ){
			messaggioCampoMancante("Impossibile modificare il carico iniziale.", "WARNING");
			return;
		}
		String doc = cmbTipoDocumento.getSelectedItem().toString();
		if (doc.equalsIgnoreCase("")) {
			messaggioCampoMancante("Tipo di documento non selezionato");
			return;
		}
		if (txtNumDocumento.getText().equalsIgnoreCase("")) {
			messaggioCampoMancante("Numero documento non inserito");
			return;
		}


		String codBarre = txtCodBarre.getText();
		double tmp = ((Number) txtQta.getValue()).doubleValue();
		String tmpPrezzo = txtPrezzo.getText();
		String s = txtQta.getText();

		// PUNTO DI BACKUP DA ATTIVARE DA CONFIGURAZIONI
		try {
			UtilityDBManager.getSingleInstance().backupDataBase(
					UtilityDBManager.INSERT);
		} catch (FileNotFoundException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		} catch (IOException e1) {
			JOptionPane
					.showMessageDialog(
							this,
							"File di configurazione per backup\nmancante o danneggiato",
							"ERRORE FILE", JOptionPane.ERROR_MESSAGE);
			e1.printStackTrace();
		}
		// FINE PUNTO BACKUP

		if (codBarre.equals("") && s.equals("0,00") && tmpPrezzo.equals("0,00")) {
			salvaFattura();
			return;
		}
		if (codBarre.equalsIgnoreCase("")) {
			messaggioCampoMancante("Codice a barre non presente \nselezionare un prodotto");
			return;
		}
		if (tmp == 0.0) {
			messaggioCampoMancante("Inserire la quantit\340");
			return;
		}
		Carico c = new Carico();
		try {

			if (!c
					.isInsert((new Integer(txtNumeroCarico.getText()))
							.intValue())) {
				if(Carico.isNumeroCaricoEsistente(txtNumDocumento.getText())){
					throw new NumeroCaricoEsistente();
				}
				c.setIdCarico((new Integer(txtNumeroCarico.getText())).intValue());
				c.setIdFornitore((new Integer(cmbFornitori.getIDSelectedItem())).intValue());
				c.setDataCarico(new Date(dataCarico.getDate().getTime()));
				c.setDataDocumento(new Date(dataDocumento.getDate().getTime()));
				c.setNumDocumento(txtNumDocumento.getText());
				c.setIdDocumento((new Integer(cmbTipoDocumento.getIDSelectedItem())).intValue());
				c.setOraCarico(new Time((new java.util.Date()).getTime()));
				c.setNote(txtNote.getText());
				c.setInsertByPN(0);
				c.setSconto(((Number) txtSconto.getValue()).intValue());
				if (rbtnNo.isSelected())
					c.setSospeso(0);
				else
					c.setSospeso(1);
				c.insertCarico();
			} else {
				c.setIdCarico((new Integer(txtNumeroCarico.getText()))
						.intValue());
				c
						.setIdFornitore((new Integer(cmbFornitori
								.getIDSelectedItem())).intValue());
				c.setDataCarico(new Date(dataCarico.getDate().getTime()));
				c.setDataDocumento(new Date(dataDocumento.getDate().getTime()));
				c.setNumDocumento(txtNumDocumento.getText());
				c.setIdDocumento((new Integer(cmbTipoDocumento
						.getIDSelectedItem())).intValue());
				c.setOraCarico(new Time((new java.util.Date()).getTime()));
				c.setSconto(((Number) txtSconto.getValue()).intValue());
				c.setNote(txtNote.getText());
				if (rbtnNo.isSelected())
					c.setSospeso(0);
				else
					c.setSospeso(1);
				try {
					c.updateCarico();
				} catch (IDNonValido e) {
					e.printStackTrace();
				}
			}
			controlloAggPrezzo();
			Articolo a = new Articolo();
			try {
				a.caricaDatiByCodBarre(txtCodBarre.getText());
			} catch (IDNonValido e) {
				e.printStackTrace();
			}
			c.setIdCarico((new Integer(txtNumeroCarico.getText())).intValue());
			if (Carico.codiceBarrePresenteInScarico(txtCodBarre.getText(),
					Integer.parseInt(txtNumeroCarico.getText()))) {
				c.caricaDati((new Integer(txtNumeroCarico.getText()))
						.intValue());
				double qta = 0;
				try {
					qta = c.getQuantitaCaricata(a.getIdArticolo());
				} catch (IDNonValido e) {
					JOptionPane.showMessageDialog(this,
							"Probabile Errore nel codice dell'Articolo",
							"ERRORE", 0);
					e.printStackTrace();
				} catch (ResultSetVuoto e) {
					JOptionPane
							.showMessageDialog(
									this,
									"Il ResultSet probabilmente non \ncontiene informazioni",
									"ERRORE", 0);
					e.printStackTrace();
				}
				double price = 0.0D;
				if (txtPrezzo.getValue() instanceof Double)
					price = ((Double) txtPrezzo.getValue()).doubleValue();
				else
					price = ((Long) txtPrezzo.getValue()).intValue();
				c.updateArticolo(a.getIdArticolo(), qta
						+ ((Number) txtQta.getValue()).doubleValue(), price);
			} else {
				double price = 0.0D;
				if (txtPrezzo.getValue() instanceof Double)
					price = ((Double) txtPrezzo.getValue()).doubleValue();
				else
					price = ((Long) txtPrezzo.getValue()).intValue();
				c.insertArticolo(a.getIdArticolo(),
						((Number) txtQta.getValue()).doubleValue(), price);
			}
			calcoli(c);
			azzeraCampi();
			tblCarico.packAll();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NumberFormatException e) {
			JOptionPane.showMessageDialog(this,
					"Errore nell'inserimento dinumeri", "NUMERO ERRATO", 0);
			e.printStackTrace();
		} catch (NumeroCaricoEsistente e) {
			JOptionPane.showMessageDialog(this, e.getMessage(), "AVVISO", JOptionPane.INFORMATION_MESSAGE);
		}

	}

	private void messaggioCampoMancante(String testo) {
		JOptionPane.showMessageDialog(this, testo, "CAMPO VUOTO", 1);
	}

	private void messaggioErroreCampo(String testo) {
		JOptionPane.showMessageDialog(this, testo, "ERRORE", 0);
	}

	private void modifica() {
		if (tblViewCarichi.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", 1);
			return;
		}
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler\nmodificare il carico selezionato?",
				"AVVISO", 0, 1);
		if (scelta != JOptionPane.YES_OPTION)
			return;
		int riga = tblViewCarichi.getSelectedRow();
		int idcarico = ((Long) tblViewCarichi.getValueAt(riga, 0)).intValue();
		Carico c = new Carico();
		try {
			c.caricaDati(idcarico);
			if (c.getInsertByPN() == 1) {
				JOptionPane.showMessageDialog(this,
						"Impossibile modificare il documento da carico.\n"
								+ "modifica permessa solo da prima nota.",
						"AVVISO", 1);
				return;
			}
			if (!c.haArticoli())
				c.switchCarico();
			caricaDati(c);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, "Errore nel db", "ERRORE", 2);
			e.printStackTrace();
		} catch (IDNonValido e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ResultSetVuoto e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private boolean prezzoUguale(double pNuovo, int idArticolo) {
		Articolo a = new Articolo();
		try {
			a.caricaDati(idArticolo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		double pAttuale = a.getPrezzoAcquisto();
		double prezzoNuovo = pNuovo;
		return pAttuale == prezzoNuovo;
	}

	private void ricaricaTableCarico(int idCarico) {

		try {
			caricoModel.reloadModel(idCarico);
		} catch (SQLException e) {
			messaggioErroreCampo("Errore caricamento dati dal db");
			e.printStackTrace();
		}
		dbm.addDBStateChange(caricoModel);
		tblCarico.setModel(caricoModel);
		TableColumn col = tblCarico.getColumnModel().getColumn(0);
		col.setMinWidth(0);
		col.setMaxWidth(0);
		col.setPreferredWidth(0);
		tblCarico.packAll();
	}

	private JButton getBtnNewArticolo() {
		if (btnNewArticolo == null)
			try {
				btnNewArticolo = new JButton();
				btnNewArticolo.setBounds(new Rectangle(495, 125, 126, 26));
				btnNewArticolo.setText("Nuovo Art. (F3)");
				btnNewArticolo.addActionListener(new ActionListener() {

					public void actionPerformed(ActionEvent e) {
						newArticolo();
					}
				});
			} catch (Throwable throwable) {
			}
		return btnNewArticolo;
	}

	protected void newArticolo() {
		String codArticolo[] = new String[1];
		ArticoloAddMod add = new ArticoloAddMod(this, 0, codArticolo);
		add.setCloseOnOk(true);
		add.setVisible(true);
		txtCodBarre.setText(codArticolo[0]);
		caricaArticoli(cmbProdotti);
		caricaArticoloByCodBarre();
	}

	private JDateChooser getDataCarico() {
		if (dataCarico == null)
			try {
				dataCarico = new JDateChooser("dd/MM/yyyy", "##/##/##", '_');
				dataCarico.setDate(new java.util.Date());
				dataCarico.setBounds(new Rectangle(216, 20, 112, 25));
				JTextFieldDateEditor f = (JTextFieldDateEditor) dataCarico
						.getDateEditor();
				f.addFocusListener(new java.awt.event.FocusAdapter() {
					public void focusGained(java.awt.event.FocusEvent e) {
						JTextFieldDateEditor s = (JTextFieldDateEditor) dataCarico
								.getDateEditor();
						s.setCaretPosition(0);
					}
				});

			} catch (Throwable throwable) {
			}
		return dataCarico;
	}

	private JButton getBtnStampa() {
		if (btnStampa == null)
			try {
				btnStampa = new JButton();
				btnStampa.setText("Stampa");
				btnStampa.addActionListener(new MyButtonListener());
			} catch (Throwable throwable) {
			}
		return btnStampa;
	}

	private JButton getBtnNewArticolo1() {
		if (btnVisualizzaArt == null)
			try {
				btnVisualizzaArt = new JButton();
				btnVisualizzaArt.setBounds(new Rectangle(370, 155, 121, 26));
				btnVisualizzaArt.setText("Elenco Art. (F4)");
				btnVisualizzaArt.addActionListener(new ActionListener() {

					public void actionPerformed(ActionEvent e) {
						visualizzaArticoli();
					}
				});
			} catch (Throwable throwable) {
			}
		return btnVisualizzaArt;
	}

	protected void visualizzaArticoli() {
		ArticoliGestione g = new ArticoliGestione();
		g.setVisible(true);
	}

	private JPanel getPnlNord1() {
		if (pnlNord1 == null)
			try {
				FlowLayout flowLayout = new FlowLayout();
				flowLayout.setAlignment(0);
				pnlNord1 = new JPanel();
				pnlNord1.setLayout(flowLayout);
				pnlNord1.add(getBtnModifica(), null);
				pnlNord1.add(getBtnStampa(), null);
				pnlNord1.add(getBtnEliminaCarico(), null);
			} catch (Throwable throwable) {
			}
		return pnlNord1;
	}

	private JPanel getPnlCentro() {
		if (pnlCentro == null)
			try {
				pnlCentro = new JPanel();
				pnlCentro.setLayout(new BorderLayout());
				pnlCentro.setBorder(BorderFactory.createTitledBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED), "Elenco documenti di carico", TitledBorder.DEFAULT_JUSTIFICATION, TitledBorder.DEFAULT_POSITION, new Font("Dialog", Font.BOLD, 12), new Color(51, 51, 51)));
				pnlCentro.add(getJScrollPane2(), "Center");
			} catch (Throwable throwable) {
			}
		return pnlCentro;
	}

	private static final long serialVersionUID = 1L;

	private JButton btnAzzera;

	private JButton btnChiudi;

	private JButton btnElimina;

	private JButton btnEliminaCarico;

	private JButton btnInserisci;

	private JButton btnModifica;

	private CarichiViewModel carichiView;

	private CaricoModel caricoModel;

	private JCheckBox chkInsRapido;

	private IDJComboBox cmbFornitori;

	private IDJComboBox cmbProdotti;

	private IDJComboBox cmbTipoDocumento;

	private DBManager dbm;

	private int idcarico;

	private JPanel jContentPane;

	private JScrollPane jScrollPane;

	private JScrollPane jScrollPane1;

	private JScrollPane jScrollPane2;

	private JLabel lblCodBarre;

	private JLabel lblDataCarico;

	private JLabel lblDescrizioneProdotto;

	private JLabel lblFornitore;

	private JLabel lblInsRapido;

	private JLabel lblNote;

	private JLabel lblNumDocumento;

	private JLabel lblNumeroCarico;

	private JLabel lblPrezzo;

	private JLabel lblQta;

	private JLabel lblTipoDocumento;

	private JLabel lblUm;

	private MyButtonListener myButtonListener;

	private MyComboBoxListener myComboBoxListener;  //  @jve:decl-index=0:

	private JPanel pnlCentrale;

	private JPanel pnlNord;

	private JPanel pnlProdotto;

	private JPanel pnlSud;

	private JPanel pnlViewCarichi;

	private JXTable tblCarico;

	private JXTable tblViewCarichi;

	private JTabbedPane tbp;

	private JTextField txtCodBarre;

	private JDateChooser dataDocumento;

	private JTextArea txtNote;

	private JTextField txtNumDocumento;

	private JTextField txtNumeroCarico;

	private JFormattedTextField txtPrezzo;

	private JFormattedTextField txtQta;

	private JComboBox cmbMisura = null;

	private JLabel lblDataDocumento;

	private JButton btnNewArticolo;

	private JDateChooser dataCarico;

	private JButton btnStampa;

	private Frame padre;

	private JButton btnVisualizzaArt;

	private JPanel pnlNord1;

	private JPanel pnlCentro;

	private JButton btnNuovoForn = null;

	private JPanel jPanel = null;

	private JPanel pnlSud1 = null;

	private JLabel lblIngImponibile = null;

	private JTextField txtImponibileIng = null;

	private JLabel lblIngImposta = null;

	private JTextField txtImpostaIng = null;

	private JLabel lblTotIng = null;

	private JTextField txtTotaleIng = null;

	private JPanel jPanel1 = null;

	private JRadioButton rbtnSi = null;

	private JRadioButton rbtnNo = null;

	private JLabel lblSi = null;

	private JLabel lblNO = null;

	private DecimalFormat notaz = null;

	private DecimalFormat notaz1 = null;

	private Vector carrello = null;

	private Vector colonne = null;

	private JPanel jPanelOvest = null;

	private JXTable jTableDdt = null;

	private DdtFatturaModel ddtModel = null;

	private DdtFatturaModel ddtModel1 = null;

	private JPanel jPanelOvest1 = null;

	private JScrollPane jScrollPane111 = null;

	private DdtFatturaModel ddtModel11 = null;

	private int id_ddt;

	private DdtCaricoModel modelloDdtCarico;

	private GregorianCalendar time1 = null;

	private JTable tblDDT1 = null;

	private DdtCaricoModel modelloDdtCarico1 = null;

	private JPanel pnlSconto = null;

	private JFormattedTextField txtSconto = null;
	
	private String[] descUnitaDiMisura;
	
	private String[] codUnitaDiMisura;

	/**
	 * This method initializes btnNuovoForn
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnNuovoForn() {
		if (btnNuovoForn == null) {
			btnNuovoForn = new JButton();
			btnNuovoForn.setBounds(new Rectangle(514, 109, 71, 22));
			btnNuovoForn.setText("Nuovo");
			btnNuovoForn.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					nuovoFornitore();
				}
			});
		}
		return btnNuovoForn;
	}

	protected void nuovoFornitore() {
		FornitoriAdd add = new FornitoriAdd(this);
		add.setVisible(true);
		caricaFornitori(cmbFornitori);

	}

	/**
	 * This method initializes jPanel
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getJPanel() {
		if (jPanel == null) {
			jPanel = new JPanel();
			jPanel.setLayout(new BorderLayout());
			jPanel.setPreferredSize(new Dimension(0, 60));
			jPanel.add(getPnlSud1(), BorderLayout.CENTER);
		}
		return jPanel;
	}

	/**
	 *
	 */
	private void calcoli(Carico c) {
		// Calcoliamo tutte le somme e impostiamo i campi
		// cominciamo prima a calcolare il dettaglio
		double imponibile;
		double imposta;
		double tot = 0;
		int id = c.getIdCarico();

		// Calcoliamo ora la parte all'ingrosso
		try {

			imponibile = Carico.getTotAcquistoImponibileByOrder(id);
			imposta = Carico.getTotAcquistoImpostaByOrder(id);
			tot = imponibile + imposta;
			int sconto = c.getSconto();
			if (sconto > 0) {
				tot = tot - ((tot / 100) * sconto);
			}

			// impostiamo i campi
			txtImponibileIng.setText(ControlloDati
					.convertDoubleToPrezzo(imponibile));
			txtImpostaIng.setText(ControlloDati.convertDoubleToPrezzo(imposta));
			txtTotaleIng.setText(ControlloDati.convertDoubleToPrezzo(tot));

		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Probabile errore nei calcoli all'ingrosso", "ERRORE",
					JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		}
	}

	/**
	 * This method initializes pnlSud1
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlSud1() {
		if (pnlSud1 == null) {
			lblTotIng = new JLabel();
			lblTotIng.setBounds(new Rectangle(424, 8, 85, 25));
			lblTotIng.setText("Totale \u20ac.");
			lblIngImposta = new JLabel();
			lblIngImposta.setBounds(new Rectangle(236, 8, 89, 25));
			lblIngImposta.setText("Imposta \u20ac.");
			lblIngImponibile = new JLabel();
			lblIngImponibile.setBounds(new Rectangle(32, 8, 105, 25));
			lblIngImponibile.setText("Imponibile \u20ac.");
			pnlSud1 = new JPanel();
			pnlSud1.setLayout(null);
			pnlSud1.setPreferredSize(new Dimension(0, 50));
			pnlSud1.setBorder(BorderFactory
					.createBevelBorder(BevelBorder.RAISED));
			pnlSud1.add(lblIngImponibile, null);
			pnlSud1.add(getTxtImponibileIng(), null);
			pnlSud1.add(lblIngImposta, null);
			pnlSud1.add(getTxtImpostaIng(), null);
			pnlSud1.add(lblTotIng, null);
			pnlSud1.add(getTxtTotaleIng(), null);
		}
		return pnlSud1;
	}

	/**
	 * This method initializes txtImponibileIng
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtImponibileIng() {
		if (txtImponibileIng == null) {
			txtImponibileIng = new JTextField();
			txtImponibileIng.setBounds(new Rectangle(136, 8, 93, 25));
			txtImponibileIng.setFont(new Font("Dialog", Font.BOLD, 12));
			txtImponibileIng.setDisabledTextColor(Color.black);
			txtImponibileIng.setEditable(false);
			txtImponibileIng.setEnabled(false);
		}
		return txtImponibileIng;
	}

	/**
	 * This method initializes txtImpostaIng
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtImpostaIng() {
		if (txtImpostaIng == null) {
			txtImpostaIng = new JTextField();
			txtImpostaIng.setBounds(new Rectangle(324, 8, 93, 25));
			txtImpostaIng.setFont(new Font("Dialog", Font.BOLD, 12));
			txtImpostaIng.setDisabledTextColor(Color.black);
			txtImpostaIng.setEditable(false);
			txtImpostaIng.setEnabled(false);
		}
		return txtImpostaIng;
	}

	/**
	 * This method initializes txtTotaleIng
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtTotaleIng() {
		if (txtTotaleIng == null) {
			txtTotaleIng = new JTextField();
			txtTotaleIng.setBounds(new Rectangle(508, 8, 93, 25));
			txtTotaleIng.setFont(new Font("Dialog", Font.BOLD, 12));
			txtTotaleIng.setDisabledTextColor(Color.red);
			txtTotaleIng.setEditable(false);
			txtTotaleIng.setEnabled(false);
		}
		return txtTotaleIng;
	}

	/**
	 * This method initializes jPanel1
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getJPanel1() {
		if (jPanel1 == null) {
			lblNO = new JLabel();
			lblNO.setText("NO");
			lblSi = new JLabel();
			lblSi.setText("SI");
			jPanel1 = new JPanel();
			jPanel1.setLayout(new FlowLayout());
			jPanel1.setBounds(new Rectangle(425, 50, 110, 56));
			jPanel1.setBorder(BorderFactory.createTitledBorder(null, "Sospeso",
					TitledBorder.DEFAULT_JUSTIFICATION,
					TitledBorder.DEFAULT_POSITION, new Font("Dialog",
							Font.BOLD, 12), new Color(51, 51, 51)));
			jPanel1.add(lblSi, null);
			jPanel1.add(getRbtnSi(), null);
			jPanel1.add(lblNO, null);
			jPanel1.add(getRbtnNo(), null);
		}
		return jPanel1;
	}

	/**
	 * This method initializes rbtnSi
	 *
	 * @return javax.swing.JRadioButton
	 */
	private JRadioButton getRbtnSi() {
		if (rbtnSi == null) {
			rbtnSi = new JRadioButton();
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
		}
		return rbtnNo;
	}

	/**
	 * @param string
	 */
	private void messaggioCampoMancante(String testo, String tipo) {
		JOptionPane.showMessageDialog(this, testo, tipo,
				JOptionPane.INFORMATION_MESSAGE);
	}

	/**
	 * This method initializes time1
	 *
	 * @return java.util.GregorianCalendar
	 */
	private GregorianCalendar getTime1() {
		if (time1 == null) {
			time1 = (GregorianCalendar) Calendar.getInstance();
		}
		return time1;
	}

	/**
	 * This method initializes pnlSconto
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlSconto() {
		if (pnlSconto == null) {
			pnlSconto = new JPanel();
			pnlSconto.setLayout(new FlowLayout());
			pnlSconto.setBounds(new Rectangle(540, 50, 106, 56));
			pnlSconto.setBorder(BorderFactory.createTitledBorder(null,
					"Sconto \u20ac.", TitledBorder.DEFAULT_JUSTIFICATION,
					TitledBorder.DEFAULT_POSITION, new Font("Dialog",
							Font.BOLD, 12), new Color(51, 51, 51)));
			pnlSconto.add(getTxtSconto(), null);
		}
		return pnlSconto;
	}

	/**
	 * This method initializes txtSconto
	 *
	 * @return javax.swing.JTextField
	 */
	private JFormattedTextField getTxtSconto() {
		if (txtSconto == null) {
			NumberFormat f = NumberFormat.getIntegerInstance();
			txtSconto = new JFormattedTextField(f);
			txtSconto.setPreferredSize(new Dimension(80, 20));
			txtSconto.setHorizontalAlignment(SwingConstants.RIGHT);
			txtSconto.setValue(0);
		}
		return txtSconto;
	}

} // @jve:decl-index=0:visual-constraint="10,10"
