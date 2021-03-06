/**
 *
 */
package rf.pegaso.db.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;

import javax.swing.table.AbstractTableModel;

import rf.pegaso.db.tabelle.Carico;
import rf.utility.ControlloDati;
import rf.utility.db.DBEvent;
import rf.utility.db.DBManager;
import rf.utility.db.DBStateChange;
import rf.utility.db.RowEvent;

/**
 * @author Hunter
 *
 */
public class CaricoModel extends AbstractTableModel implements DBStateChange {

	private DBManager dbm;

	private int idcarico = 0;

	private PreparedStatement pst = null;

	private String query = "";

	private ResultSet rs = null;

	private ResultSetMetaData rsmd = null;

	public CaricoModel(int idcarico) throws SQLException {
		this.dbm = DBManager.getIstanceSingleton();
		this.idcarico = idcarico;
		recuperaDati();

	}

	public int getColumnCount() {
		int nColonne = 0;
		try {
			nColonne = rsmd.getColumnCount();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return nColonne;
	}

	@Override
	public boolean isCellEditable(int r, int c) {
		if (c == 0 || c == 4 || c == 8)
			return false;
		return true;
	}

	@Override
	public Class getColumnClass(int c) {
		if (getRowCount() > 0) {
			if (c == 6 || c == 8)
				return Double.class;
			else if(c==7)
				return Integer.class;
			return getValueAt(0, c).getClass();
		}
		return String.class;

	}

	@Override
	public void setValueAt(Object o, int r, int c) {
		// carichiamo l'articolo in base al codice a barre
		int idArticolo = ((Long) (getValueAt(r, 0))).intValue();
		int idCarico = -1;

		String query = "";
		String query2 = "";
		if (c == 1)
			query = "update articoli set codbarre=? where idarticolo=?";
		else if (c == 2)
			query = "update articoli set descrizione=? where idarticolo=?";
		else if (c == 3)
			query = "update articoli set iva=? where idarticolo=?";
		else if (c == 5)
			query = "update dettaglio_carichi set qta=? where idarticolo=?";
		else if (c == 6) {
			query = "update articoli set prezzo_acquisto=? where idarticolo=?";
			query2 = "update dettaglio_carichi set prezzo_acquisto=? where idcarico=? and idarticolo=?";
		}else if(c==7)
			query = "update dettaglio_carichi set sconto=? where idcarico=? and idarticolo=?";

		PreparedStatement pst = dbm.getNewPreparedStatement(query);
		PreparedStatement pst2 = null;
		try {

			if (c == 6) {
				pst2 = dbm.getNewPreparedStatement(query2);
				pst2.setObject(1, o);
				pst2.setInt(2, this.idcarico);
				pst2.setInt(3, idArticolo);
				pst2.executeUpdate();
				pst2.close();
			}
			if (o instanceof String) {
				// portiamo tutte le lettere in grande
				String s = (String) o;
				s = s.toUpperCase();

				// potrebbe essere anche un double in questo caso proviamo
				// a convertire la stringa in double appunto
				Double d = null;
				try {
					d = ControlloDati.convertPrezzoToDouble((String) o);
				} catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// se d==null vuole dire che il valore di o
				// � una stringa quindi procediamo di conseguenza
				if (d != null) {
					pst.setObject(1, d);
				} else
					pst.setObject(1, s);

			} else
				pst.setObject(1, o);
			if(c==7){
				pst.setInt(2, this.idcarico);
				pst.setInt(3, idArticolo);
				pst.executeUpdate();
			}else {
				pst.setInt(2, idArticolo);
				pst.executeUpdate();
			}

			if(c==5)
			{
				Carico ca=new Carico();
				ca.updateTotDocumentoIvato(this.idcarico);
			}
			pst.close();

			recuperaDati();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public String getColumnName(int col) {
		String nome = "";
		try {
			nome = rsmd.getColumnLabel(col + 1);
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return nome;
	}

	public int getRowCount() {
		if (rs == null)
			return -1;
		int nRighe = 0;
		try {
			rs.last();
			nRighe = rs.getRow();
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return nRighe;
	}

	public String getTableName() {
		return "articoli";
	}

	public Object getValueAt(int r, int c) {
		if (rs == null)
			return -1;

		Object o = null;
		try {
			if (getRowCount() > 0) {
				rs.beforeFirst();
				rs.absolute(r + 1);
				o = rs.getObject(c + 1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (o instanceof Double) {
			Double d = (Double) o;
			DecimalFormat numberFormatter = new DecimalFormat("#,##0.00");
			numberFormatter.setMaximumFractionDigits(2);
			numberFormatter.setMinimumFractionDigits(2);
			return numberFormatter.format(d);
		}
		return o;
	}

	public void stateChange() {
		try {
			recuperaDati();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		this.fireTableDataChanged();

	}

	public void stateChange(DBEvent arg0) {
		stateChange();

	}

	/**
	 * @throws SQLException
	 *
	 */
	private void recuperaDati() throws SQLException {
//		this.query = "select idarticolo,codbarre AS codice,descrizione,iva,um,qta,prezzo_acquisto, (qta*prezzo_acquisto) as totale from articoli_caricati_view where idcarico="
//				+ idcarico + " order by codice";
		this.query = "select idarticolo,codbarre AS codice,descrizione,iva,um,qta,prezzo_acquisto, sconto,(qta*prezzo_acquisto-((qta*prezzo_acquisto)/100*sconto)) as totale from articoli_caricati_view where idcarico="
			+ idcarico + " order by codice";
		pst = dbm.getNewPreparedStatement(query);
		rs = pst.executeQuery();
		rsmd = rs.getMetaData();
		fireTableDataChanged();

	}

	public void reloadModel(int idCarico) throws SQLException {
		this.idcarico=idCarico;
		recuperaDati();

	}

	public String getNomeTabella() {
		// TODO Auto-generated method stub
		return null;
	}

	public void rowStateChange(RowEvent re) {
		// TODO Auto-generated method stub

	}


}
