package rf.pegaso.gui.vendita.panel;

import it.infolabs.hibernate.Articolo;
import it.infolabs.hibernate.PannelliHome;
import it.infolabs.hibernate.Reparto;
import it.infolabs.hibernate.exception.FindByNotFoundException;

import java.awt.Dimension;
import java.awt.FlowLayout;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.Vector;

import javax.swing.JPanel;

import javax.swing.JScrollPane;

import rf.utility.db.DBEvent;
import rf.utility.db.DBStateChange;
import rf.utility.db.RowEvent;


import java.awt.GridBagLayout;


public class JPanelArticoli extends JPanel implements DBStateChange{

	private static final long serialVersionUID = 1L;
	private Vector<JButtonEventListener> m_Listeners = new Vector<JButtonEventListener>();
	private JScrollPane jScrollPane = null;
	private JPanel pnlPulsanti = null;
	private int width;
	private int ncolonne;
	private long idPannello = -1;

	/**
	 * This is the default constructor
	 */
	public JPanelArticoli(int width) {
		super();
		this.width = width;
		this.ncolonne = width/140;
		initialize();
	}
	
	/**
	 * This is the default constructor
	 */
	public JPanelArticoli() {
		super();
		initialize();
	}

	/**
	 * This method initializes this
	 * 
	 * @return void
	 */
	private void initialize() {
		this.setVisible(true);
		this.add(getJScrollPane(), null);
	}
	
	public void caricaArticoli(LinkedList<Articolo> articoli){
		try{
			pnlPulsanti.removeAll();
			pnlPulsanti.setLayout(new FlowLayout(FlowLayout.LEFT, 5, 5));
			int countWidth = 0, row = 3;
			for (Articolo art : articoli){
				idPannello = art.getPannelli().getIdpannelli();
				JButtonArticolo btnArticolo = new JButtonArticolo(art);
				MyButtonListener btnListener = new MyButtonListener(art);
				btnArticolo.addActionListener(btnListener);
				pnlPulsanti.add(btnArticolo);
				countWidth += btnArticolo.getPreferredSize().width;
				if( countWidth >= (width - 20) ){
					countWidth = 0; row ++;
				}
			}
			int height = (row*100)+(row*10);
			pnlPulsanti.setPreferredSize(new Dimension(width-20, height));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void caricaReparti(LinkedList<Reparto> reparti){
		try{
			pnlPulsanti.removeAll();
			pnlPulsanti.setLayout(new FlowLayout(FlowLayout.LEFT, 5, 5));
			int countWidth = 0, row = 3;
			for (Reparto rep : reparti){
//				idPannello = art.getPannelli().getIdpannelli();
				JButtonArticolo btnReparto = new JButtonArticolo(rep);
				MyButtonListener btnListener = new MyButtonListener(rep);
				btnReparto.addActionListener(btnListener);
				pnlPulsanti.add(btnReparto);
				countWidth += btnReparto.getPreferredSize().width;
				if( countWidth >= (width - 20) ){
					countWidth = 0; row ++;
				}
			}
			int height = (row*100)+(row*10);
			pnlPulsanti.setPreferredSize(new Dimension(width-20, height));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void addJButtonEventListener(JButtonEventListener listener) {
        m_Listeners.add(listener);
    }
    public void removeJButtonEventListener(JButtonEventListener listener) {
        m_Listeners.remove(listener);
    }
	
	private class MyButtonListener implements java.awt.event.ActionListener {

		private Articolo m_articolo;
		
		private Reparto m_reparto;

		public MyButtonListener(Articolo articolo){
			m_articolo = articolo;
		}
		
		public MyButtonListener(Reparto reparto){
			m_reparto = reparto;
		}
		
		public void actionPerformed(java.awt.event.ActionEvent evt) {
	           
            JButtonEvent oEv;
            if(m_articolo != null){
            	oEv = new JButtonEvent(JPanelArticoli.this, '\0', m_articolo);
            }
            else{
            	oEv = new JButtonEvent(JPanelArticoli.this, '\0', m_reparto);
            }
            JButtonEventListener oListener;
            
            for (Enumeration<JButtonEventListener> e = m_Listeners.elements(); e.hasMoreElements();) {
                oListener = (JButtonEventListener) e.nextElement();
                oListener.keyPerformed(oEv);
            }
        }
	}

	/**
	 * This method initializes jScrollPane	
	 * 	
	 * @return javax.swing.JScrollPane	
	 */
	private JScrollPane getJScrollPane() {
		if (jScrollPane == null) {
			jScrollPane = new JScrollPane();
			jScrollPane.setPreferredSize(new Dimension(width, 410));
//			jScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
			jScrollPane.setViewportView(getPnlPulsanti());
		}
		return jScrollPane;
	}

	/**
	 * This method initializes pnlPulsanti	
	 * 	
	 * @return javax.swing.JPanel	
	 */
	private JPanel getPnlPulsanti() {
		if (pnlPulsanti == null) {
			pnlPulsanti = new JPanel();
			pnlPulsanti.setLayout(new GridBagLayout());
		}
		return pnlPulsanti;
	}

	@Override
	public String getNomeTabella() {
		return null;
	}

	@Override
	public void rowStateChange(RowEvent re) {
	}

	@Override
	public void stateChange() {
		if ( idPannello != -1 ){
			PannelliHome.getInstance().begin();
			try {
				caricaArticoli(new LinkedList(PannelliHome.getInstance().findById(idPannello).getArticolos()));
			} catch (FindByNotFoundException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void stateChange(DBEvent dbe) {
		stateChange();
	}
}
