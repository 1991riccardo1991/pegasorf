package rf.pegaso.gui.vendita.panel;

import it.infolabs.hibernate.CodiciIva;
import it.infolabs.hibernate.CodiciIvaHome;
import it.infolabs.pos.PosException;
import it.infolabs.pos.Ticket;
import it.infolabs.pos.TicketRow;
import it.infolabs.pos.driver.RCHDriver;

import javax.swing.JPanel;
import java.awt.BorderLayout;
import java.awt.Font;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Time;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;

import javax.swing.BorderFactory;
import javax.swing.border.BevelBorder;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import org.jdesktop.swingx.JXTable;
import org.jdesktop.swingx.decorator.AlternateRowHighlighter;

import rf.pegaso.db.tabelle.DettaglioScarico;
import rf.pegaso.db.tabelle.Scarico;
import rf.pegaso.gui.InitialGUI;
import rf.utility.Constant;
import rf.utility.ControlloDati;
import rf.utility.MathUtility;
import rf.utility.collection.MyArrayList;
import rf.utility.db.DBManager;
import rf.utility.db.UtilityDBManager;

public class JPanelRiepilogoVendita extends JPanel {

	

	class PrezzoCellRenderer extends DefaultTableCellRenderer {
		private static final long serialVersionUID = 1L;
		private DecimalFormat numberFormatter;
		private Double d;

		public void setValue(Object value) {
			if (numberFormatter == null) {

				numberFormatter = (DecimalFormat) DecimalFormat
						.getCurrencyInstance(Locale.ITALY);
				// numberFormatter = new DecimalFormat("#,##0.00");
				// numberFormatter.setMaximumFractionDigits(2);
				// numberFormatter.setMinimumFractionDigits(2);
			}
			setHorizontalAlignment(JLabel.RIGHT);
			d = (Double) value;
			setText((value == null) ? "" : numberFormatter.format(d));
		}
	}

	class QtaCellRenderer extends DefaultTableCellRenderer {
		private static final long serialVersionUID = 1L;
		private DecimalFormat numberFormatter;
		private Double d;

		public void setValue(Object value) {
			if (numberFormatter == null) {

				// numberFormatter = (DecimalFormat)
				// DecimalFormat.getInstance();
				numberFormatter = new DecimalFormat("#,##0.00");
				numberFormatter.setMaximumFractionDigits(2);
				numberFormatter.setMinimumFractionDigits(2);
			}
			setHorizontalAlignment(JLabel.CENTER);
			d = (Double) value;
			setText((value == null) ? "" : numberFormatter.format(d));
		}
	}

	class IntegerCellRenderer extends DefaultTableCellRenderer {
		private static final long serialVersionUID = 1L;
		private NumberFormat numberFormatter;
		private Long d;

		public void setValue(Object value) {
			if (numberFormatter == null) {
				numberFormatter = NumberFormat.getIntegerInstance();
			}
			setHorizontalAlignment(JLabel.CENTER);
			d = (Long) value;
			setText((value == null) ? "" : numberFormatter.format(d));
		}
	}

	public class VenditaTableModel extends AbstractTableModel{

		/**
		 *
		 */
		private static final long serialVersionUID = 1L;
		private String nomiColonne[] = { "DESCRIZIONE", "PREZZO", "QTA'",
				"IVA", "TOTALE" };

		public VenditaTableModel() {

		}

		public int getColumnCount() {
			// le colonne sono 5 e sono
			// DESCRIZIONE - PREZZO UNIT - QTA - IVA - TOTALE
			return 5;

		}

		@Override
		public String getColumnName(int col) {
			return nomiColonne[col];
		}

		public int getRowCount() {
			if (carrello == null)
				return 0;
			return carrello.size();
		}

		@Override
		public boolean isCellEditable(int rowIndex, int columnIndex) {
			DettaglioScarico ord = carrello.get(rowIndex);
			if ((ord.getDescrizione().equals("REPARTO 1")
					|| ord.getDescrizione().equals("REPARTO 2")
					|| ord.getDescrizione().equals("REPARTO 3") || ord
					.getDescrizione().equals("REPARTO 4"))
					&& (columnIndex == 1 || columnIndex == 2)) {
				return true;
			}
			return false;
		}

