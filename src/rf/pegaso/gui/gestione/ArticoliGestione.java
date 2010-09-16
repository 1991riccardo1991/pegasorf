/**
 *
 */
package rf.pegaso.gui.gestione;

import it.infolabs.hibernate.Reparto;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSeparator;
import javax.swing.JTable;
import javax.swing.RowFilter;
import javax.swing.WindowConstants;
import javax.swing.border.BevelBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;
import javax.swing.table.TableRowSorter;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.view.JasperViewer;

import rf.pegaso.db.exception.CodiceBarreInesistente;
import rf.pegaso.db.model.ArticoloModel;
import rf.pegaso.db.tabelle.Articolo;
import rf.pegaso.gui.internalframe.VenditaInternalFrame;
import rf.utility.db.DBManager;
import rf.utility.db.eccezzioni.CodiceBarreEsistente;
import rf.utility.db.eccezzioni.IDNonValido;
import rf.utility.gui.UtilGUI;
import rf.utility.gui.text.UpperTextDocument;

import java.awt.FlowLayout;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

import org.jdesktop.swingx.JXTable;
import org.jdesktop.swingx.decorator.AlternateRowHighlighter;

import java.awt.Font;
import java.awt.Color;

/**
 * @author Hunter
 *
 */
public class ArticoliGestione extends JFrame {
	class MyActionListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			if (e.getSource() == btnNuovo) {
				nuovoArticolo();
			} else if (e.getSource() == btnModifica) {
				modificaArticolo();
			} else if (e.getSource() == btnElimina) {
				eliminaArticolo();
			} else if (e.getSource() == btnChiudi) {
				dispose();
			} else if (e.getSource() == btnDuplica) {
				duplicaArticolo();
			} else if (e.getSource() == btnStampa) {
				stampaArticoli();
			}

		}

	}
	
	class MyMouseAdapter extends MouseAdapter{

		@Override
		public void mouseClicked(MouseEvent e) {
			if (e.getSource() == tblArticoli && e.getClickCount() == 2) {
				modificaArticolo();				
			}
		}
		
	}
	
	private MyMouseAdapter myMouseadapter;  //  @jve:decl-index=0:

	private static final long serialVersionUID = 1L;

	private JButton btnChiudi = null;

	private JButton btnElimina = null;

	private JButton btnModifica = null;

	private JButton btnNuovo = null;

	private DBManager dbm;

	private JPanel jContentPane = null;

	private JScrollPane jScrollPane = null;

	private JSeparator jSeparator = null;

	//private Frame padre;

	private JPanel pnlCentrale = null;

	private JPanel pnlNord = null;

	private JTable tblArticoli = null;

	private JButton btnDuplica = null;

	private JButton btnStampa = null;

	private JPanel jPanel = null;

	private JPanel jPanel1 = null;

	private JLabel lblFiltroCodice = null;

	private JTextField txtFiltroCodice = null;

	private JLabel lblFiltroDescrizione = null;

	private JTextField txtFiltroDescrizione = null;

	private TableRowSorter<ArticoloModel> sorter;
	
	private final static int RICERCA = 1;
	
	private final static int NORMALE = 0;
	
	private int modalita;
	
	private Reparto reparto;
	
	private VenditaInternalFrame padre;

	/**
	 * @param owner
	 */
	public ArticoliGestione() {
		//this.padre = padre;
		//this.padre.setEnabled(false);
		this.dbm = DBManager.getIstanceSingleton();
		this.modalita = NORMALE;
		initialize();
	}
	
	public ArticoliGestione(VenditaInternalFrame padre, Reparto rep){
		this.dbm = DBManager.getIstanceSingleton();
		this.padre = padre;
		this.modalita = RICERCA;
		this.reparto = rep;
		initialize();
	}

	protected void stampaArticoli() {
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler stampare l'elenco articoli?", "AVVISO",
				JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
		if (scelta != JOptionPane.YES_OPTION) {
			return;
		}

		try {
			JasperViewer.viewReport(JasperFillManager.fillReport(
					"report/elenco_articoli.jasper", null, this.dbm
							.getConnessione()), false);

		} catch (JRException e) {
			//
			e.printStackTrace();
		}

	}

	public void duplicaArticolo() {
		if (tblArticoli.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un Articolo",
					"AVVISO", JOptionPane.INFORMATION_MESSAGE);
			return;
		}
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler duplicare\nl'articolo selezionato?",
				"AVVISO", JOptionPane.YES_NO_OPTION,
				JOptionPane.INFORMATION_MESSAGE);
		if (scelta != JOptionPane.YES_OPTION)
			return;

		int riga = tblArticoli.getSelectedRow();
		int idArticolo = ((Long) tblArticoli.getValueAt(riga, 0)).intValue();
		Articolo r = new Articolo();
		int idNewArticolo = 0;
		try {
			idNewArticolo = r.duplicaArticolo(idArticolo);

			// ora apriamo la finestra per modificare i dati
			ArticoloAddMod mod = new ArticoloAddMod((JFrame)this, idNewArticolo,ArticoloAddMod.MOD);
			mod.setVisible(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IDNonValido e) {
			e.printStackTrace();
		} catch (CodiceBarreEsistente e) {
			e.printStackTrace();
		} catch (CodiceBarreInesistente e) {
			e.printStackTrace();
		}

	}

	/**
	 * Elimina il reparto dalla base di dati
	 */
	private void eliminaArticolo() {
		if (tblArticoli.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", JOptionPane.INFORMATION_MESSAGE);
			return;
		}
		int scelta = JOptionPane.showConfirmDialog(this,
				"Sei sicuro di voler eliminare\nl'articolo selezionato?",
				"AVVISO", JOptionPane.YES_NO_OPTION,
				JOptionPane.INFORMATION_MESSAGE);
		if (scelta != JOptionPane.YES_OPTION)
			return;
		int nSel = tblArticoli.getSelectedRowCount();
		int riga = 0;
		int righe[] = null;
		if (nSel == 1) {
			riga = tblArticoli.getSelectedRow();
			int idArticolo = ((Long) tblArticoli.getValueAt(riga, 0))
					.intValue();
			Articolo r = new Articolo();
			try {
				r.deleteArticolo(idArticolo);
			} catch (IDNonValido e) {
				JOptionPane.showMessageDialog(this, "Valore idArticolo errato",
						"ERRORE", JOptionPane.WARNING_MESSAGE);
				e.printStackTrace();
			}
		} else {
			righe = tblArticoli.getSelectedRows();
			int idRighe[] = new int[righe.length];
			// Prendiamo tutti gli id degli articoli
			// che sono stati selezionati
			for (int i = 0; i < righe.length; i++) {
				int idArticolo = ((Long) tblArticoli.getValueAt(righe[i], 0))
						.intValue();
				idRighe[i] = idArticolo;
			}
			// Cancelliamo tutte le righe
			// che sono state selezionate
			for (int i = 0; i < idRighe.length; i++) {
				int idArticolo = idRighe[i];
				Articolo r = new Articolo();
				try {
					r.deleteArticolo(idArticolo);
				} catch (IDNonValido e) {
					JOptionPane.showMessageDialog(this,
							"Valore idArticolo errato", "ERRORE",
							JOptionPane.WARNING_MESSAGE);
					e.printStackTrace();
				}
			}
		}

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
				btnChiudi.setBounds(new Rectangle(471, 5, 77, 25)); // Generated
				btnChiudi.setText("Chiudi");
				btnChiudi.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnChiudi;
	}

	/**
	 * This method initializes btnElimina
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnElimina() {
		if (btnElimina == null) {
			try {
				btnElimina = new JButton();
				btnElimina.setText("Elimina"); // Generated
				btnElimina.setBounds(new Rectangle(378, 5, 82, 26)); // Generated
				btnElimina.setPreferredSize(new Dimension(82, 26)); // Generated
				btnElimina.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnElimina;
	}

	/**
	 * This method initializes btnModifica
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnModifica() {
		if (btnModifica == null) {
			try {
				btnModifica = new JButton();
				btnModifica.setText("Modifica"); // Generated
				btnModifica.setBounds(new Rectangle(102, 5, 82, 26)); // Generated
				btnModifica.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnModifica;
	}

	/**
	 * This method initializes btnNuovo
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnNuovo() {
		if (btnNuovo == null) {
			try {
				btnNuovo = new JButton();
				btnNuovo.setText("Nuovo"); // Generated
				btnNuovo.setBounds(new Rectangle(9, 5, 82, 26)); // Generated
				btnNuovo.setText("Nuovo"); // Generated
				btnNuovo.setPreferredSize(new Dimension(82, 26)); // Generated
				btnNuovo.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnNuovo;
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
			if ( this.modalita != RICERCA ){				
			jContentPane.add(getPnlNord(), BorderLayout.NORTH); // Generated
			}
			jContentPane.add(getJPanel(), BorderLayout.CENTER);
		}
		return jContentPane;
	}

	/**
	 * This method initializes jScrollPane
	 *
	 * @return javax.swing.JScrollPane
	 */
	private JScrollPane getJScrollPane() {
		if (jScrollPane == null) {
			try {
				jScrollPane = new JScrollPane();
				jScrollPane.setViewportView(getTblArticoli()); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jScrollPane;
	}

	/**
	 * This method initializes jSeparator
	 *
	 * @return javax.swing.JSeparator
	 */
	private JSeparator getJSeparator() {
		if (jSeparator == null) {
			try {
				jSeparator = new JSeparator();
				jSeparator.setBounds(new Rectangle(0, 0, 0, 0)); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return jSeparator;
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
				pnlCentrale.add(getJScrollPane(), BorderLayout.CENTER); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return pnlCentrale;
	}

	/**
	 * This method initializes pnlNord
	 *
	 * @return javax.swing.JPanel
	 */
	private JPanel getPnlNord() {
		if (pnlNord == null) {
			try {
				pnlNord = new JPanel();
				pnlNord.setLayout(null); // Generated
				pnlNord.setPreferredSize(new Dimension(0, 40)); // Generated
				pnlNord.setBorder(BorderFactory
						.createBevelBorder(BevelBorder.RAISED)); // Generated
				pnlNord.add(getBtnNuovo(), null); // Generated
				pnlNord.add(getBtnModifica(), null); // Generated
				pnlNord.add(getBtnElimina(), null); // Generated
				pnlNord.add(getJSeparator(), null); // Generated
				pnlNord.add(getBtnChiudi(), null); // Generated
				pnlNord.add(getBtnDuplica(), null); // Generated
				pnlNord.add(getBtnStampa(), null); // Generated
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return pnlNord;
	}

	/**
	 * This method initializes tblArticoli
	 *
	 * @return javax.swing.JTable
	 */
	private JTable getTblArticoli() {
		if (tblArticoli == null) {
			try {
				ArticoloModel modello;
				if ( modalita == RICERCA ){
					modello = new ArticoloModel(reparto);
				}
				else{
					modello = new ArticoloModel();
				}
				dbm.addDBStateChange(modello);
				sorter=new TableRowSorter<ArticoloModel>(modello);
				tblArticoli = new JTable(modello);
				tblArticoli.setRowSorter(sorter);
//				tblArticoli.setHighlighters(new AlternateRowHighlighter());
				// tblArticoli.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

				tblArticoli.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
				//tblArticoli.packAll();
				tblArticoli.getTableHeader().setReorderingAllowed(false);

//				 impostiamo le varie colonne
				TableColumn col = tblArticoli.getColumnModel().getColumn(0);
				col.setMinWidth(0);
				col.setMaxWidth(0);
				col.setPreferredWidth(0);

				col = tblArticoli.getColumn("Codice");
				DefaultTableCellRenderer colFormatoRenderer = new DefaultTableCellRenderer();
				colFormatoRenderer.setHorizontalAlignment(JLabel.LEFT);
				col.setCellRenderer(colFormatoRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(150);
				col.setPreferredWidth(150);

				col = tblArticoli.getColumn("Descrizione");
				DefaultTableCellRenderer ColTipoRenderer = new DefaultTableCellRenderer();
				ColTipoRenderer.setHorizontalAlignment(JLabel.LEFT);
				col.setCellRenderer(ColTipoRenderer);

				col = tblArticoli.getColumn("Prezzo Acquisto");
				DefaultTableCellRenderer prezzoColumnRenderer = new DefaultTableCellRenderer();
				prezzoColumnRenderer.setHorizontalAlignment(JLabel.RIGHT);
				col.setCellRenderer(prezzoColumnRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(100);
				col.setPreferredWidth(100);

				col = tblArticoli.getColumn("Prezzo Listino");
				DefaultTableCellRenderer prezzoListinoColumnRenderer = new DefaultTableCellRenderer();
				prezzoListinoColumnRenderer.setHorizontalAlignment(JLabel.RIGHT);
				col.setCellRenderer(prezzoListinoColumnRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(100);
				col.setPreferredWidth(100);
				
				col = tblArticoli.getColumn("Iva %");
				DefaultTableCellRenderer ivaColumnRenderer = new DefaultTableCellRenderer();
				ivaColumnRenderer.setHorizontalAlignment(JLabel.CENTER);
				col.setCellRenderer(ivaColumnRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(50);
				col.setPreferredWidth(50);

				col = tblArticoli.getColumn("Fornitore");
				DefaultTableCellRenderer fornitoreRenderer = new DefaultTableCellRenderer();
				fornitoreRenderer.setHorizontalAlignment(JLabel.LEFT);
				col.setCellRenderer(fornitoreRenderer);
				col.setMinWidth(0);
				col.setMaxWidth(250);
				col.setPreferredWidth(250);


			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return tblArticoli;
	}

	/**
	 * This method initializes this
	 *
	 * @return void
	 */
	private void initialize() {
		this.setSize(new Dimension(700, 500));
		this.setTitle("Gestione Articoli");
		this.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE); // Generated
		this.setContentPane(getJContentPane());
		this.addWindowListener(new java.awt.event.WindowAdapter() {
			public void windowClosed(java.awt.event.WindowEvent e) {
				setEnabled(true);
			}

			public void windowClosing(java.awt.event.WindowEvent e) {
				setEnabled(true);
			}
		});
		setExtendedState(MAXIMIZED_BOTH);
		UtilGUI.centraFrame(this);
		myMouseadapter=new MyMouseAdapter();
		tblArticoli.addMouseListener(myMouseadapter);
	}

	/**
	 *
	 */
	private void modificaArticolo() {
		// Apre la Dialog delegata alla modifica
		// di un reparto
		if (tblArticoli.getSelectedRow() <= -1) {
			JOptionPane.showMessageDialog(this, "Selezionare un righa",
					"AVVISO", JOptionPane.INFORMATION_MESSAGE);
			return;
		}
		int riga = tblArticoli.getSelectedRow();
		int idArticolo = ((Long) tblArticoli.getValueAt(riga, 0)).intValue();
		ArticoloAddMod mod = new ArticoloAddMod(this,idArticolo,ArticoloAddMod.MOD);
		mod.setVisible(true);
		tblArticoli.setRowSelectionInterval(riga, riga);

	}

	/**
	 *
	 */
	private void nuovoArticolo() {
		// Apre la finestra delegata all'inserimento
		// del nuovo reparto
		ArticoloAddMod add = new ArticoloAddMod(this, ArticoloAddMod.ADD);
		add.setVisible(true);

	}

	/**
	 * This method initializes btnDuplica
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnDuplica() {
		if (btnDuplica == null) {
			try {
				btnDuplica = new JButton();
				btnDuplica.setBounds(new Rectangle(195, 5, 80, 26)); // Generated
				btnDuplica.setText("Duplica");
				btnDuplica.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnDuplica;
	}

	/**
	 * This method initializes btnStampa
	 *
	 * @return javax.swing.JButton
	 */
	private JButton getBtnStampa() {
		if (btnStampa == null) {
			try {
				btnStampa = new JButton();
				btnStampa.setBounds(new Rectangle(286, 5, 81, 25)); // Generated
				btnStampa.setText("Stampa");
				btnStampa.addActionListener(new MyActionListener());
			} catch (java.lang.Throwable e) {
				e.printStackTrace();
			}
		}
		return btnStampa;
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
			jPanel.add(getPnlCentrale(), BorderLayout.CENTER);
			jPanel.add(getJPanel1(), BorderLayout.NORTH);
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
			FlowLayout flowLayout = new FlowLayout();
			flowLayout.setAlignment(FlowLayout.LEFT);
			lblFiltroDescrizione = new JLabel();
			lblFiltroDescrizione.setText("descrizione");
			lblFiltroCodice = new JLabel();
			lblFiltroCodice.setText("codice");
			jPanel1 = new JPanel();
			jPanel1.setBorder(BorderFactory.createTitledBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED), "Filtri", TitledBorder.DEFAULT_JUSTIFICATION, TitledBorder.DEFAULT_POSITION, new Font("Dialog", Font.BOLD, 12), new Color(51, 51, 51)));
			jPanel1.setLayout(flowLayout);
			jPanel1.setPreferredSize(new Dimension(0, 60));
			jPanel1.add(lblFiltroCodice, null);
			jPanel1.add(getTxtFiltroCodice(), null);
			jPanel1.add(lblFiltroDescrizione, null);
			jPanel1.add(getTxtFiltroDescrizione(), null);
		}
		return jPanel1;
	}

	/**
	 * This method initializes txtFiltroCodice
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtFiltroCodice() {
		if (txtFiltroCodice == null) {
			txtFiltroCodice = new JTextField();
			txtFiltroCodice.setPreferredSize(new Dimension(150, 20));
			txtFiltroCodice.setDocument(new UpperTextDocument());
			//aggiungo gli ascoltatori
			txtFiltroCodice.getDocument().addDocumentListener(
	                new DocumentListener() {
	                    public void changedUpdate(DocumentEvent e) {
	                        newFilter();
	                    }
	                    public void insertUpdate(DocumentEvent e) {
	                        newFilter();
	                    }
	                    public void removeUpdate(DocumentEvent e) {
	                        newFilter();
	                    }
	                });
		}
		return txtFiltroCodice;
	}


	/**
	 * This method initializes txtFiltroDescrizione
	 *
	 * @return javax.swing.JTextField
	 */
	private JTextField getTxtFiltroDescrizione() {
		if (txtFiltroDescrizione == null) {
			txtFiltroDescrizione = new JTextField();
			txtFiltroDescrizione.setPreferredSize(new Dimension(200, 20));
			txtFiltroDescrizione.setDocument(new UpperTextDocument());
			//aggiungo gli ascoltatori
			txtFiltroDescrizione.getDocument().addDocumentListener(
	                new DocumentListener() {
	                    public void changedUpdate(DocumentEvent e) {
	                        newFilter();
	                    }
	                    public void insertUpdate(DocumentEvent e) {
	                        newFilter();
	                    }
	                    public void removeUpdate(DocumentEvent e) {
	                        newFilter();
	                    }
	                });

		}
		return txtFiltroDescrizione;
	}

//	private void newFilterDescrizione() {
//		RowFilter<ArticoloModel, Object> rf = null;
//        RowFilter<ArticoloModel, Object> rf1 = null;
//        RowFilter<ArticoloModel, Object> rf2 = null;
//
//        //If current expression doesn't parse, don't update.
//        try {
//            rf1 = RowFilter.regexFilter(txtFiltroDescrizione.getText(), 2);
//            rf2 = RowFilter.regexFilter(txtFiltroCodice.getText(), 1);//la X indica la col. Autore nella tabella
//            ArrayList<RowFilter<ArticoloModel,Object>> filters = new ArrayList<RowFilter<ArticoloModel,Object>>(2);
//            filters.add(rf1);
//            filters.add(rf2);
//            rf = RowFilter.andFilter(filters);
//        }
//        catch (java.util.regex.PatternSyntaxException e) {
//            return;
//        }
//        sorter.setRowFilter(rf);
//
//
//
////		RowFilter<ArticoloModel, Object> rf = null;
////
////        //If current expression doesn't parse, don't update.
////        try {
////            rf = RowFilter.regexFilter(txtFiltroDescrizione.getText(), 2);//lo 0 indica la prima colonna
////
////        } catch (java.util.regex.PatternSyntaxException e) {
////            return;
////        }
////        sorter.setRowFilter(rf);
//    }

	private void newFilter() {
		RowFilter<ArticoloModel, Object> rf = null;
        RowFilter<ArticoloModel, Object> rf1 = null;
        RowFilter<ArticoloModel, Object> rf2 = null;

        //If current expression doesn't parse, don't update.
        try {
            rf1 = RowFilter.regexFilter(txtFiltroDescrizione.getText(), 2);
            rf2 = RowFilter.regexFilter(txtFiltroCodice.getText(), 1);//la X indica la col. Autore nella tabella
            ArrayList<RowFilter<ArticoloModel,Object>> filters = new ArrayList<RowFilter<ArticoloModel,Object>>(2);
            filters.add(rf1);
            filters.add(rf2);
            rf = RowFilter.andFilter(filters);
        }
        catch (java.util.regex.PatternSyntaxException e) {
            return;
        }
        sorter.setRowFilter(rf);


//		RowFilter<ArticoloModel, Object> rf = null;
//
//        //If current expression doesn't parse, don't update.
//        try {
//            rf = RowFilter.regexFilter(txtFiltroCodice.getText(), 1);//lo 0 indica la prima colonna
//
//        } catch (java.util.regex.PatternSyntaxException e) {
//            return;
//        }
//        sorter.setRowFilter(rf);
    }


} // @jve:decl-index=0:visual-constraint="10,10"
