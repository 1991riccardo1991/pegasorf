/**
 * 
 */
package rf.pegaso.gui.gestione;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.BevelBorder;
import javax.swing.border.TitledBorder;

import rf.pegaso.db.tabelle.Reparto;
import rf.utility.db.DBManager;
import rf.utility.gui.UtilGUI;
import rf.utility.gui.text.UpperTextDocument;

/**
 * @author Hunter
 * 
 */
public class RepartiAdd extends JDialog {
	class MyActionListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource() == btnChiudi) {
				dispose();
			}
			if (e.getSource() == btnInserisci) {
				inserisci();
			}

		}

	}

	private static final long serialVersionUID = 1L;

	private JButton btnChiudi = null;

	private JButton btnInserisci = null;

	private DBManager dbm;

	private JPanel jContentPane = null;

	private JLabel jLabel1 = null;

	private JLabel jLabel2 = null;

	private JPanel jPanel = null;

	private JPanel pnlCentrale = null;

	private JTextField txtDescrizione = null;

	private JTextField txtNome = null;

	/**
	 * @param owner
	 */
	public RepartiAdd(JDialog owner, DBManager dbm) {
		super(owner, true);
		this.dbm = dbm;
		initialize();
	}
	
	public RepartiAdd(JFrame owner, DBManager dbm) {
		super(owner, true);
		this.dbm = dbm;
		initialize();
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
				btnChiudi.setText("Chiudi"); // Generated
				btnChiudi.setPreferredSize(new Dimension(83, 26)); // Generated
				btnChiudi.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return btnChiudi;
	}

	/**
	 * This method initializes btnInserisci
	 * 
	 * @return javax.swing.JButton
	 */
	private JButton getBtnInserisci() {
		if (btnInserisci == null) {
			try {
				btnInserisci = new JButton();
				btnInserisci.setText("Inserisci"); // Generated
				btnInserisci.addActionListener(new MyActionListener());
				;
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return btnInserisci;
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
				jPanel.add(getBtnInserisci(), null); // Generated
				jPanel.add(getBtnChiudi(), null); // Generated
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return jPanel;
	}

	/**
	 * This method initializes pnlCentrale
	 * 
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlCentrale() {
		if (pnlCentrale == null) {
			try {
				jLabel2 = new JLabel();
				jLabel2.setText("Descrizione"); // Generated
				jLabel2.setBounds(new Rectangle(249, 34, 67, 16)); // Generated
				jLabel1 = new JLabel();
				jLabel1.setText("Nome Categoria"); // Generated
				jLabel1.setBounds(new Rectangle(11, 34, 114, 16)); // Generated
				pnlCentrale = new JPanel();
				pnlCentrale.setLayout(null); // Generated
				pnlCentrale.setBorder(BorderFactory.createTitledBorder(
						BorderFactory.createBevelBorder(BevelBorder.RAISED),
						"Dati Categorie", TitledBorder.DEFAULT_JUSTIFICATION,
						TitledBorder.DEFAULT_POSITION, new Font("Dialog",
								Font.BOLD, 12), new Color(51, 51, 51))); // Generated
				pnlCentrale.add(jLabel1, null); // Generated
				pnlCentrale.add(jLabel2, null); // Generated
				pnlCentrale.add(getTxtNome(), null); // Generated
				pnlCentrale.add(getTxtDescrizione(), null); // Generated
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return pnlCentrale;
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
				txtDescrizione.setPreferredSize(new Dimension(250, 20)); // Generated
				txtDescrizione.setBounds(new Rectangle(249, 50, 278, 20)); // Generated
				txtDescrizione.setDocument(new UpperTextDocument());
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return txtDescrizione;
	}

	/**
	 * This method initializes txtNome
	 * 
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtNome() {
		if (txtNome == null) {
			try {
				txtNome = new JTextField();
				txtNome.setPreferredSize(new Dimension(200, 20)); // Generated
				txtNome.setBounds(new Rectangle(11, 50, 228, 20)); // Generated
				txtNome.setDocument(new UpperTextDocument());
			} catch (java.lang.Throwable e) {
				// TODO: Something
			}
		}
		return txtNome;
	}

	/**
	 * This method initializes this
	 * 
	 * @return void
	 */
	private void initialize() {
		this.setSize(547, 162);
		this.setTitle("Inserimento Categorie"); // Generated
		this.setContentPane(getJContentPane());

		UtilGUI.centraDialog(this);
	}

	private void inserisci() {
		Reparto r = new Reparto();
		r.setDescrizione(this.txtDescrizione.getText());
		r.setNome(this.txtNome.getText());
		r.insertReparto();
		dispose();

	}

} // @jve:decl-index=0:visual-constraint="10,10"
