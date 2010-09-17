/**
 *
 */
package rf.pegaso.db.model;

import java.sql.SQLException;
import java.util.Vector;

import javax.swing.table.AbstractTableModel;

import rf.pegaso.db.tabelle.DettaglioScarico;
import rf.utility.db.DBEvent;
import rf.utility.db.DBStateChange;
import rf.utility.db.RowEvent;

/**
 * @author Hunter
 *
 */
public class VenditeModel extends AbstractTableModel implements DBStateChange {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private Vector<DettaglioScarico> vendita = null;
	private Vector<String> colonne = null;

	public VenditeModel(Vector<DettaglioScarico> vendita, Vector<String> colonne) throws SQLException {
		this.vendita = vendita;
		this.colonne = colonne;
	}

	public int getColumnCount() {
		return colonne.size();//idArticolo, codiceBarre, descrizione, qta, prezzo, importo, sconto, iva
	}

	@Override
	public String getColumnName(int col) {
		return colonne.get(col);
	}

	public int getRowCount() {
		return vendita.size();
	}

	public String getTableName() {
		return "vendita";
	}

	public Object getValueAt(int r, int c) {
		if ( vendita.size() == 0 )
			return -1;
		DettaglioScarico v = vendita.get(r);
		Vector<Object> v1 = v.trasformaInArrayConPercentualeIva();
		Object o = null;
		o = (Object)v1.get(c);

//		if (o instanceof Double) {
//			Double d = (Double) o;
//			DecimalFormat numberFormatter = new DecimalFormat();
//			numberFormatter.setMaximumFractionDigits(2);
//			numberFormatter.setMinimumFractionDigits(2);
//			return numberFormatter.format(d);
//		}
		return o;
	}

	public boolean isCellEditable(int r, int c) {
		if ( r == 0 && ( c == 1 || c == 2 || c == 4 || c == 9 ))
			return true;
		else if ( c == 4 || c == 9 )
			return true;
		return false;
	}

	public void stateChange() {
		this.fireTableDataChanged();
	}

	public void stateChange(DBEvent arg0) {
		stateChange();

	}

	public Class<?> getColumnClass(int columnIndex) {
		if ( columnIndex == 6 || columnIndex == 7 || columnIndex == 8 )
			return Double.class;
		else if ( columnIndex == 0 || columnIndex == 4 || columnIndex == 5 || columnIndex == 9 || columnIndex == 10 )
			return Integer.class;
//		else if ( columnIndex == 4 )
//			return Long.class;
		else return String.class;
	}

	public void setValueAt(Object o, int r, int c) {
		DettaglioScarico v = vendita.get(r);
		switch(c) {
			/*case 4 :{
//				if( o instanceof Long)
//					v.setQta(new Integer(o));
//				else
					v.setQta((Integer)o);
				break;
			}*/
			case 6 :
				v.setPrezzoVendita((Double)o);
				break;
			case 9 :
				v.setSconto((Integer)o);
				break;
		}
		this.fireTableCellUpdated(r, c);
	}

	public String getNomeTabella() {
		// TODO Auto-generated method stub
		return null;
	}

	public void rowStateChange(RowEvent re) {
		// TODO Auto-generated method stub

	}

}
