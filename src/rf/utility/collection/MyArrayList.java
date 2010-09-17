package rf.utility.collection;

import java.util.ArrayList;

import rf.pegaso.db.tabelle.DettaglioScarico;

public class MyArrayList extends ArrayList<DettaglioScarico> {

	public MyArrayList() {
		super();
	}
	
	

	@Override
	public boolean contains(Object o) {
		for (DettaglioScarico ord : this) {
			if (ord.getIdArticolo() == ((DettaglioScarico) o).getIdArticolo())
				return true;
		}
		return false;
	}

	@Override
	public int indexOf(Object o) {
		if (o == null) {
			for (int i = 0; i < this.size(); i++)
				if (this.get(i) == null)
					return i;
		} else {
			for (int i = 0; i < this.size(); i++)
				if (((DettaglioScarico) o).getIdArticolo() == this.get(i)
						.getIdArticolo())
					return i;
		}
		return -1;
	}
}