		@Override
		public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
			DettaglioScarico ord = carrello.get(rowIndex);
			double oldPrezzo = 0;
			if (ord.getDescrizione().equals("REPARTO 1")
					|| ord.getDescrizione().equals("REPARTO 2")
					|| ord.getDescrizione().equals("REPARTO 3")
					|| ord.getDescrizione().equals("REPARTO 4")) {
				try {
					oldPrezzo = ord.getPrezzoVendita() * ord.getQta();
					if (columnIndex == 1) {
						ord.setPrezzoVendita(ControlloDati
								.convertPrezzoToDouble((String) aValue));
					} else if (columnIndex == 2) {
						ord.setQta(ControlloDati
								.convertPrezzoToDouble((String) aValue));
					}
					totaleCarrello = totaleCarrello - oldPrezzo;
					totaleCarrello = totaleCarrello + ord.getPrezzoVendita()
							* ord.getQta();
					this.fireTableCellUpdated(rowIndex, columnIndex);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}

		public Object getValueAt(int r, int c) {
			DettaglioScarico riga = carrello.get(r);
			Object o = null;
			
			// Recuperiamo l'oggetto CodiceIva
			CodiciIvaHome.getInstance().begin();
			CodiciIva codiceIva=CodiciIvaHome.getInstance().findById(riga.getIva());
			

			switch (c) {
			case 0: {
				o = riga.getDescrizione().toUpperCase();
				break;
			}
			case 1: {
				o = new Double(riga.getPrezzoVendita());
				break;
			}
			case 2: {
				o = new Double(riga.getQta());
				break;
			}
			case 3: {
				o = new Long(codiceIva.getPercentuale());
				break;
			}
			case 4: {
				double tot = riga.getPrezzoVendita() * riga.getQta();
				tot = tot
						+ MathUtility.percentualeDaAggiungere(tot, codiceIva.getPercentuale());
				o = new Double(tot);
				break;
			}

			}
			return o;
		}

		
	}

	private static final long serialVersionUID = 1L;
	private JScrollPane jScrollPane = null;
	private JXTable tblVendite = null;
	private MyArrayList carrello = null; // @jve:decl-index=0:
	private VenditaTableModel modello;
	private int idSelectedItem = -1;
	private double totaleCarrello = 0.0;
	private Scarico scarico = null;
	private String nome;

	/**
	 * This is the default constructor
	 */
	public JPanelRiepilogoVendita() {
		super();
		initialize();
	}

	/**
	 * This is the default constructor
	 */
	public JPanelRiepilogoVendita(int num) {
		super();
		nome = "Cassa ".concat(String.valueOf(num));
		initialize();
	}

	/**
	 * This is the default constructor
	 */
	public JPanelRiepilogoVendita(String name) {
		super();
		this.nome = name;
		initialize();
	}

	/**
	 * This method initializes this
	 * 
	 * @return void
	 */
	private void initialize() {
		this.setSize(600, 450);
		this.setLayout(new BorderLayout());
		// this.setBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED));
		this.setBorder(javax.swing.BorderFactory.createTitledBorder(null, nome,
				javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION,
				javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, null,
				null));
		this.add(getJScrollPane(), BorderLayout.CENTER);
		scarico = new Scarico();
		this.carrello = new MyArrayList();
	}

	/**
	 * This method initializes jScrollPane
	 * 
	 * @return javax.swing.JScrollPane
	 */
	private JScrollPane getJScrollPane() {
		if (jScrollPane == null) {
			jScrollPane = new JScrollPane();
			jScrollPane.setViewportView(getTblVendite());
		}
		return jScrollPane;
	}

