package rf.pegaso.gui.primanota;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.Rectangle;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Date;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFormattedTextField;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.BevelBorder;
import javax.swing.border.TitledBorder;

import rf.myswing.IDJComboBox;
import rf.pegaso.db.tabelle.Carico;
import rf.pegaso.db.tabelle.Cliente;
import rf.pegaso.db.tabelle.Documento;
import rf.pegaso.db.tabelle.Fornitore;
import rf.utility.db.UtilityDBManager;
import rf.utility.db.eccezzioni.IDNonValido;
import rf.utility.gui.UtilGUI;
import rf.utility.gui.text.AutoCompletion;
import rf.utility.gui.text.UpperTextDocument;

import com.toedter.calendar.JDateChooser;

public class ModificaUscita extends JDialog {

	public static final int USCITA = 0;
	private JPanel jContentPane = null;
	private JPanel jPanel = null;
	private JPanel pnlCentro = null;
	private JDateChooser dataDocumento = null;
	private JLabel lblDataDocumento = null;
	private JLabel lblTipoDocumento = null;
	private IDJComboBox cmbTipoDocumento = null;
	private JButton btnNuovoDoc = null;
	private JLabel lblCliente = null;
	private IDJComboBox cmbClienti = null;
	private JPanel pnlNote = null;
	private JScrollPane jScrollPane1 = null;
	private JTextArea txtNote = null;
	private JLabel lblTot = null;
	private JFormattedTextField txtTotale = null;
	private DecimalFormat formatPrice = null;
	private JLabel lblNumDocumento = null;
	private JTextField txtNumDocumento = null;
	private JPanel jPanel1 = null;
	private JButton jButton = null;
	private int id;
	private int modalita;
	private JLabel lblIvaDocUscite = null;
	private JFormattedTextField txtIvaDocUscita = null;
	private NumberFormat f1 = null;

	/**
	 * This method initializes
	 *
	 */
	public ModificaUscita(int id,Frame padre) {
		super(padre,true);
		this.id=id;
		initialize();
	}

	public ModificaUscita(int ID, Frame padre, int modalita) {
		super(padre,true);
		this.id=id;
		this.modalita=modalita;
		initialize();
	}

	/**
	 * This method initializes this
	 *
	 */
	private void initialize() {
        this.setSize(new Dimension(700, 207));


         this.setTitle("Modifica Entrata");
        this.setContentPane(getJContentPane());

        UtilGUI.centraDialog(this);
        caricaDati();

	}

	private void caricaClienti(JComboBox cmbFornitori) {
		Cliente c = new Cliente();
		try {

			String as[] = (String[]) c.allClienti();
			// carichiamo tutti i dati in due array
			// da passre al combobox
			((IDJComboBox) cmbClienti).caricaNewValueComboBox(as, false);
		} catch (SQLException e) {
			messaggioCampoMancante("Errore caricamento clienti nel combobox", "ERRORE");
			e.printStackTrace();
		}
		AutoCompletion.enable(cmbClienti);
	}

