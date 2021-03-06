//    Openbravo POS is a point of sales application designed for touch screens.
//    Copyright (C) 2007 Openbravo, S.L.
//    http://sourceforge.net/projects/openbravopos
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 2 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

package rf.pegaso.gui.vendita.panel;

import java.util.EventObject;

/**
 *
 * @author adrianromero e shock
 * @version 
 */
public class JNumberEvent extends EventObject {

    private char m_cKey;
    private int m_idArticolo;
    
    public JNumberEvent(Object source, char cKey, int idArticolo) {
        super(source);
        m_cKey = cKey;
        m_idArticolo = idArticolo;
    }
    
    public char getKey() {
        return m_cKey;
    }
    
    public int getIdArticolo(){
    	return m_idArticolo;
    }

}