	/**
	 * This method initializes tblVendite
	 * 
	 * @return javax.swing.JTable
	 */
	private JTable getTblVendite() {
		try {
			if (tblVendite == null) {
				PrezzoCellRenderer prezzoRenderer = new PrezzoCellRenderer();
				// prezzoRenderer.setFont(new Font("Dialog", Font.BOLD, 16));
				QtaCellRenderer qtaRenderer = new QtaCellRenderer();
				IntegerCellRenderer ivaRenderer = new IntegerCellRenderer();

				modello = new VenditaTableModel();
				tblVendite = new JXTable();
				tblVendite.setHighlighters(new AlternateRowHighlighter());
				tblVendite.setModel(modello);

				// formattiamo le colonne prezzo
				TableColumn col = tblVendite.getColumnModel().getColumn(1);
				col.setCellRenderer(prezzoRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(90);
				col.setPreferredWidth(90);

				// formattiamo la colonna totale
				col = tblVendite.getColumnModel().getColumn(4);
				col.setCellRenderer(prezzoRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(100);
				col.setPreferredWidth(100);

				// formattiamo la colonna quantita'
				col = tblVendite.getColumnModel().getColumn(2);
				col.setCellRenderer(qtaRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(50);
				col.setPreferredWidth(50);

				// formattiamo la colonna iva
				col = tblVendite.getColumnModel().getColumn(3);
				col.setCellRenderer(ivaRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(60);
				col.setPreferredWidth(60);

				tblVendite.addMouseListener(new java.awt.event.MouseAdapter() {
					public void mouseClicked(java.awt.event.MouseEvent e) {
						if (e.getSource() == tblVendite) {
							int row = tblVendite.getSelectedRow();
							if (row == -1)
								idSelectedItem = -1;
							else {
								DettaglioScarico o = carrello.get(row);
								idSelectedItem = o.getIdArticolo();
							}
						}
					}
				});
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tblVendite;
	}

	/**
	 * Aggiunge un dettaglio ordine al carrello e se gi\340 presente aggiorna la
	 * quantit\340 ed eventuali altri parametri cambiati
	 * 
	 * @param e
	 * @return
	 */
	public int addDettaglioOrdine(DettaglioScarico ord, boolean insDiretto) {
		if (insDiretto) {
			carrello.add(ord);
		} else {
			int contiene = carrello.indexOf(ord);
			if (!carrello.contains(ord))
				if ( ord.isQtaInfinita() ){
					carrello.add(ord);
				}
				else if (ord.getDisponibilita() < ord.getQta()) {
					return -1;
				} else {
					carrello.add(ord);
				}
			else {
				DettaglioScarico tmp = carrello.get(contiene);
				// Se   un articolo a qtaInfinita o la qta   disponibile, inseriamo direttamente
				if ( ord.isQtaInfinita() || ord.getDisponibilita() >= (tmp.getQta() + ord.getQta()) ){
					// aggiungiamo alla quantita' gia' presente la nuova
					// quantita' da aggiungere
					tmp.setQta(tmp.getQta() + ord.getQta());
				}
				// Verifichiamo se la quantita' richiesta e' disponibile
//				if (ord.getDisponibilita() < (tmp.getQta() + ord.getQta())) {
				else{
					return -1;
				}
			}
		}
		// notifichiamo che e' stata aggiunta/modificata una riga;
		// modello.fireTableRowsInserted(carrello.size(), carrello.size());
		CodiciIva codiceIva=CodiciIvaHome.getInstance().findById(ord.getIva());
		double tot = ord.getPrezzoVendita() * ord.getQta();
		tot = tot + MathUtility.percentualeDaAggiungere(tot, codiceIva.getPercentuale());
		totaleCarrello = totaleCarrello + tot;
		modello.fireTableDataChanged();
		return 1;
	}
	
	private void stampaScontrino() {
		Object[] dv=carrello.toArray();
		Ticket t=new Ticket();
		for(int i=0;i<dv.length;i++){
			DettaglioScarico d=(DettaglioScarico)dv[i];
			TicketRow row=new TicketRow();
			row.setDescrizione(d.getDescrizione());
			row.setIva(new Long(d.getIva()));
			row.setPrezzo(((Number)d.getPrezzoVendita()).floatValue());
			row.setQta(((Number)d.getQta()).floatValue());
			row.setReparto(1);
			t.addTicketRow(row);
		}
		RCHDriver driver=new RCHDriver();
		try {
			driver.openDeviceConnection();
			driver.startTicket();
			driver.printTicket(t);
			driver.stopTicket();
			driver.cutTicket();
			driver.closeDeviceConnection();
		} catch (PosException e) {
			messaggioAVideo(e.getMessage(), "ERROR");
//			e.printStackTrace();
		}
		
	}

	public boolean registraScarico(boolean scontrino) {
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
		try {
			// Salviamo i dati della fattura
			Date d = new Date();
			scarico.setIdScarico(DBManager.getIstanceSingleton().getNewID(
					"scarico", "idordine"));
			scarico.setIdCliente(0);
			scarico.setOraScarico(new Time(d.getTime()));
			scarico.setDataScarico(new java.sql.Date(d.getTime()));
			scarico.setNote("Vendita al banco");
			scarico.setDataDocumento(new java.sql.Date(d.getTime()));
			scarico.setNumDocumento(Constant.getNumeroDocScaricoAlBanco());
			scarico.setIdDocumento(0);
			scarico.setIvaDocumento(Constant.CODICE_IVA_20);
			scarico.setTotaleDocumentoIvato(totaleCarrello);
			// scarico.setTipoPrezzo((String)cmbTipoPagamento.getSelectedItem());
			scarico.setDocFiscale(Constant.getScarico());
			int ok = scarico.insertScarico();

			if (ok == -1) {
				return false;
			}
			// salviamo i dettagli della fattura
			for (DettaglioScarico dv : carrello) {
				dv.setIdVendita(scarico.getIdScarico());
				if (dv.isInsert()) {
					dv.updatePrezzoVenditaPerArticoliReparto();
				} else {
					ok = dv.insert();
				}
				if (ok == -1) {
					scarico.deleteAllArticoliScaricati();
					scarico.deleteScarico(scarico.getIdScarico());
					return false;
				}
			}
			if(scontrino){
				stampaScontrino();
			}
			
			azzeraCarrello();
			return true;
		} catch (Exception e) {
			messaggioAVideo(e.getMessage(), "ERROR");
			return false;
		}
	}

	/**
	 * sostituisce il carrello corrente con il carrello che gli viene passato
	 * come parametro
	 * 
	 * @param c
	 * @return
	 */
	public boolean addAllDettaglioOrdine(Collection<DettaglioScarico> c) {
		carrello.clear();
		boolean ok = carrello.addAll(c);
		modello.fireTableDataChanged();
		return ok;
	}

	/**
	 * Cancella tutto il contenuto di un carrello
	 */
	public void azzeraCarrello() {
		carrello.clear();
		totaleCarrello = 0.0;
		idSelectedItem = -1;
		modello.fireTableDataChanged();
	}

	/**
	 * 
	 * @param o
	 * @return
	 */
	public boolean containsDettaglioOrdine(DettaglioScarico ord) {
		return carrello.contains(ord);
	}

	/**
	 * Interroga se il carrello \340 vuoto oppure no
	 * 
	 * @return
	 */
	public boolean isEmpty() {
		return carrello.isEmpty();
	}

	/**
	 * Ritorna un iteratore al carrello per scorrere tutti gli oggetti
	 * DettaglioOrdine
	 * 
	 * @return
	 */
	public Iterator<DettaglioScarico> iterator() {
		return carrello.iterator();
	}

	/**
	 * Rimuove un oggetto DettaglioOrdine dal carrello
	 * 
	 * @param o
	 * @return
	 */
	public boolean removeDettaglioOrdine(DettaglioScarico ord) {
		boolean ok = carrello.remove(ord);
		modello.fireTableRowsDeleted(carrello.size() + 1, carrello.size() + 1);
		return ok;
	}

	/**
	 * rimuove tutti gli oggetti passati nella collection c
	 * 
	 * @param c
	 * @return
	 */
	public boolean removeAllDettaglioOrdine(Collection<DettaglioScarico> c) {
		boolean ok = carrello.removeAll(c);
		modello.fireTableDataChanged();
		return ok;
	}

	/**
	 * ritorna la grandezza del carrello e quindi il numero degli oggetti in
	 * elenco che corrisponde in modo semplice alle righe della tabella.
	 * 
	 * @return
	 */
	public int getNumeroItemNelCarrello() {
		return carrello.size();
	}

	/**
	 * Restituisce un array di DettaglioOrdine
	 * 
	 * @return
	 */
	public DettaglioScarico[] toArray() {
		return (DettaglioScarico[]) carrello.toArray();
	}
	
	public MyArrayList getCarrello(){
		return this.carrello;
	}

	// gestire i casi di aggiornamento negativo
	public void aggiornaQtaSelectedItem(int qta) {
		for (DettaglioScarico dv : carrello) {
			if (dv.getIdArticolo() == idSelectedItem)
				dv.setQta(qta + dv.getQta());
		}
		modello.fireTableDataChanged();
	}

	/**
	 * Metodo che si occupa di eliminare un articolo dal carrello, se una riga
	 * e' stata selezionata viene eliminata, altrimenti si elimina l'ultima riga
	 * inserita
	 * 
	 */
	public void stornoArticolo() {
		if (carrello.size() != 0) {
			int selectedRow = tblVendite.getSelectedRow();
			if (selectedRow == -1) {
				DettaglioScarico ord = carrello.get(carrello.size() - 1);
				carrello.remove(ord);
				double tot = ord.getPrezzoVendita() * ord.getQta();
				totaleCarrello = totaleCarrello
						- (tot + MathUtility.percentualeDaAggiungere(tot, ord
								.getIva()));
			} else {
				DettaglioScarico ord = carrello.get(selectedRow);
				carrello.remove(ord);
				double tot = ord.getPrezzoVendita() * ord.getQta();
				totaleCarrello = totaleCarrello
						- (tot + MathUtility.percentualeDaAggiungere(tot, ord
								.getIva()));
			}
			modello.fireTableDataChanged();
		}
	}

	/**
	 * Metodo che si occupa di ridurre di una unita' la quantita' della riga
	 * selezionata, se nessuna linea e' selezionata diminuisce la quantita'
	 * dell'ultima riga
	 * 
	 */
	public void stornoQtaArticolo() {
		if (carrello.size() != 0) {
			int selectedRow = tblVendite.getSelectedRow();
			if (selectedRow == -1) {
				DettaglioScarico ord = carrello.get(carrello.size() - 1);
				if (ord.getQta() == 1) {
					carrello.remove(ord);
					totaleCarrello = totaleCarrello
							- (ord.getPrezzoVendita() + MathUtility
									.percentualeDaAggiungere(ord
											.getPrezzoVendita(), ord.getIva()));
					modello.fireTableDataChanged();
					return;
				} else {
					ord.setQta(ord.getQta() - 1);
					totaleCarrello = totaleCarrello
							- (ord.getPrezzoVendita() + MathUtility
									.percentualeDaAggiungere(ord
											.getPrezzoVendita(), ord.getIva()));
					modello.fireTableDataChanged();
					return;
				}
			} else {
				DettaglioScarico ord = carrello.get(selectedRow);
				if (ord.getQta() == 1) {
					carrello.remove(ord);
					totaleCarrello = totaleCarrello
							- (ord.getPrezzoVendita() + MathUtility
									.percentualeDaAggiungere(ord
											.getPrezzoVendita(), ord.getIva()));
					modello.fireTableDataChanged();
					return;
				} else {
					ord.setQta(ord.getQta() - 1);
					totaleCarrello = totaleCarrello
							- (ord.getPrezzoVendita() + MathUtility
									.percentualeDaAggiungere(ord
											.getPrezzoVendita(), ord.getIva()));
					modello.fireTableDataChanged();
					return;
				}
			}
		}
	}

	/**
	 * Ritorna id dell'oggetto selezionato nella tabella
	 * 
	 * @return ritorna id se \340 selezionato un oggetto nella tabella oppure
	 *         ritorna -1 se non c'\340 nessuna selezione
	 */
	public int getIdSelectedItem() {
		return idSelectedItem;
	}
	
	
	public VenditaTableModel getModel(){
		return this.modello;
	}

	public void clearSelectionItem() {
		tblVendite.clearSelection();
		idSelectedItem = -1;
	}

	public Double getTotaleCarrello() {
		return totaleCarrello;
	}

	public void setTotaleCarrello(Double totaleCarrello) {
		this.totaleCarrello = totaleCarrello;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public void addTableModelListener(TableModelListener modelListener){
		if(tblVendite!=null){
			tblVendite.getModel().addTableModelListener(modelListener);
		}
	}
	
	private void messaggioAVideo(String testo, String tipo) {
		JOptionPane.showMessageDialog(InitialGUI.getMainInstance(), testo, tipo,
				JOptionPane.INFORMATION_MESSAGE);
	}
}