	private void caricaDocumenti(JComboBox cmbDocumenti) {

		Documento f = new Documento();
		try {

			String as[] = (String[]) f.allDocumentiConDescrizione();
			// carichiamo tutti i dati in due array
			// da passre al combobox
			((IDJComboBox) cmbDocumenti).caricaNewValueComboBox(as, false);
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
			((IDJComboBox) cmbFornitori).caricaNewValueComboBox(as, false);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this,
					"Errore caricamento fornitori nel combobox", "ERRORE", 0);
			e.printStackTrace();
		}
		AutoCompletion.enable(cmbFornitori);
	}

	private void caricaDati() {
		caricaFornitori(cmbClienti);
		caricaDocumenti(cmbTipoDocumento);
		Carico s=new Carico();
		try {
			s.caricaDati(id);
			dataDocumento.setDate(s.getDataDocumento());
			cmbTipoDocumento.setSelectedItemByID(s.getIdDocumento());
			cmbClienti.setSelectedItemByID(s.getIdFornitore());
			txtNote.setText(s.getNote());
			txtNumDocumento.setText(s.getNumDocumento());
			txtTotale.setValue(new Double(s.getTotaleIvato()));
			txtIvaDocUscita.setValue(s.getIva_doc());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

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
			jContentPane.add(getJPanel(), BorderLayout.CENTER);
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
			jPanel = new JPanel();
			jPanel.setLayout(new BorderLayout());
			jPanel.add(getPnlCentro(), BorderLayout.CENTER);
			jPanel.add(getJPanel1(), BorderLayout.NORTH);
		}
		return jPanel;
	}

	/**
	 * This method initializes pnlCentro
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlCentro() {
		if (pnlCentro == null) {
			lblIvaDocUscite = new JLabel();
			lblIvaDocUscite.setBounds(new Rectangle(5, 95, 91, 26));
			lblIvaDocUscite.setText("Iva Documento");
			lblNumDocumento = new JLabel();
			lblNumDocumento.setBounds(new Rectangle(6, 66, 91, 25));
			lblNumDocumento.setText("N� Documento");
			lblTot = new JLabel();
			lblTot.setBounds(new Rectangle(192, 66, 43, 25));
			lblTot.setText("Totale");
			lblCliente = new JLabel();
			lblCliente.setBounds(new Rectangle(6, 36, 59, 25));
			lblCliente.setText("Fornitori");
			lblTipoDocumento = new JLabel();
			lblTipoDocumento.setBounds(new Rectangle(234, 6, 103, 25));
			lblTipoDocumento.setText("Tipo Documento");
			lblTipoDocumento.setHorizontalAlignment(2);
			lblDataDocumento = new JLabel();
			lblDataDocumento.setBounds(new Rectangle(6, 6, 103, 25));
			lblDataDocumento.setText("Data Documento");
			pnlCentro = new JPanel();
			pnlCentro.setLayout(null);
			pnlCentro.setPreferredSize(new Dimension(0, 120));
			pnlCentro.setBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED));
			pnlCentro.add(getDataDocumento(), null);
			pnlCentro.add(lblDataDocumento, null);
			pnlCentro.add(lblTipoDocumento, null);
			pnlCentro.add(getCmbTipoDocumento(), null);
			pnlCentro.add(getBtnNuovoDoc(), null);
			pnlCentro.add(lblCliente, null);
			pnlCentro.add(getCmbClienti(), null);
			pnlCentro.add(getPnlNote(), null);
			pnlCentro.add(lblTot, null);
			pnlCentro.add(getTxtTotale(), null);
			pnlCentro.add(lblNumDocumento, null);
			pnlCentro.add(getTxtNumDocumento(), null);
			pnlCentro.add(lblIvaDocUscite, null);
			pnlCentro.add(getTxtIvaDocUscita(), null);
		}
		return pnlCentro;
	}

	/**
	 * This method initializes dataDocumento
	 *
	 * @return com.toedter.calendar.JDateChooser
	 */
	private JDateChooser getDataDocumento() {
		if (dataDocumento == null) {
			dataDocumento = new JDateChooser("dd/MM/yyyy", "##/##/##", '_');
			dataDocumento.setBounds(new Rectangle(114, 6, 115, 25));
			dataDocumento.setDate(new Date());
		}
		return dataDocumento;
	}

	/**
	 * @param string
	 */
	private void messaggioCampoMancante(String testo, String tipo) {
		JOptionPane.showMessageDialog(this, testo, tipo,
				JOptionPane.INFORMATION_MESSAGE);
	}

	/**
	 * This method initializes cmbTipoDocumento
	 *
	 * @return rf.myswing.IDJComboBox
	 */
	private IDJComboBox getCmbTipoDocumento() {
		if (cmbTipoDocumento == null) {
			cmbTipoDocumento = new IDJComboBox();
			cmbTipoDocumento.setBounds(new Rectangle(343, 6, 258, 25));
		}
		return cmbTipoDocumento;
	}

	/**
	 * This method initializes btnNuovoDoc
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnNuovoDoc() {
		if (btnNuovoDoc == null) {
			btnNuovoDoc = new JButton();
			btnNuovoDoc.setBounds(new Rectangle(606, 6, 79, 25));
			btnNuovoDoc.setText("Nuovo");
		}
		return btnNuovoDoc;
	}

	/**
	 * This method initializes cmbClienti
	 *
	 * @return rf.myswing.IDJComboBox
	 */
	private IDJComboBox getCmbClienti() {
		if (cmbClienti == null) {
			cmbClienti = new IDJComboBox();
			cmbClienti.setBounds(new Rectangle(72, 36, 313, 25));
		}
		return cmbClienti;
	}

	/**
	 * This method initializes pnlNote
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlNote() {
		if (pnlNote == null) {
			pnlNote = new JPanel();
			pnlNote.setLayout(new BorderLayout());
			pnlNote.setBounds(new Rectangle(392, 36, 293, 79));
			pnlNote.setBorder(BorderFactory.createTitledBorder(null, "Note", TitledBorder.DEFAULT_JUSTIFICATION, TitledBorder.DEFAULT_POSITION, new Font("Dialog", Font.BOLD, 12), new Color(51, 51, 51)));
			pnlNote.add(getJScrollPane1(), BorderLayout.CENTER);
		}
		return pnlNote;
	}

	/**
	 * This method initializes jScrollPane1
	 *
	 * @return javax.swing.JScrollPane
	 */
	private JScrollPane getJScrollPane1() {
		if (jScrollPane1 == null) {
			jScrollPane1 = new JScrollPane();
			jScrollPane1.setViewportView(getTxtNote());
		}
		return jScrollPane1;
	}

	/**
	 * This method initializes txtNote
	 *
	 * @return javax.swing.JTextArea
	 */
	private JTextArea getTxtNote() {
		if (txtNote == null) {
			txtNote = new JTextArea();
		}
		return txtNote;
	}

	/**
	 * This method initializes formatPrice
	 *
	 * @return java.text.DecimalFormat
	 */
	private DecimalFormat getFormatPrice() {
		if (formatPrice == null) {
			formatPrice = new DecimalFormat();
			formatPrice.setMinimumFractionDigits(2);
			formatPrice.setMaximumFractionDigits(2);
		}
		return formatPrice;
	}

	/**
	 * This method initializes txtTotale
	 *
	 * @return javax.swing.JFormattedTextField
	 */
	private JFormattedTextField getTxtTotale() {
		if (txtTotale == null) {
			txtTotale = new JFormattedTextField(getFormatPrice());
			txtTotale.setBounds(new Rectangle(240, 66, 97, 25));
			txtTotale.setDocument(new UpperTextDocument());
			txtTotale.setHorizontalAlignment(JTextField.RIGHT);
			txtTotale.setValue(new Double(0));
			txtTotale.setPreferredSize(new Dimension(100, 20));
		}
		return txtTotale;
	}

	/**
	 * This method initializes txtNumDocumento
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtNumDocumento() {
		if (txtNumDocumento == null) {
			txtNumDocumento = new JTextField();
			txtNumDocumento.setBounds(new Rectangle(102, 66, 85, 25));
		}
		return txtNumDocumento;
	}

	/**
	 * This method initializes jPanel1
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getJPanel1() {
		if (jPanel1 == null) {
			FlowLayout flowLayout = new FlowLayout();
			flowLayout.setAlignment(FlowLayout.LEFT);
			jPanel1 = new JPanel();
			jPanel1.setLayout(flowLayout);
			jPanel1.setPreferredSize(new Dimension(0, 40));
			jPanel1.add(getJButton(), null);
		}
		return jPanel1;
	}

	/**
	 * This method initializes jButton
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getJButton() {
		if (jButton == null) {
			jButton = new JButton();
			jButton.setText("Modifica");
			jButton.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					modifica();
				}
			});
		}
		return jButton;
	}

	protected void modifica() {

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

		Carico c = new Carico();
		try {
			c.caricaDati(id);
			c.setIdFornitore((new Integer(cmbClienti.getIDSelectedItem())).intValue());
			c
					.setDataCarico(new java.sql.Date(dataDocumento.getDate()
							.getTime()));
			c.setOraCarico((new Time(dataDocumento.getDate().getTime())));
			c.setNote(txtNote.getText());
			c.setDataDocumento(new java.sql.Date(dataDocumento.getDate()
					.getTime()));
			c.setNumDocumento(txtNumDocumento.getText());
			c.setIdDocumento(0);
			Object t=txtTotale.getValue();
			if(t instanceof Double)
				c.setTotaleDocumentoIvato(((Double)txtTotale.getValue()).doubleValue());
			else{
				long tmp=((Long)txtTotale.getValue()).longValue();
				c.setTotaleDocumentoIvato(new Double(tmp).doubleValue());
			}
			c.setIva_doc(((Number) txtIvaDocUscita.getValue()).intValue());
			c.setIdDocumento((new Integer(cmbTipoDocumento.getIDSelectedItem())).intValue());
			c.updateCarico();

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IDNonValido e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}



	/**
	 * This method initializes txtIvaDocUscita
	 *
	 * @return javax.swing.JFormattedTextField
	 */
	private JFormattedTextField getTxtIvaDocUscita() {
		if (txtIvaDocUscita == null) {
			f1 = NumberFormat.getIntegerInstance();
			txtIvaDocUscita = new JFormattedTextField(f1);
			txtIvaDocUscita.setBounds(new Rectangle(100, 95, 86, 26));
			txtIvaDocUscita.setValue(20);
		}
		return txtIvaDocUscita;
	}

}  //  @jve:decl-index=0:visual-constraint="10,10"
